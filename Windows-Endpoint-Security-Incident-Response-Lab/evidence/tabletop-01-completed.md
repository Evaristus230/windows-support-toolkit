# Completed tabletop case: unexpected sign-in prompts

**Case type:** Fictional tabletop exercise — no real account or device was investigated.

## Incident record

| Field | Entry |
|---|---|
| Case ID | LAB-TT-001 |
| Status / initial severity | Open; medium pending identity-team triage. Raise immediately if the identity provider confirms a successful unfamiliar sign-in, sensitive data access, or continued prompts. Follow the organization's own severity matrix in a real incident. |
| Reporter | Fictional remote employee; identity omitted |
| Affected account / device | One employee account and one company-managed Windows laptop (scenario only) |
| Reported time | 09:10 local time; date and time zone to be confirmed with reporter |
| Impact / scope | Two unexpected MFA approval prompts reported overnight; user denies approving them. User currently reports access still works. No confirmed unauthorized access or data impact. |
| Case owner / escalation | Help desk records initial report and promptly escalates to identity/security on-call owner. |

### Summary

An employee reports two unexpected sign-in approval prompts overnight and denies approving either. This is a credible account-security signal, but the prompt report alone does not prove a successful sign-in or endpoint compromise. Preserve the report, advise the employee not to approve unexpected prompts, and have the authorized identity/security owner check authentication and session telemetry.

### Timeline

| Time and zone | Observation or action | Source / actor | Classification |
|---|---|---|---|
| Overnight; exact time unknown | Two approval prompts appeared | Employee report | Report, not independently verified |
| Overnight; exact time unknown | Employee says they did not approve either prompt | Employee report | Report |
| 09:10 local; date/time zone to confirm | Employee contacts help desk; reports still having access | Employee report | Report |
| After intake | Help desk records scope and escalates for identity review | Help desk | Recommended tabletop action; not performed in production |

### Immediate questions

1. What date, time, and time zone did each prompt appear? Were there additional prompts, texts, or calls?
2. Did the employee approve, deny, dismiss, or ignore any prompt? Did they enter a password on a link or share a code?
3. Are any other users reporting similar prompts? Did the employee notice unfamiliar sign-in notifications, mailbox rules, sent messages, or file access?
4. What is the safest verified callback method, and is the employee currently using a trusted device and network?
5. What does the organization's incident policy require for reporting suspicious MFA prompts?

### Findings and confidence

| Finding | Evidence source | Interpretation | Confidence / limitation | Next check |
|---|---|---|---|---|
| Two unexpected prompts were reported | Employee statement in scenario | Possible password exposure, user confusion, or unsolicited authentication attempts | Medium confidence in report; prompt origin and account outcome unverified | Identity owner reviews sign-in and MFA records in the relevant time window |
| Employee denies approving prompts | Employee statement in scenario | No user-authorized approval reported | Medium confidence; no independent telemetry yet | Correlate MFA result and authentication outcome |
| User says access still works | Employee statement in scenario | Does not establish whether other sessions exist or whether access was misused | Low confidence as a security indicator | Identity owner checks active sessions, sign-ins, and risk telemetry |
| No other affected users are known | Scenario provides no broader reports | Scope is unknown, not necessarily limited to one account | Low confidence; absence of report is not evidence of absence | Ask service desk/security to check related alerts and reports |

### Containment and escalation recommendations

- Tell the employee not to approve unexpected prompts and to report any new ones through the organization's approved channel.
- Escalate promptly to the designated identity/security owner; include exact prompt times, time zone, account, device, and user statements.
- Ask the authorized owner to review identity-provider sign-in, MFA, risk, session, and audit records for the defined window, with comparison to the employee's expected locations/devices where policy allows.
- The identity/security owner decides whether to revoke sessions, reset credentials, require re-registration, or take other account actions. Record approval and operator for any action.
- Request endpoint review only if identity findings or other indicators justify it; avoid claiming the laptop is compromised based solely on an MFA prompt.
- If successful unfamiliar access, sensitive-data activity, multiple accounts, or continuing abuse is confirmed, raise severity and follow incident-response escalation immediately.

### Closure criteria

The identity/security owner has reviewed the relevant telemetry; any required containment and recovery actions have an owner, approval, and recorded outcome; the employee confirms expected access is restored; monitoring shows no continuing suspicious activity for the organization's required period; and unresolved uncertainty is documented. If these checks cannot be completed, keep the case open or transfer it to the designated owner.

### Interview defence

“I treated unexpected MFA prompts as a credible signal that needs fast identity-team review, but I did not assume they proved compromise. I captured exact times and user context, recommended that the user not approve new prompts, and escalated sign-in and session checks to the identity owner. Any session revocation or credential action would require that owner's approval and the organization's process. This was a fictional tabletop, not a live incident.”
