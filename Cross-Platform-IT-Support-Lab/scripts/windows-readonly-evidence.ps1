# Read-only Windows evidence example
# Prints selected inventory and network information. Makes no configuration changes.
# Review policy and redact identifying information before sharing output.

$ErrorActionPreference = 'Continue'
Write-Output '=== Operating system ==='
Get-CimInstance Win32_OperatingSystem | Select-Object Caption, Version, BuildNumber, LastBootUpTime
Write-Output "`n=== File-system drive capacity ==="
Get-PSDrive -PSProvider FileSystem | Select-Object Name, Used, Free
Write-Output "`n=== Network adapter state ==="
Get-NetAdapter -ErrorAction SilentlyContinue | Select-Object Name, Status, LinkSpeed
Write-Output "`n=== IP configuration summary ==="
Get-NetIPConfiguration -ErrorAction SilentlyContinue | Select-Object InterfaceAlias, IPv4Address, IPv4DefaultGateway, DNSServer
Write-Output "`nReview output for usernames, hostnames, addresses and paths before sharing."
