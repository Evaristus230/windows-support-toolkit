# Restricted Windows smoke check

Ran the report with a one-day event window and software inventory omitted. The diagnostic generated both HTML and JSON. Several collectors were unavailable in the restricted session. The revised report assigned Warning and recorded Incomplete collection. The JSON parsed successfully and contained that finding. This check covers report generation and the incomplete-data path. Full collection still needs a run on a normal Windows workstation. Raw outputs were kept private.

## Full workstation run — 27 November 2026

The script ran with its default seven-day event window and software inventory enabled. It generated HTML and parseable JSON. Disk, network and software collectors returned records. The report assigned **Warning** and did not flag incomplete collection.

| Sanitized report field | Observed result |
|---|---|
| Overall status | Warning |
| Stopped services configured for automatic startup | 7 |
| System and Application error or critical events returned | 100 (query cap) |

This is a redacted extract from the actual run. A stopped service can be expected, and the event count is capped. Neither finding establishes a root cause without checking context. The raw reports remain private.
