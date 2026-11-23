# Baseline and monitoring notes

## Baseline worksheet

Copy this into your lab notes and fill it from your authorized test environment.

| Area | What to record | Evidence / limitation |
|---|---|---|
| Device | Windows edition, version, build; collection date | Do not publish real serial numbers or device names |
| Protection | Defender availability and real-time monitoring status, if accessible | A status snapshot is not a full health or policy audit |
| Firewall | Profile state for Domain, Private, and Public, where present | Record inaccessible profiles; do not change them |
| Updates | Most recent installed hotfix visible to the query | This is not a complete update compliance assessment |
| Recent security signals | Count and selected metadata for events in queried window | Event retention and permissions affect results |
| Limitations | Elevated/non-elevated session, inaccessible channels, time window | State these explicitly in the portfolio |

## Read-only verification commands

Run only on a system you are authorized to inspect. Review output before sharing.

```powershell
# Defender status (availability and property names can vary by Windows edition).
Get-MpComputerStatus |
  Select-Object AMServiceEnabled, AntivirusEnabled, RealTimeProtectionEnabled,
    BehaviorMonitorEnabled, IoavProtectionEnabled, AntivirusSignatureLastUpdated

# Windows Firewall profile state.
Get-NetFirewallProfile |
  Select-Object Name, Enabled, DefaultInboundAction, DefaultOutboundAction

# Recent installed hotfix metadata; this does not establish patch compliance.
Get-HotFix | Sort-Object InstalledOn -Descending |
  Select-Object -First 10 HotFixID, Description, InstalledOn

# Operating system version and build.
Get-CimInstance Win32_OperatingSystem |
  Select-Object Caption, Version, BuildNumber, LastBootUpTime
```

The supplied baseline script collects similar fields and handles individual query failures so one unavailable provider does not stop the whole report.

## Event review approach

Use a defined time range and a small question. Examples: “Were there failed logons in this 24-hour window?” or “Did Defender record detections?” Check that the relevant audit policy and log channel are enabled before interpreting an absence of events; this starter project does not change either.

Common examples to recognize (IDs may differ by provider and logging configuration):

- **Security 4624 / 4625:** successful / failed logon events. Review logon type, account, source, and nearby records; a failed logon alone is not proof of compromise.
- **Security 1102:** Security audit log cleared. Treat as a signal requiring context and escalation.
- **System 7045:** service installed. Validate service name, path, account, timing, and change records.
- **Microsoft-Windows-Windows Defender/Operational:** protection and detection events; correlate the event message, time, and Defender status.

The event summary script queries a small allowlist of channels and event IDs over a bounded time period. It returns selected metadata and a message preview. Review the source before running, and do not share raw messages that may contain personal data.

## How to report a finding

For every item, state: **observation** (what the source showed), **interpretation** (what it may mean), **confidence** (high/medium/low and why), and **next check**. Avoid describing an event as malicious without corroboration.
