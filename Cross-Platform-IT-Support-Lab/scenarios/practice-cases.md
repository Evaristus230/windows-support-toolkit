# Practice tickets

All cases are fictional learning exercises. Names, organizations, systems and observations do not refer to real users or employers.

## NS-1042 — Windows 11 low disk space

**Report:** “My laptop keeps saying storage is low and the shared spreadsheet will not save.”

**Ask:** What exact message appears? When did it start? Can other applications save? Which drive is affected? Is unsaved work at risk?

**Read-only triage:** Review free space with `Get-PSDrive` and `Get-Volume`; confirm the affected drive; ask before examining user files; check whether backup or storage policy applies. Do not delete files, clear caches, resize partitions, or alter the user profile in this lab.

**Assessment:** Consistent with a capacity issue, but no host was examined for this fictional ticket. Verify actual free space and the save error before deciding.

**Resolution/escalation:** Explain findings. If cleanup is appropriate, obtain approval and follow backup and retention policy. Escalate possible profile, disk-health or data-loss concerns.

**Interview prompt:** What would you ask before acting? How would you protect work files? What belongs in the ticket?

## NS-1088 — Ubuntu name resolution

**Report:** “I can connect using an IP address, but the internal application name does not open.”

**Ask:** What hostname and error? Does another name resolve? Are colleagues affected? Did network or VPN state change? What is the impact?

**Read-only triage:** Inspect interface state using `ip address`, resolver configuration using `resolvectl status`, and query reserved example name `intranet.example.invalid` with `getent hosts`. Compare with an approved known-good device. Do not edit resolver files or restart services in this exercise.

**Assessment:** Name resolution is a hypothesis. The user's IP-connectivity report is unverified. `.invalid` is a reserved example suffix and will not resolve publicly.

**Resolution/escalation:** Provide sanitized outputs and comparison results. Escalate DHCP, VPN, DNS or resolver changes to the network administrator.

**Interview prompt:** How do you separate DNS from routing or application failure?

## NS-1120 — AWS AccessDenied

**Report:** “I need to list an S3 bucket for my task, but the console says AccessDenied.”

**Ask:** Which account and role did the approved sign-in flow use? What action and resource failed? When? Was access approved and in scope?

**Read-only triage:** In an authorized training account only, verify identity with `aws sts get-caller-identity`; capture the exact error and request context; ask an IAM owner to review identity policy, bucket policy, permissions boundary, session policy and organization controls. This project does not call AWS or contain credentials.

**Assessment:** `AccessDenied` alone does not identify the blocking policy. This is a tabletop only; no account or bucket was inspected.

**Resolution/escalation:** Escalate to the account owner. Request minimum approved permission after confirming need. Do not attach broad policies or use another person's credentials.

**Interview prompt:** What information can you safely collect? Why is administrator access an unsafe shortcut? Who approves a change?
