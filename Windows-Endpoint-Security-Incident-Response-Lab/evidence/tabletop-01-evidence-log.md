# Evidence log: LAB-TT-001

**Case:** Unexpected sign-in prompts
**Case type:** Fictional tabletop; no live identity-provider incident was investigated.
**Raw evidence:** None for the fictional case. No real identity logs, credentials, or account details were collected.

| Evidence ID | Description / source | Collection time | Classification | Handling / limitation |
|---|---|---|---|---|
| TT-01 | Scenario brief states that an employee reports two unexpected approval prompts overnight | Fictional scenario time; exact date and time unknown | User report within simulation | Not independently verified; use only as a scenario premise |
| TT-02 | Scenario brief states that the employee denies approving the prompts and reports access still works | Fictional scenario time; exact date and time unknown | User report within simulation | Does not establish whether any sign-in succeeded or sessions remain active |
| TT-03 | Completed case analysis and recommended escalation in `tabletop-01-completed.md` | 2026-11-23 | Analyst notes for simulation | Reasoning artifact, not production action or identity telemetry |
| E-01 | Sanitized local Windows baseline in `baseline-summary-2026-11-23.md` | 2026-11-23 16:23 UTC+01:00 | Real, read-only workstation snapshot | Separate from the fictional account scenario; raw output retained privately |
| E-02 | Bounded event query in `event-log-review-2026-11-23.md` | 2026-11-23 16:24 UTC+01:00; prior 24 hours | Real, read-only workstation event counts | Does not include identity-provider telemetry or raw messages; not evidence for/against the fictional prompts |

In a real case, the help desk would request approved identity-provider sign-in, MFA, risk, and session records for the confirmed time window from the authorized identity/security owner. Any session revocation, credential reset, or endpoint isolation would be performed only by an authorized owner and recorded with approval.
