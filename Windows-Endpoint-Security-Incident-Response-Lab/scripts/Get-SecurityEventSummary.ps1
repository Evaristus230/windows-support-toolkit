[CmdletBinding()]
param(
    [ValidateRange(1, 168)]
    [int]$Hours = 24,
    [ValidateRange(1, 500)]
    [int]$MaxEventsPerChannel = 100
)

# Read-only, bounded event summary. It does not enable auditing or change logs.
$ErrorActionPreference = 'Continue'
$startTime = (Get-Date).AddHours(-$Hours)
$queries = @(
    @{ LogName = 'Security'; Id = @(4624, 4625, 1102) },
    @{ LogName = 'System'; Id = @(7045) },
    @{ LogName = 'Microsoft-Windows-Windows Defender/Operational'; Id = @(1116, 1117, 5001, 5007) }
)

Write-Output ("Event summary window: {0} through {1} (local time; {2} hours)" -f $startTime, (Get-Date), $Hours)
foreach ($query in $queries) {
    Write-Output "`n--- $($query.LogName) | IDs $($query.Id -join ', ') ---"
    try {
        $events = @(Get-WinEvent -FilterHashtable @{
            LogName = $query.LogName
            Id = $query.Id
            StartTime = $startTime
        } -MaxEvents $MaxEventsPerChannel -ErrorAction Stop)
        if ($events.Count -eq 0) {
            Write-Output 'No matching records returned.'
            continue
        }
        $events | Select-Object -First $MaxEventsPerChannel TimeCreated, Id, ProviderName,
            @{Name='MessagePreview'; Expression={
                $message = ($_.Message -replace '\s+', ' ').Trim()
                if ($message.Length -gt 240) { $message.Substring(0, 240) + '…' } else { $message }
            }} | Format-Table -Wrap -AutoSize | Out-String -Width 240 | Write-Output
        Write-Output ("Records displayed: {0} (maximum per channel: {1})" -f [Math]::Min($events.Count, $MaxEventsPerChannel), $MaxEventsPerChannel)
    } catch {
        if ($_.FullyQualifiedErrorId -like 'NoMatchingEventsFound*') {
            Write-Output 'No matching records returned.'
        } else {
            Write-Output ("Channel unavailable or access denied: {0}" -f $_.Exception.Message)
        }
    }
}

Write-Output "`nThis summary is not a complete investigation. Validate event context and logging coverage before drawing conclusions."
