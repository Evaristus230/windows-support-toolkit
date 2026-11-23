# Bounded Windows event-log review

**Collected:** 2026-11-23, non-elevated PowerShell 7.6.9
**Environment:** Current Windows workstation; not an isolated test VM.
**Window:** 2026-11-22 16:24:02 through 2026-11-23 16:24:02 local time (UTC+01:00)
**Collector:** `scripts/Get-SecurityEventSummary.ps1 -Hours 24`
**Handling:** Raw event messages remain local and private. This report includes counts and timestamps only.

## Results

| Channel | Event IDs queried | Count returned | Time range of matching records |
|---|---|---:|---|
| Security | 4624, 4625, 1102 | 0 total | No matching records returned |
| System | 7045 | 6 | 2026-11-23 06:25–06:49 |
| Microsoft-Windows-Windows Defender/Operational | 1116 | 0 | No matching records returned |
| Microsoft-Windows-Windows Defender/Operational | 1117 | 0 | No matching records returned |
| Microsoft-Windows-Windows Defender/Operational | 5001 | 0 | No matching records returned |
| Microsoft-Windows-Windows Defender/Operational | 5007 | 24 | 2026-11-22 19:10–2026-11-23 16:13 |

The query found six System service-install events and 24 Defender configuration-change events. No Defender detection (1116), action (1117), or real-time-protection-disabled (5001) events matched this query. Event 5007 records a Defender configuration change; it is a signal to check context, not proof of tampering. See [Microsoft's event ID reference](https://learn.microsoft.com/en-us/defender-endpoint/troubleshoot-microsoft-defender-antivirus).

## What this supports

- The specified channels were readable in this session, and the stated IDs returned the counts above for this 24-hour interval.
- The six 7045 records warrant checking service name, executable path, signer, install time, and whether a corresponding software update or installation was expected.
- The 24 event 5007 records warrant checking which settings changed and correlating those changes with Defender updates, policy refreshes, or authorized software activity.

## What this does not prove

- Zero 4624/4625/1102 matches do not prove there were no sign-ins or failed sign-ins. This is a bounded ID query; audit settings, retention, and filtering affect what is available.
- Zero 1116/1117/5001 matches do not establish that the endpoint is fully protected or free from threats.
- Counts for 7045 and 5007 do not show whether the changes were expected or malicious. The event details and approved change history must be reviewed before classification.
- This query is not continuous monitoring or a complete incident investigation. It did not examine event messages in this public report.

## Review outcome

No incident is asserted from these counts alone. The next authorized review would inspect the six service-install records and the Defender 5007 old/new values locally, compare them with expected installations and policy changes, and escalate unexplained changes to the appropriate security owner. No settings or protections were changed during collection.
