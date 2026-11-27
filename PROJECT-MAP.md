# Project Map

This repository has one standalone Windows diagnostic and two guided labs. Start with the root [README](README.md), then choose the area that matches what you want to learn.

## Work areas

| Area | What it contains | Start |
|---|---|---|
| Windows health report | PowerShell collector and HTML/JSON output | [Usage and scope](README.md#windows-health-report) |
| Cross-platform support lab | Fictional service-desk tickets, local dashboard, read-only command examples | [Lab guide](Cross-Platform-IT-Support-Lab/README.md) · [Dashboard](Cross-Platform-IT-Support-Lab/index.html) |
| Windows security lab | Baseline collection, bounded event review, fictional incident tabletop | [Lab guide](Windows-Endpoint-Security-Incident-Response-Lab/README.md) |

## Recommended route

1. Read the safety and privacy notes in the root README.
2. Run the health report only on an authorized Windows test device; review its report locally and redact it before any sharing.
3. Work through the fictional cross-platform tickets and record your own reasoning separately from the supplied model answers.
4. Complete the Windows security lab. Keep actual observations, interpretation, and tabletop assumptions clearly separated.
5. Use the interview walkthroughs to explain what you did, what was simulated, what you observed, and what remains unknown.

## Evidence labels

- **Observed:** A dated result collected from a stated environment and method. It is not automatically representative of other systems.
- **Simulated:** A fictional case used to practise workflow. It is not a real incident.
- **Interpretation:** A conclusion supported by evidence and qualified by its limits.
- **Recommendation:** A proposed next step. It is not proof that the step was authorized or carried out.

Do not commit raw diagnostic output, screenshots with identifiers, credentials, tokens, or AWS account data. See the relevant lab guide before collecting or sharing evidence.
