# Interview walkthrough

## 60-second introduction

“I built a cross-platform IT support practice dashboard to show how I approach user-reported issues. It includes fictional Windows storage, Ubuntu name-resolution, and AWS access-denied cases. The workflow is to clarify impact, collect read-only evidence, distinguish reports from verified facts, and escalate changes to the right owner. The dashboard is a portfolio simulation, not a ticketing system or production incident record.”

## Demo

1. Open `index.html` and disclose that the cases are simulated.
2. Select Windows. Explain what you would ask before considering cleanup and show the read-only PowerShell examples.
3. Select Linux. Explain the difference between name resolution and reachability and what a known-good comparison adds.
4. Select AWS. Explain why an access-denied response may have several causes and why least-privilege changes need an authorized owner.
5. Close with documentation, escalation and privacy: sanitize evidence, state uncertainty, avoid unapproved changes.

## STAR outline

- **Situation:** A learner wants a repeatable way to practise common desktop and cloud-support reports.
- **Task:** Build a safe Windows, Linux and AWS scenario walkthrough.
- **Action:** Created a local-only dashboard, fictional tickets, read-only command examples and explicit escalation boundaries.
- **Result:** A reviewer can follow triage, inspect assumptions and discuss evidence needed before real remediation.

## Honest scope

- No real customer, employer, Windows incident, Linux host or AWS account is included.
- The screenshots are illustrative previews of the simulated dashboard.
- Scripts are examples and have not been run against an employer system.
- Do not describe this as production support experience, live incident response, or verified AWS remediation.
