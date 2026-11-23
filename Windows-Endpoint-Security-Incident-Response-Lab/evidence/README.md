# Evidence checklist

Add evidence only after completing a step on an authorized environment. Keep raw output private; submit sanitized copies here only after checking for usernames, device names, email addresses, IP addresses, tenant names, file paths, and tokens.

- [x] Baseline summary with collection date, Windows build, and environment noted.
- [x] Defender and firewall status evidence, including any unavailable checks.
- [x] Event summary evidence showing the channel, IDs, filter period, and result count.
- [x] Completed fictional tabletop incident record.
- [x] Evidence log showing source, collection time, handling notes, and redactions.
- [x] Short reflection: what was verified, what was inferred, and what remains unknown.

The successful non-elevated collection is from the user's current Windows workstation, not an isolated VM. See `baseline-summary-2026-11-23.md` and `event-log-review-2026-11-23.md`. Raw output remains local in a private work folder. The earlier restricted-session attempt is noted in `collection-attempt-2026-11-23.md`. The case practice in `tabletop-01-completed.md` is fictional and must remain labeled as a simulation.
