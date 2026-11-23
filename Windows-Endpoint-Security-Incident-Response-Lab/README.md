# Windows Endpoint Security, Monitoring & Incident Response Lab

**Status:** Starter kit — documentation and safe read-only scripts prepared; hands-on evidence still needs to be collected.

## Purpose

Build practical Windows endpoint support skills by learning to establish a baseline, review security signals, triage a suspected incident, preserve useful evidence, and document a clear handoff. This is a portfolio lab, not a claim of enterprise deployment or live incident response.

## Lab safety and scope

- Start with the read-only PowerShell scripts in `scripts/` on a Windows test machine or VM.
- The scripts collect selected configuration and event information. Review their contents before running them; they do not intentionally change settings.
- Do not disable Defender, tamper protection, firewall, logging, or other safeguards to create a scenario.
- Do not run malware, exploit code, credential theft tools, or destructive tests. Use the written tabletop scenario in `scenarios/` instead.
- Redact usernames, hostnames, addresses, tenant identifiers, and other personal or company data before sharing screenshots or logs.
- This repository documents the lab. No actual machine has been inspected or changed by this starter kit.

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

Starter documentation and scripts are prepared. No hands-on execution or live-system findings have been verified yet. Follow `docs/01-lab-guide.md` for the next practical steps.

For an interview presentation after completing the exercises, use `docs/05-interview-demo-walkthrough.md`.
