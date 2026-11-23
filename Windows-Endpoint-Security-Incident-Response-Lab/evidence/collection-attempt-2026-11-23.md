# Sanitized collection attempt record

**Date:** 2026-11-23 (Africa/Lagos)  
**Context:** Restricted PowerShell session in the Codex workspace; not a dedicated Windows lab VM.  
**Purpose:** Check whether the supplied read-only scripts can collect a baseline and recent security-event summary in this execution environment.

## Result

The scripts started and returned their completion summaries, but the environment did not permit usable Windows evidence collection:

- The operating-system and firewall queries were blocked by unavailable CIM access.
- The Defender status command was present but its module could not load in this PowerShell environment.
- The installed-hotfix query returned access denied.
- The Security, System, and Defender Operational event queries returned unauthorized-operation errors.

No event content or raw machine identifiers are reproduced in this note. No system settings, audit policies, or security controls were changed. These errors describe the restricted execution environment; they do not establish the health or security status of a Windows endpoint.

## Evidence status

- Baseline from an authorized test Windows device: **not collected**.
- Security-event review from an authorized test Windows device: **not collected**.
- Fictional sign-in tabletop: **completed** in `tabletop-01-completed.md`.

## Next hands-on step

Open a standard PowerShell session on an authorized Windows test VM, review each script, and run the commands in `docs/01-lab-guide.md`. If a query is denied there, record the limitation; do not change execution policy, enable auditing, or elevate privileges solely to force evidence collection. Redact identifiers before adding any result to the portfolio.
