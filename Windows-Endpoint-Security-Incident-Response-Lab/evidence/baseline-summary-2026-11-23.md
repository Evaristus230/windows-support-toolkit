# Sanitized Windows baseline summary

**Collected:** 2026-11-23 16:23 local time (UTC+01:00)
**Environment:** Current Windows workstation; not an isolated test VM.
**Privilege:** Non-elevated PowerShell 7.6.9.
**Collector:** `scripts/Get-LabBaseline.ps1`
**Handling:** Raw output is kept in a private local work folder. Hostname, username, serial number, and other device identifiers are omitted from this public summary.

## Results

| Check | Sanitized result | Interpretation limit |
|---|---|---|
| Operating system | Windows 11 Pro, version 10.0.26300, build 26300 | Point-in-time OS identification; not an update-compliance assessment |
| Defender service and antivirus | Service, antivirus, real-time protection, behavior monitoring, and IOAV protection all reported enabled | A status snapshot does not prove policy compliance or continuous protection |
| Defender signatures | Last update reported 2026-11-17 01:17 local time | Timestamp only; not a full signature or service health assessment |
| Firewall profiles | Domain, Private, and Public profiles reported enabled | The returned default inbound/outbound actions were `NotConfigured`; this alone does not determine effective policy or traffic exposure |
| Installed updates | Five hotfix records returned; newest installation date reported as 2026-10-18 | `Get-HotFix` is a partial view and cannot certify patch compliance |

## Method and limits

The script completed its four read-only sections without query-access errors in this non-elevated session. It did not change settings. This baseline describes one workstation at one time; it is not a security certification, compliance audit, or substitute for centrally managed endpoint telemetry. No screenshot or raw output is included because those contain device-specific details.
