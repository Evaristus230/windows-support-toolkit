# Tabletop: unusual sign-in reports

**Fictional scenario. Do not reproduce by changing a real account or endpoint.**

## Brief

At 09:10 local time, an employee tells the help desk they received two unexpected sign-in approval prompts overnight. They deny approving them. They can still access email and shared files. The technician has no alert confirmation yet. The employee is working remotely on a company-managed Windows laptop.

## Your task

Use the incident record and evidence log templates. Write the questions you would ask, the scope you would establish, and the records you would request from the authorized identity/security owner. Do not assume the Windows endpoint is compromised from the report alone.

## Prompts

1. What facts are confirmed, and what remains a user report or hypothesis?
2. What is the initial severity and why? Which organization-specific criteria could change it?
3. What immediate advice can you give the employee that does not exceed your authority?
4. Who should review identity-provider sign-in and MFA records? What time window and fields matter?
5. What approved endpoint checks might help correlate activity, and what are their limits?
6. Which actions require the identity/security owner’s approval (for example, session revocation, credential reset, or endpoint isolation)?
7. What evidence would support closing the case, and what uncertainty should remain documented?

## Suggested defensible approach

- Acknowledge the report, confirm safe contact details, ask the employee not to approve unexpected prompts, and follow the organization's reporting procedure.
- Capture the reported times with time zone, affected account/device, prompt details, and business impact.
- Escalate promptly to the identity/security owner for sign-in, MFA, session, and risk telemetry. Do not attempt to access an account or revoke sessions without authorization.
- Request authorized endpoint and identity evidence with a defined time range. Correlate before asserting compromise.
- Record the owner and approval for any containment action, then validate recovery with that owner and the user.

This is a training response, not a live incident finding.
