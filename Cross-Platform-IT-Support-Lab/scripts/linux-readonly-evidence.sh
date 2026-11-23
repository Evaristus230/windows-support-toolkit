#!/usr/bin/env bash
# Read-only Linux evidence example; does not edit settings or restart services.
# Review policy and redact identifying information before sharing output.
set -u
printf '%s\n' '=== Operating system ==='
if [ -r /etc/os-release ]; then . /etc/os-release; printf 'Distribution: %s\nVersion: %s\n' "${PRETTY_NAME:-unknown}" "${VERSION_ID:-unknown}"; fi
printf '\n%s\n' '=== Disk capacity ==='
df -hP
printf '\n%s\n' '=== Interface addresses ==='
ip -brief address 2>/dev/null || ip address
printf '\n%s\n' '=== Resolver status ==='
if command -v resolvectl >/dev/null 2>&1; then resolvectl status; else printf '%s\n' 'resolvectl is unavailable; inspect resolver configuration per local policy.'; fi
printf '\n%s\n' 'Review output for usernames, hostnames, addresses and paths before sharing.'
