# Incident response playbook

This is a learning checklist for an authorized support role. Follow your employer's incident process and escalation paths in real incidents. Do not independently isolate devices, disable accounts, collect memory, or remove files unless authorized.

## 1. Receive and scope

- Record reporter, callback method, affected user/device, location, first observed time, and business impact.
- Ask what changed and what the user observed. Preserve exact error text where possible.
- Determine whether there are multiple affected users/devices or signs of active harm.
- Assign a case identifier and initial severity using the organization's policy.

## 2. Preserve and validate

- Record time zone and clock source for timestamps.
- Capture relevant observations and approved logs before any authorized containment changes.
- Maintain an evidence log with source, collector, collection time, and storage location.
- Separate confirmed facts from user reports, hypotheses, and next actions.
- Avoid opening suspicious attachments, running unknown files, or forwarding them through unapproved channels.

## 3. Contain through the right owner

- If active compromise, ransomware, sensitive data exposure, or broad spread is suspected, escalate promptly to the security/on-call team.
- Request containment from the authorized owner (for example, endpoint security or identity administration). Record who approved and performed it.
- Do not disable protections or make account/device changes outside delegated authority.

## 4. Eradicate and recover

- Let the incident owner approve remediation and restoration.
- Confirm the source of the issue is addressed, required credentials or tokens are handled by the identity/security team, and endpoint protection is healthy.
- Validate with the user and monitoring owner before closing.

## 5. Close and learn

- Document impact, timeline, root cause if established, actions and approvers, recovery checks, and follow-up owner/date.
- Record uncertainty honestly; “not determined” is an acceptable outcome.
- Share a sanitized lesson learned with no secrets or personal data.

## Severity prompts

Use local definitions where available. Escalate quickly if there is evidence of active encryption, privileged account misuse, confirmed data exposure, multiple endpoints, or continued suspicious activity. A single alert or failed logon is a reason to investigate, not automatically a high-severity incident.
