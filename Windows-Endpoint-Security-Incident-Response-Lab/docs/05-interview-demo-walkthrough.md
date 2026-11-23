# Interview demo walkthrough

Use this as a five-minute guided tour after completing the hands-on exercises. Keep the demo limited to sanitized sample output or a test VM. Do not expose a real user's data, device identifiers, or unredacted event messages.

## Before the interview

- Complete the baseline and event review on an authorized Windows test environment.
- Have one redacted baseline excerpt and one event query ready, or say plainly that you have only completed the tabletop so far.
- Open the fictional incident record and evidence log.
- Be ready to explain what the commands collect and what they do not prove.

## Five-minute sequence

### 0:00–0:45 — State the problem

“This lab demonstrates how I approach Windows endpoint security support: establish a small read-only baseline, review a defined set of security events, and document a suspected sign-in report without jumping to conclusions.”

### 0:45–1:45 — Show the collection scripts

Open `scripts/Get-LabBaseline.ps1` and `scripts/Get-SecurityEventSummary.ps1`. Point out the bounded query window, selected fields, and error handling. Explain that inaccessible channels and empty results are reported as limitations, not treated as proof that nothing happened.

### 1:45–2:30 — Show your sanitized evidence

Show the date and environment note, Defender/firewall status, and event query filter. Explain any redactions and why the evidence is only a snapshot. Never imply that this limited check certifies a device as secure.

### 2:30–3:45 — Walk through the tabletop

Use `scenarios/01-suspicious-sign-in-tabletop.md`. Describe the reported unexpected approval prompts, what you would capture first, what identity and endpoint records you would request, and which actions require the identity/security owner's approval.

### 3:45–4:30 — Explain evidence and escalation

Show the incident record and evidence log. Explain how you separate user reports, confirmed observations, and hypotheses; preserve timestamps and sources; and escalate if signs point to active account misuse or broader impact.

### 4:30–5:00 — State the limitation and next step

“This is a learning lab using read-only local checks and a fictional incident. I have not treated it as production incident response. The next step in a real environment would be to follow the organization's incident process and work with the authorized identity and security owners.”

## If you have not collected live test evidence yet

Do not present sample output as your own. Show the scripts, safety controls, tabletop, and templates, then say that hands-on validation is the next step. Complete the lab on a test VM before describing observed results.

## Interview questions to rehearse

- What is the difference between an observation and an interpretation?
- Why can an empty event query not rule out an incident?
- Which checks can run without elevation, and what happens when access is denied?
- What would make you escalate immediately?
- Which containment actions require approval?
- How do you protect personal and company information in a portfolio?
