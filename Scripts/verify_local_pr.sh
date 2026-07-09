#!/usr/bin/env bash
# Mandatory local PR gate for agents and humans.
# Order: fast static guards → unit tests → sample iOS+macOS builds.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

run() {
    echo ""
    echo "════════════════════════════════════════════════════════"
    echo "▶ $*"
    echo "════════════════════════════════════════════════════════"
    "$@"
}

run "$ROOT/Scripts/verify_platform_api_guards.sh"
run "$ROOT/Scripts/verify_showcase_coverage.sh"
run "$ROOT/Scripts/verify_xcode_previews_present.sh"
run "$ROOT/Scripts/verify_view_naming.sh"
run "$ROOT/Scripts/verify_no_gcd.sh"

echo ""
echo "════════════════════════════════════════════════════════"
echo "▶ swift test"
echo "════════════════════════════════════════════════════════"
swift test --package-path .

# Includes platform API guard + iOS Simulator + macOS sample builds.
run "$ROOT/Scripts/verify_sample_xcode_project.sh"

echo ""
echo "Local PR verification passed."
echo "Optional (slower): Scripts/build_all_platforms.sh"
