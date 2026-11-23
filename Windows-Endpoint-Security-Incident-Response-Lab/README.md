# Windows Endpoint Security, Monitoring & Incident Response Lab

**Status:** Read-only baseline and bounded event review documented; fictional tabletop completed. Detailed context for selected events remains to be reviewed.

## Purpose

Build practical Windows endpoint support skills by learning to establish a baseline, review security signals, triage a suspected incident, preserve useful evidence, and document a clear handoff. This is a portfolio lab, not a claim of enterprise deployment or live incident response.

## Lab safety and scope

- Start with the read-only PowerShell scripts in `scripts/` on a Windows test machine or VM.
- The scripts collect selected configuration and event information. Review their contents before running them; they do not intentionally change settings.
- Do not disable Defender, tamper protection, firewall, logging, or other safeguards to create a scenario.
- Do not run malware, exploit code, credential theft tools, or destructive tests. Use the written tabletop scenario in `scenarios/` instead.
- Redact usernames, hostnames, addresses, tenant identifiers, and other personal or company data before sharing screenshots or logs.
- The scripts were run read-only on the user's current Windows workstation. They did not change settings. This is a one-time local snapshot, not an isolated VM, continuous monitoring, or production incident response.

## Learning outcomes

1. Capture and explain a basic Windows security baseline.
2. Check Defender and firewall status using built-in, read-only commands.
3. Find relevant Windows event records and state what they do and do not prove.
4. Triage a suspected endpoint incident using scope, impact, timeline, and evidence.
5. Recommend proportionate containment and escalation steps without making unauthorized changes.
6. Write a concise incident report that another technician can act on.

## Repository map

- `docs/01-lab-guide.md` — setup, sequence, and verification checklist.
- `docs/02-baseline-and-monitoring.md` — baseline worksheet and event review guidance.
- `docs/03-incident-response-playbook.md` — safe triage, escalation, and recovery workflow.
- `docs/04-interview-defence.md` — project explanation and interview prompts.
- `docs/05-interview-demo-walkthrough.md` — five-minute portfolio walkthrough.
- `scenarios/01-suspicious-sign-in-tabletop.md` — fictional, non-destructive practice incident.
- `templates/incident-record.md` — reusable case record.
- `templates/evidence-log.md` — evidence handling log.
- `scripts/` — read-only PowerShell collection and verification scripts.
- `evidence/README.md` — evidence checklist; add sanitized captures only after doing the steps yourself.
- `evidence/tabletop-01-completed.md` — completed fictional case for interview practice.
- `evidence/tabletop-01-evidence-log.md` — sources and limits for the fictional case.
- `evidence/baseline-summary-2026-11-23.md` — sanitized read-only baseline from the user's Windows system.
- `evidence/event-log-review-2026-11-23.md` — bounded event query with counts and interpretation limits.
- `evidence/reflection-2026-11-23.md` — what was verified, simulated, and escalated.
- `evidence/collection-attempt-2026-11-23.md` — sanitized record of the restricted-session collection attempt.

## Recommended order

1. Read the safety notes and lab guide.
2. Run `Get-LabBaseline.ps1` in a Windows test environment. Save its output to a local lab folder outside this repository if it contains machine-specific information.
3. Run `Get-SecurityEventSummary.ps1` and review the records it finds. Empty results are valid; record the time range and limitations.
4. Complete the tabletop scenario and incident record without changing the endpoint.
5. Capture sanitized evidence, update the evidence checklist, and write a short reflection on what you verified versus inferred.

## Completion criteria

- Baseline worksheet completed with date, Windows edition/build, collection method, and redactions noted.
- Defender/firewall status explained with command output or a screenshot from a test machine.
- At least one event log query documented, including time range, channel, filter, result count, and limitations.
- Tabletop case includes severity rationale, timeline, scope, evidence, recommended actions, and escalation owner.
- Interview defence answers distinguish lab simulation from production experience.

## Current progress

The read-only baseline and 24-hour event review were run on the user's current Windows system in a non-elevated PowerShell session. Sanitized results, limits, tabletop evidence log, and reflection are included under `evidence/`; raw output remains private and is not committed. Six service-install records and 24 Defender configuration-change records were counted but are not classified without reviewing their detailed context. This is one workstation snapshot, not a dedicated VM, continuous monitoring, or a production incident investigation. The sign-in scenario remains fictional.

For an interview presentation after completing the exercises, use `docs/05-interview-demo-walkthrough.md`.
