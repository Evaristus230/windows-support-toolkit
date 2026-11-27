<#
.SYNOPSIS
    Collects Windows health and support data and writes an HTML + JSON report.

.DESCRIPTION
    A help-desk style diagnostic. Gathers the information a support technician
    normally asks for one command at a time (uptime, disk space, stopped
    services, recent errors, installed software, network config) and produces a
    single report you can attach to a ticket.

    Read-only: it changes nothing on the machine.

.PARAMETER OutputPath
    Folder to write the report into. Created if it does not exist.

.PARAMETER Days
    How many days of event log history to include. Default 7.

.PARAMETER SkipSoftware
    Skip the installed-software inventory (it reads the registry and can take a
    few seconds on machines with many applications).

.EXAMPLE
    .\Get-SystemHealthReport.ps1

.EXAMPLE
    .\Get-SystemHealthReport.ps1 -OutputPath C:\Temp\reports -Days 3
#>
[CmdletBinding()]
param(
    [string]$OutputPath = (Join-Path (Get-Location) 'reports'),
    [ValidateRange(1, 90)]
    [int]$Days = 7,
    [switch]$SkipSoftware
)

$ErrorActionPreference = 'Stop'

# --------------------------------------------------------------------------
# Helpers
# --------------------------------------------------------------------------

function New-Section {
    param([string]$Name, [string]$Status = 'OK', [string]$Note = '')
    [pscustomobject]@{ Name = $Name; Status = $Status; Note = $Note }
}

$collectorFailures = [System.Collections.Generic.List[string]]::new()

function Get-Safe {
    <#
        Runs a script block and returns its output, or $null if it throws.
        Every collector is wrapped so one failing query cannot kill the report.
    #>
    param([scriptblock]$Block)
    try { $ErrorActionPreference = 'Stop'; & $Block }
    catch {
        if ($_.FullyQualifiedErrorId -like 'NoMatchingEventsFound,*') { return }
        $collectorFailures.Add([string]$_.CategoryInfo.Activity)
        Write-Verbose ("Collector failed: {0}" -f $_.Exception.Message)
        $null
    }
}

function Format-Bytes {
    param([double]$Bytes)
    if ($Bytes -ge 1GB) { '{0:N1} GB' -f ($Bytes / 1GB) }
    elseif ($Bytes -ge 1MB) { '{0:N1} MB' -f ($Bytes / 1MB) }
    else { '{0:N0} KB' -f ($Bytes / 1KB) }
}

# --------------------------------------------------------------------------
# Collect
# --------------------------------------------------------------------------

Write-Host 'Collecting system information...' -ForegroundColor Cyan

$os = Get-Safe { Get-CimInstance -ClassName Win32_OperatingSystem }
$cs = Get-Safe { Get-CimInstance -ClassName Win32_ComputerSystem }
$bios = Get-Safe { Get-CimInstance -ClassName Win32_BIOS }

$uptime = if ($os) { (Get-Date) - $os.LastBootUpTime } else { $null }

$disks = Get-Safe {
    Get-CimInstance -ClassName Win32_LogicalDisk -Filter 'DriveType=3' | ForEach-Object {
        $usedPct = if ($_.Size -gt 0) { [math]::Round((($_.Size - $_.FreeSpace) / $_.Size) * 100, 1) } else { 0 }
        [pscustomobject]@{
            Drive      = $_.DeviceID
            Label      = $_.VolumeName
            SizeGB     = [math]::Round($_.Size / 1GB, 1)
            FreeGB     = [math]::Round($_.FreeSpace / 1GB, 1)
            UsedPct    = $usedPct
            Status     = if ($usedPct -ge 90) { 'Critical' } elseif ($usedPct -ge 80) { 'Warning' } else { 'OK' }
        }
    }
}

$stoppedServices = Get-Safe {
    Get-Service |
        Where-Object { $_.StartType -eq 'Automatic' -and $_.Status -ne 'Running' } |
        Sort-Object Name |
        Select-Object Name, DisplayName, Status, StartType
}

$recentErrors = Get-Safe {
    $since = (Get-Date).AddDays(-$Days)
    Get-WinEvent -FilterHashtable @{
        LogName   = 'System', 'Application'
        Level     = 1, 2
        StartTime = $since
    } -MaxEvents 100 -ErrorAction Stop |
        Select-Object TimeCreated, LogName, ProviderName, Id, LevelDisplayName, Message
}

