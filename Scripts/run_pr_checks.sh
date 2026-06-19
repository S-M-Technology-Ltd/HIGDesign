#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

mode="all"
if [[ $# -gt 0 ]]; then
    mode="$1"
fi

case "$mode" in
    all)
        Scripts/run_governance_checks.sh
        Scripts/run_macos_checks.sh
        ;;
    governance)
        Scripts/run_governance_checks.sh
        ;;
    macos)
        Scripts/run_macos_checks.sh
        ;;
    *)
        echo "Usage: Scripts/run_pr_checks.sh [all|governance|macos]" >&2
        exit 1
        ;;
esac

echo ""
echo "PR checks passed (${mode})."