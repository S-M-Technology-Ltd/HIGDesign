#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

if [[ "$(uname -s)" != "Darwin" ]]; then
    echo "macOS checks require a Darwin runner." >&2
    exit 1
fi

run_check() {
    local label="$1"
    shift
    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "▶ ${label}"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    "$@"
}

echo "HIGDesign macOS checks"

run_check "Swift build (all platforms)" Scripts/build_all_platforms.sh
run_check "Swift test (macOS)" swift test --package-path .
run_check "Build Showcase app" swift build --package-path . --target HIGShowcaseApp
run_check "Sample Xcode project" Scripts/verify_sample_xcode_project.sh

echo ""
echo "macOS checks passed."