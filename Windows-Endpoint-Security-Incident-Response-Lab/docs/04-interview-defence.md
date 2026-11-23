# Interview defence

## 60-second project explanation

“I built a Windows endpoint security and incident response learning lab. I used read-only PowerShell checks to document a limited security baseline, reviewed a bounded set of Windows event logs, and worked through a fictional suspicious sign-in tabletop. I tracked the source and limits of each observation, redacted identifying details, and separated confirmed evidence from hypotheses and recommendations. I did not weaken protections or claim production incident-response experience. The project shows how I would gather facts, communicate risk, and escalate within my authority.”

Adapt this after you complete the hands-on steps. Do not say you ran the scripts or observed particular findings until you have done so yourself.

## Questions to practise

**How do you know the device is secure?**  
I cannot infer that from a small snapshot. I can report which checks I ran, what they returned, the time window, and the gaps. A security owner must assess policy, telemetry, and broader context.

**What does a failed logon event mean?**  
It records an unsuccessful authentication attempt in the relevant context. I would check account, time, source, logon type, nearby activity, and whether the attempt is expected before concluding anything.

**What would you do if you suspect an active compromise?**  
I would record the user's report and affected scope, avoid interacting with suspicious content, preserve approved evidence, and promptly contact the designated security/on-call owner. Any isolation or account action would follow authorization and incident policy.

**How did you protect privacy?**  
I kept raw machine-specific output private, used only sanitized evidence in the portfolio, and noted which fields were redacted.

**What did you personally verify?**  
Answer only after completing the lab. Name the environment, date, commands or UI, result, and limitation. Identify the tabletop as simulated.

## Evidence that strengthens the project

- A redacted baseline excerpt with collection date and test-environment note.
- A screenshot or sanitized summary of an event query, including filter and time range.
- A completed tabletop case report and evidence log.
- A short reflection describing one assumption you revised after checking evidence.
