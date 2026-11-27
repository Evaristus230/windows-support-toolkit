# Windows Support Toolkit

A small portfolio repository for entry-level IT support practice. It contains one Windows diagnostic script and two separate guided labs. The repository distinguishes live, sanitized observations from fictional practice scenarios.

## Start here

1. [Run the Windows health report](#windows-health-report)
2. [Browse the project map](PROJECT-MAP.md)
3. [Open the cross-platform ticket lab](Cross-Platform-IT-Support-Lab/README.md)
4. [Open the Windows security lab](Windows-Endpoint-Security-Incident-Response-Lab/README.md)

## Windows health report

`Get-SystemHealthReport.ps1` collects a point-in-time set of Windows health details and writes HTML and JSON reports. It is designed to read system state and not change settings.

### Requirements

- Windows 10/11 or Windows Server
- PowerShell 5.1 or 7+
- No extra modules; standard-user permissions are sufficient for the documented checks

### Run

```powershell
# Run from the repository root; default window is seven days
.\Get-SystemHealthReport.ps1

# Limit the event-log window and choose an output folder
.\Get-SystemHealthReport.ps1 -Days 3 -OutputPath C:\Temp\reports

# Omit software inventory
.\Get-SystemHealthReport.ps1 -SkipSoftware
```

Reports are written to `reports/` by default and are excluded from Git. Review [privacy and handling](#privacy-and-safe-use) before sharing any output.

### Collection scope

| Area | Data collected |
|---|---|
| Device | Windows version/build, model, serial, memory and uptime |
| Storage | Fixed-volume capacity and free space |
| Services | Automatically configured services that are stopped |
| Event logs | Recent Error/Critical events from System and Application channels |
| Network | IP configuration, gateways and DNS servers |
| Updates | Records returned by `Get-HotFix` |
| Processes | Highest memory-use processes |
| Software | Installed-software entries from uninstall registry keys |

The script summarizes these checks with `OK`, `Warning`, or `Critical` labels using documented thresholds. These are triage hints, not diagnoses or compliance decisions. A stopped automatic service or event-log error can be expected; verify context before recommending action.

## Guided labs

### Cross-platform IT support

A local dashboard and fictional practice tickets for Windows, Linux and AWS access troubleshooting. Follow the [lab guide](Cross-Platform-IT-Support-Lab/README.md); open its [dashboard](Cross-Platform-IT-Support-Lab/index.html) locally. It does not connect to AWS or represent real customer tickets.

### Windows endpoint security

A read-only baseline and bounded event-review exercise plus a fictional incident tabletop. Follow the [lab guide](Windows-Endpoint-Security-Incident-Response-Lab/README.md). The evidence folder separates local observations from simulated tabletop records.

## Repository map

```text
.
├── Get-SystemHealthReport.ps1
├── README.md
├── PROJECT-MAP.md
├── Cross-Platform-IT-Support-Lab/
│   ├── README.md
│   ├── index.html
│   ├── docs/          # Interview walkthrough
│   ├── scenarios/     # Fictional tickets
│   ├── scripts/       # Read-only evidence examples
│   └── screenshots/   # Illustrative dashboard previews
└── Windows-Endpoint-Security-Incident-Response-Lab/
    ├── README.md
    ├── docs/          # Runbook and interview notes
    ├── scenarios/     # Fictional tabletop
    ├── scripts/       # Read-only collectors
    ├── evidence/      # Sanitized observations and tabletop records
    └── templates/     # Reusable records
```

See [PROJECT-MAP.md](PROJECT-MAP.md) for the recommended reading sequence and evidence guide.

## Privacy and safe use

The health report may include host identifiers, serial number, IP/network details, software inventory, process names, and event messages. Treat generated reports as sensitive operational data: inspect and redact them before sharing, store them only in an approved private location, and do not commit raw reports. The repository ignores the default `reports/` output folder.

Review scripts before use and run them only on systems you own or are authorized to inspect. The collectors are intended to be read-only. The interactive scenarios and screenshots are fictional or illustrative; they are not evidence of production work. Do not infer a security incident from event counts alone.

## Evidence standard

- **Observed:** Sanitized, dated results collected from one workstation. These are point-in-time snapshots, with method and limitations documented in the security lab.
- **Simulated:** Written scenarios and dashboard cases. They demonstrate reasoning practice, not investigations of real users or systems.
- **Not established:** The project does not claim enterprise deployment, continuous monitoring, compliance certification, or production incident response.

## License

MIT. See [LICENSE](LICENSE).

See [validation notes](VALIDATION.md) for the restricted Windows smoke check.
