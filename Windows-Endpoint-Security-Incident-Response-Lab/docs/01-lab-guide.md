# Lab guide

## Environment

Use a Windows 10/11 test VM or a device you are authorized to inspect. A standard, non-elevated PowerShell session is sufficient for the initial collection. Some event channels may restrict access; if so, record that limitation instead of elevating or changing policy without authorization.

Create a private folder for outputs, for example `Documents\EndpointSecurityLab\run-YYYY-MM-DD`. Do not commit raw output containing real device or user identifiers. Add only redacted evidence to this portfolio.

## Exercise 1: establish a baseline

1. Read `scripts/Get-LabBaseline.ps1` before execution.
2. In PowerShell, run the script from its folder: `./Get-LabBaseline.ps1`.
3. Record the execution date, Windows build, whether the session was elevated, and any inaccessible checks.
4. Compare the output with `docs/02-baseline-and-monitoring.md`.
5. Do not treat a reported status as proof that every policy is correctly configured; this is a small local snapshot.

## Exercise 2: review security events

1. Read `scripts/Get-SecurityEventSummary.ps1`.
2. Run it with the default lookback, or choose a short interval: `./Get-SecurityEventSummary.ps1 -Hours 24`.
3. Record the query window, channels successfully read, number of records, and any access errors.
4. Open Event Viewer only if needed to inspect a record in context. Redact identifiers from screenshots.
5. Event IDs are signals for investigation, not conclusions by themselves. Correlate time, account, host, and other available evidence.

## Exercise 3: tabletop response

Complete `scenarios/01-suspicious-sign-in-tabletop.md` using `templates/incident-record.md` and `templates/evidence-log.md`. Keep all proposed containment steps clearly labeled as recommendations in this fictional scenario. Do not alter a real account or endpoint for this exercise.

## Verification checklist

- [ ] Script source reviewed before running.
- [ ] Execution performed on an authorized test environment.
- [ ] Output stored privately and sensitive values redacted before sharing.
- [ ] Collection time, scope, and access limitations recorded.
- [ ] Findings separated from assumptions and recommendations.
- [ ] No security controls weakened to manufacture evidence.
- [ ] Tabletop report includes a clear escalation decision and recovery criteria.

## Troubleshooting

- **Command not found:** use a supported Windows PowerShell session and run from the script directory with `./script-name.ps1`.
- **Execution policy blocks the script:** do not change machine-wide policy for this lab. Review the script, then use an approved method or ask the device administrator.
- **Access denied to a log:** record the channel and error. Do not bypass organizational access controls.
- **No matching events:** document the queried period and filters; no results does not prove that no incident occurred.
