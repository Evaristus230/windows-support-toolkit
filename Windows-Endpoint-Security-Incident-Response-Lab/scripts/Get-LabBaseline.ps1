[CmdletBinding()]
param()

# Read-only snapshot for an authorized Windows lab device. Review before use.
$ErrorActionPreference = 'Continue'

Write-Output '=== Windows Endpoint Security Lab: Baseline ==='
Write-Output ("Collected: {0}" -f (Get-Date).ToString('o'))
Write-Output ("Computer: {0} (consider redacting before sharing)" -f $env:COMPUTERNAME)
Write-Output ("PowerShell: {0}" -f $PSVersionTable.PSVersion)

function Write-Section {
    param([string]$Name, [scriptblock]$Query)
    Write-Output "`n--- $Name ---"
    try {
        & $Query | Format-List | Out-String -Width 200 | Write-Output
    } catch {
        Write-Output ("Query unavailable: {0}" -f $_.Exception.Message)
    }
}

Write-Section 'Operating system' {
    Get-CimInstance Win32_OperatingSystem -ErrorAction Stop |
        Select-Object Caption, Version, BuildNumber, LastBootUpTime
}
Write-Section 'Microsoft Defender status' {
    Get-MpComputerStatus -ErrorAction Stop |
        Select-Object AMServiceEnabled, AntivirusEnabled, RealTimeProtectionEnabled,
            BehaviorMonitorEnabled, IoavProtectionEnabled, AntivirusSignatureLastUpdated
}
Write-Section 'Windows Firewall profiles' {
    Get-NetFirewallProfile -ErrorAction Stop |
        Select-Object Name, Enabled, DefaultInboundAction, DefaultOutboundAction
}
Write-Section 'Recently reported hotfixes (up to 10)' {
    Get-HotFix -ErrorAction Stop | Sort-Object InstalledOn -Descending |
        Select-Object -First 10 HotFixID, Description, InstalledOn
}

Write-Output "`nCollection complete. This limited snapshot is not a security certification or compliance audit."