$software = if ($SkipSoftware) { @() } else {
    Get-Safe {
        $paths = @(
            'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*',
            'HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*'
        )
        Get-ItemProperty $paths -ErrorAction SilentlyContinue |
            Where-Object {
                $_.DisplayName -and
                $_.DisplayName.Trim() -ne '' -and
                -not ($_.PSObject.Properties['SystemComponent'] -and $_.PSObject.Properties['SystemComponent'].Value -eq 1)
            } |
            Select-Object DisplayName, DisplayVersion, Publisher, InstallDate |
            Sort-Object DisplayName -Unique
    }
}

$network = Get-Safe {
    Get-NetIPConfiguration | Where-Object { $_.IPv4Address } | ForEach-Object {
        [pscustomobject]@{
            Interface = $_.InterfaceAlias
            IPv4      = ($_.IPv4Address.IPAddress -join ', ')
            Gateway   = ($_.IPv4DefaultGateway.NextHop -join ', ')
            DNS       = ($_.DNSServer.ServerAddresses -join ', ')
        }
    }
}

$hotfixes = Get-Safe {
    Get-HotFix | Sort-Object InstalledOn -Descending | Select-Object -First 5 HotFixID, Description, InstalledOn
}

$topMemory = Get-Safe {
    Get-Process | Sort-Object WorkingSet64 -Descending | Select-Object -First 10 `
        ProcessName, Id,
        @{ n = 'MemoryMB'; e = { [math]::Round($_.WorkingSet64 / 1MB, 1) } }
}

# --------------------------------------------------------------------------
# Evaluate - turn raw data into plain-language findings
# --------------------------------------------------------------------------

$findings = [System.Collections.Generic.List[object]]::new()

foreach ($d in $disks) {
    if ($d.Status -eq 'Critical') {
        $findings.Add((New-Section "Low disk space on $($d.Drive)" 'Critical' "$($d.FreeGB) GB free ($($d.UsedPct)% used)"))
    }
    elseif ($d.Status -eq 'Warning') {
        $findings.Add((New-Section "Disk filling up on $($d.Drive)" 'Warning' "$($d.FreeGB) GB free ($($d.UsedPct)% used)"))
    }
}

if ($stoppedServices -and $stoppedServices.Count -gt 0) {
    $findings.Add((New-Section 'Automatic services not running' 'Warning' "$($stoppedServices.Count) service(s) set to start automatically are stopped"))
}

if ($uptime -and $uptime.TotalDays -ge 30) {
    $findings.Add((New-Section 'Long uptime' 'Warning' ('{0:N0} days since last boot - pending updates may need a restart' -f $uptime.TotalDays)))
}

if ($recentErrors -and $recentErrors.Count -ge 20) {
    $findings.Add((New-Section 'High error volume' 'Warning' "$($recentErrors.Count) error/critical events in the last $Days day(s)"))
}

$criticalCount = @($recentErrors | Where-Object { $_.LevelDisplayName -eq 'Critical' }).Count
if ($criticalCount -gt 0) {
    $findings.Add((New-Section 'Critical events logged' 'Critical' "$criticalCount critical event(s) in the last $Days day(s)"))
}

if ($collectorFailures.Count -gt 0 -or -not $os -or -not $disks -or -not $network) {
    $findings.Add((New-Section 'Incomplete collection' 'Warning' 'One or more queries failed or expected baseline data was missing. Review available results before drawing conclusions.'))
}

if ($findings.Count -eq 0) {
    $findings.Add((New-Section 'No issues detected' 'OK' 'No warning or critical findings in the collected data'))
}

$overall = if ($findings.Status -contains 'Critical') { 'Critical' }
           elseif ($findings.Status -contains 'Warning') { 'Warning' }
           else { 'OK' }

# --------------------------------------------------------------------------
# HTML
# --------------------------------------------------------------------------

function ConvertTo-HtmlTable {
    param($Data, [string[]]$Columns)

    if (-not $Data -or @($Data).Count -eq 0) {
        return '<p class="muted">No data.</p>'
    }

    $rows = foreach ($item in $Data) {
        $cells = foreach ($col in $Columns) {
            $value = $item.$col
            if ($null -eq $value) { '' } else { [System.Net.WebUtility]::HtmlEncode([string]$value) }
        }
        '<tr>' + (($cells | ForEach-Object { "<td>$_</td>" }) -join '') + '</tr>'
    }

    $head = ($Columns | ForEach-Object { "<th>$_</th>" }) -join ''
    "<table><thead><tr>$head</tr></thead><tbody>$($rows -join '')</tbody></table>"
}

function Get-StatusClass {
    param([string]$Status)
    switch ($Status) {
        'Critical' { 'crit' }
        'Warning'  { 'warn' }
        default    { 'ok' }
    }
}

function ConvertTo-HtmlText {
    param([AllowNull()][object]$Value)
    if ($null -eq $Value) { return '' }
    [System.Net.WebUtility]::HtmlEncode([string]$Value)
}

# Encode every machine-derived value before inserting it into the HTML document.
$computerName = ConvertTo-HtmlText $(if ($env:COMPUTERNAME) { $env:COMPUTERNAME } else { 'unknown' })
$generated = ConvertTo-HtmlText (Get-Date -Format 'yyyy-MM-dd HH:mm:ss')
$osCaption = ConvertTo-HtmlText $(if ($os) { $os.Caption } else { 'Unknown OS' })
$osVersion = ConvertTo-HtmlText $(if ($os) { "$($os.Version) (build $($os.BuildNumber))" } else { '' })
$uptimeText = ConvertTo-HtmlText $(if ($uptime) { '{0} days {1} hours' -f [math]::Floor($uptime.TotalDays), $uptime.Hours } else { 'Unknown' })
$model = ConvertTo-HtmlText $(if ($cs) { "$($cs.Manufacturer) $($cs.Model)" } else { 'Unknown' })
$serial = ConvertTo-HtmlText $(if ($bios) { $bios.SerialNumber } else { '' })
$totalRam = ConvertTo-HtmlText $(if ($cs) { '{0:N1} GB' -f ($cs.TotalPhysicalMemory / 1GB) } else { 'Unknown' })

$findingRows = ($findings | ForEach-Object {
    "<tr class='$(Get-StatusClass $_.Status)'><td>$($_.Status)</td><td>$([System.Net.WebUtility]::HtmlEncode($_.Name))</td><td>$([System.Net.WebUtility]::HtmlEncode($_.Note))</td></tr>"
}) -join ''

$errorRows = if ($recentErrors) {
    ($recentErrors | Select-Object -First 40 | ForEach-Object {
        $msg = ($_.Message -split "`n")[0]
        if ($msg.Length -gt 160) { $msg = $msg.Substring(0, 160) + '...' }
        "<tr><td>$($_.TimeCreated.ToString('yyyy-MM-dd HH:mm'))</td><td>$([System.Net.WebUtility]::HtmlEncode($_.LogName))</td><td>$([System.Net.WebUtility]::HtmlEncode($_.ProviderName))</td><td>$($_.Id)</td><td>$([System.Net.WebUtility]::HtmlEncode($msg))</td></tr>"
    }) -join ''
} else { '' }

