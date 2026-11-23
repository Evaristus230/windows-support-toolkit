# Windows Support Toolkit

A PowerShell diagnostic that gathers the information a help-desk technician
normally collects one command at a time, and turns it into a single HTML report
you can attach to a ticket.

Read-only. It inspects the machine; it never changes anything.

![PowerShell](https://img.shields.io/badge/PowerShell-5.1%20%7C%207-5391FE)
![Platform](https://img.shields.io/badge/platform-Windows-0078D4)

---

## Why

When a user says *"my PC is slow"*, the useful questions are always the same:
how much disk is left, what is failing to start, what is erroring in the event
log, when was it last patched, what is eating the memory. Getting those answers
means six different commands and a lot of scrolling.

This script runs all of them, judges the results, and writes a report with a
clear overall status: `OK`, `Warning` or `Critical`.

## What it checks

| Check | Source |
|---|---|
| OS, build, model, serial, RAM, uptime | `Win32_OperatingSystem`, `Win32_ComputerSystem`, `Win32_BIOS` |
| Free space per volume, with 80% / 90% thresholds | `Win32_LogicalDisk` |
| Services set to Automatic that are not running | `Get-Service` |
| Errors and critical events from System + Application logs | `Get-WinEvent` |
| Network configuration (IP, gateway, DNS) | `Get-NetIPConfiguration` |
| Recently installed updates | `Get-HotFix` |
| Top processes by memory | `Get-Process` |
| Installed software | Uninstall registry keys |

## Requirements

- Windows 10 / 11 or Windows Server
- PowerShell 5.1 (built in) or PowerShell 7+
- No administrator rights needed, no modules to install

## Usage

```powershell
# Default: 7 days of event history, writes to .\reports
.\Get-SystemHealthReport.ps1

# Shorter window, custom output folder
.\Get-SystemHealthReport.ps1 -OutputPath C:\Temp\reports -Days 3

# Skip the registry scan on slow machines
.\Get-SystemHealthReport.ps1 -SkipSoftware
```

Two files are written per run, timestamped so runs never overwrite each other:

```
reports/health-report-20261122-063721.html   <- open this in a browser
reports/health-report-20261122-063721.json   <- same data, for parsing
```

## Sample output

Real output from a Windows 11 Pro machine:

```
Collecting system information...

Overall status : Warning
  [Warning] Automatic services not running - 6 service(s) set to start automatically are stopped
  [Warning] High error volume - 68 error/critical events in the last 7 day(s)

HTML : .\reports\health-report-20261122-063721.html
JSON : .\reports\health-report-20261122-063721.json
```

The HTML report contains a status banner, a findings table, and then the raw
detail for each section - disk, services, event log, network, updates,
processes and software.

## How the scoring works

Each check produces a finding with a status:

- **Critical** - a disk is over 90% full, or critical-level events were logged
- **Warning** - a disk is over 80% full, an automatic service is stopped,
  uptime exceeds 30 days, or more than 20 errors were logged
- **OK** - nothing found

The overall status is the worst finding. A machine with no findings reports
`No issues detected`.

## Design notes

- Every collector is wrapped in a `Get-Safe` helper, so one failing query (for
  example a WMI class that does not exist on a given build) degrades to "no
  data" instead of killing the whole report.
- Software inventory reads the registry rather than calling `Win32_Product`.
  `Win32_Product` triggers a consistency check on every installed MSI and is
  well known for being slow and for writing to application logs.
- The event log query uses `-FilterHashtable` with a server-side filter
  (level and time), so only matching events are pulled back.
- The Security log is deliberately excluded: reading it requires administrator
  rights, and this script is meant to run as a normal user.

## Privacy and report handling

The HTML and JSON reports can contain a computer name, hardware model and serial number, IP addresses, gateway/DNS details, installed software, running process names, service state, and recent event-log message text. Treat reports as internal diagnostic data: save them only in an approved private ticket or lab location, review and redact them before sending outside your organization, and never commit raw reports to a public repository. The generated `reports/` directory is ignored by Git by default.

## Limitations

- Windows only.
- The report reflects the moment it was taken; it is not a monitoring tool.
- Event log messages are truncated to the first line for readability.

## License

MIT

## Endpoint security and incident response lab

This repository also includes a guided, read-only [Windows Endpoint Security, Monitoring & Incident Response Lab](Windows-Endpoint-Security-Incident-Response-Lab/README.md). It covers a limited Windows baseline, bounded event log review, a fictional suspicious sign-in tabletop, evidence handling, and interview preparation.

The lab is clearly marked as training material: its tabletop is fictional, and its scripts do not change system settings. Do not treat a small local snapshot as a security certification or claim hands-on results until you have collected them on an authorized test device. Start with the [lab guide](Windows-Endpoint-Security-Incident-Response-Lab/docs/01-lab-guide.md) and use the [five-minute interview demo](Windows-Endpoint-Security-Incident-Response-Lab/docs/05-interview-demo-walkthrough.md) after completing the exercises.

## Cross-platform IT support lab

A local-only practice dashboard for Windows, Ubuntu Linux, and AWS access troubleshooting. Its fictional case studies use read-only evidence examples, explicit escalation decisions, interview notes, and illustrative dashboard previews. No live incidents or AWS account are represented. Start at [the lab guide](Cross-Platform-IT-Support-Lab/README.md) or open the [interactive demo](Cross-Platform-IT-Support-Lab/index.html).
