# Earlier restricted-session collection attempt

> This records the first, restricted-session attempt. A later successful read-only collection on the current Windows workstation is documented in `baseline-summary-2026-11-23.md` and `event-log-review-2026-11-23.md`.

**Date:** 2026-11-23 (Africa/Lagos)  
**Context:** Restricted PowerShell session in the Codex workspace; not a dedicated Windows lab VM.  
**Purpose:** Check whether the supplied read-only scripts can collect a baseline and recent security-event summary in this execution environment.

## Result

The scripts started and returned their completion summaries, but the restricted PowerShell session did not permit usable Windows command-line evidence collection:

- The operating-system and firewall queries were blocked by unavailable CIM access.
- The Defender status command was present but its module could not load in this PowerShell environment.
- The installed-hotfix query returned access denied.
- The Security, System, and Defender Operational event queries returned unauthorized-operation errors.

No event content or raw machine identifiers are reproduced in this note. No system settings, audit policies, or security controls were changed. These errors describe the restricted execution environment; they do not establish the health or security status of a Windows endpoint.

A separate, limited System Information summary was reviewed through the local Windows UI. Its device and security posture values are kept in private local notes and are not included here or in the public portfolio. That UI review does not replace the script-based baseline or event review on a dedicated lab VM.

## Evidence status

- Script-based baseline from an authorized test Windows device: **not collected**.
- Limited System Information UI summary: **reviewed locally; details kept private**.
- Security-event review from an authorized test Windows device: **not collected**.
- Fictional sign-in tabletop: **completed** in `tabletop-01-completed.md`.

This earlier failure was resolved by rerunning the scripts in a normal, non-elevated Windows session. The successful sanitized results are in the linked evidence reports. No settings, audit policies, or security controls were changed.