$html = @"
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>System Health Report - $computerName</title>
<style>
  :root { --ok:#1a7f37; --warn:#9a6700; --crit:#cf222e; --line:#d8dee4; --ink:#1f2328; }
  * { box-sizing: border-box; }
  body { font-family: "Segoe UI", system-ui, sans-serif; margin: 0; padding: 32px;
         color: var(--ink); background: #f6f8fa; }
  .wrap { max-width: 1080px; margin: 0 auto; background: #fff; border: 1px solid var(--line);
          border-radius: 8px; padding: 32px; }
  h1 { margin: 0 0 4px; font-size: 22px; }
  h2 { font-size: 15px; text-transform: uppercase; letter-spacing: .06em;
       border-bottom: 1px solid var(--line); padding-bottom: 6px; margin: 32px 0 12px; }
  .sub { color: #57606a; font-size: 13px; margin-bottom: 24px; }
  .banner { padding: 12px 16px; border-radius: 6px; font-weight: 600; margin-bottom: 24px; }
  .banner.ok   { background: #dafbe1; color: var(--ok); }
  .banner.warn { background: #fff8c5; color: var(--warn); }
  .banner.crit { background: #ffebe9; color: var(--crit); }
  table { width: 100%; border-collapse: collapse; font-size: 13px; }
  th, td { text-align: left; padding: 7px 10px; border-bottom: 1px solid var(--line); vertical-align: top; }
  th { background: #f6f8fa; font-weight: 600; }
  tr.crit td:first-child { color: var(--crit); font-weight: 600; }
  tr.warn td:first-child { color: var(--warn); font-weight: 600; }
  tr.ok   td:first-child { color: var(--ok);   font-weight: 600; }
  .muted { color: #57606a; font-size: 13px; }
  .kv { display: grid; grid-template-columns: 180px 1fr; gap: 6px 16px; font-size: 13px; }
  .kv dt { color: #57606a; }
  .kv dd { margin: 0; }
  footer { margin-top: 32px; color: #57606a; font-size: 12px; }
</style>
</head>
<body>
<div class="wrap">
  <h1>System Health Report</h1>
  <div class="sub">$computerName &middot; generated $generated</div>

  <div class="banner $(Get-StatusClass $overall)">
    Overall status: $overall
  </div>

  <h2>System</h2>
  <dl class="kv">
    <dt>Computer name</dt><dd>$computerName</dd>
    <dt>Operating system</dt><dd>$osCaption</dd>
    <dt>Version</dt><dd>$osVersion</dd>
    <dt>Model</dt><dd>$model</dd>
    <dt>Serial number</dt><dd>$serial</dd>
    <dt>Memory</dt><dd>$totalRam</dd>
    <dt>Uptime</dt><dd>$uptimeText</dd>
  </dl>

  <h2>Findings</h2>
  <table>
    <thead><tr><th style="width:90px">Status</th><th style="width:320px">Check</th><th>Detail</th></tr></thead>
    <tbody>$findingRows</tbody>
  </table>

  <h2>Disk space</h2>
  $(ConvertTo-HtmlTable -Data $disks -Columns 'Drive','Label','SizeGB','FreeGB','UsedPct','Status')

  <h2>Automatic services not running</h2>
  $(ConvertTo-HtmlTable -Data $stoppedServices -Columns 'Name','DisplayName','Status','StartType')

  <h2>Recent errors and critical events (last $Days days)</h2>
  <table>
    <thead><tr><th style="width:130px">Time</th><th style="width:100px">Log</th><th>Source</th><th style="width:60px">ID</th><th>Message</th></tr></thead>
    <tbody>$errorRows</tbody>
  </table>

  <h2>Network</h2>
  $(ConvertTo-HtmlTable -Data $network -Columns 'Interface','IPv4','Gateway','DNS')

  <h2>Recent updates</h2>
  $(ConvertTo-HtmlTable -Data $hotfixes -Columns 'HotFixID','Description','InstalledOn')

  <h2>Top processes by memory</h2>
  $(ConvertTo-HtmlTable -Data $topMemory -Columns 'ProcessName','Id','MemoryMB')

  <h2>Installed software</h2>
  $(ConvertTo-HtmlTable -Data $software -Columns 'DisplayName','DisplayVersion','Publisher','InstallDate')

  <footer>Generated by Get-SystemHealthReport.ps1 &middot; read-only diagnostic</footer>
</div>
</body>
</html>
"@

# --------------------------------------------------------------------------
# Write
# --------------------------------------------------------------------------

if (-not (Test-Path -LiteralPath $OutputPath)) {
    New-Item -ItemType Directory -Path $OutputPath -Force | Out-Null
}

$stamp = Get-Date -Format 'yyyyMMdd-HHmmss'
$htmlPath = Join-Path $OutputPath "health-report-$stamp.html"
$jsonPath = Join-Path $OutputPath "health-report-$stamp.json"

$html | Set-Content -LiteralPath $htmlPath -Encoding utf8

[pscustomobject]@{
    Generated   = $generated
    Computer    = $computerName
    Overall     = $overall
    Findings    = $findings
    Disks       = $disks
    Services    = $stoppedServices
    ErrorCount  = @($recentErrors).Count
    Network     = $network
    Hotfixes    = $hotfixes
    Software    = $software
} | ConvertTo-Json -Depth 6 | Set-Content -LiteralPath $jsonPath -Encoding utf8

Write-Host ''
Write-Host ("Overall status : {0}" -f $overall) -ForegroundColor $(
    switch ($overall) { 'Critical' { 'Red' } 'Warning' { 'Yellow' } default { 'Green' } }
)
foreach ($f in $findings) {
    Write-Host ("  [{0}] {1} - {2}" -f $f.Status, $f.Name, $f.Note)
}
Write-Host ''
Write-Host ("HTML : {0}" -f $htmlPath) -ForegroundColor Cyan
Write-Host ("JSON : {0}" -f $jsonPath) -ForegroundColor Cyan


