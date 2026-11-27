# Restricted Windows smoke check

Ran the report with a one-day event window and software inventory omitted. The diagnostic generated both HTML and JSON. Several collectors were unavailable in the restricted session. The revised report assigned Warning and recorded Incomplete collection. The JSON parsed successfully and contained that finding. This check covers report generation and the incomplete-data path. Full collection still needs a run on a normal Windows workstation. Raw outputs were kept private.
