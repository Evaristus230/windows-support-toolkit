# Lab reflection — 2026-11-23

## What I verified

- Ran both supplied scripts in a non-elevated PowerShell 7.6.9 session on the current Windows 11 Pro workstation.
- The baseline collector returned OS/build information, Defender status, three firewall profile states, and five hotfix records.
- The bounded 24-hour event query returned zero Security matches for IDs 4624, 4625, and 1102; six System 7045 records; and 24 Defender Operational 5007 records, with zero matches for 1116, 1117, and 5001.
- Kept raw output private and published only a sanitized summary without hostname, username, serial number, addresses, or event messages.
- No settings, accounts, audit policies, or security controls were changed.

## What was simulated

The suspicious sign-in scenario and its employee statements are fictional. The completed report demonstrates triage reasoning and escalation decisions only. No MFA prompts were generated, no real account was investigated, and no identity-provider records were accessed.

## What remains unknown

- Whether the six service-install events and 24 Defender configuration changes correspond to expected software or policy activity; their detailed messages and change history were not included in the public report.
- Whether Security auditing and retention were sufficient to capture all relevant sign-ins.
- Whether the local Defender/firewall settings match an intended organizational policy.
- Whether any identity-provider activity occurred; local Windows logs cannot answer that question.

## What I would escalate

I would ask the authorized endpoint/security owner to review the service-install details and Defender old/new configuration values against approved change records. I would escalate immediately if a change were unexplained, protection were disabled, a service path or signer were suspicious, or telemetry indicated active compromise. For the fictional MFA report, I would route sign-in, MFA, risk, and session checks to the identity/security owner and leave account containment decisions to that owner.

## Lesson

Counts and status flags help scope a review but do not establish intent. The six 7045 and 24 5007 records need their event details and change context before classification; an empty filtered query is not proof that no activity occurred.
