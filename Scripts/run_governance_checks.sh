#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

run_check() {
    local script="$1"
    local label="$2"
    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "▶ ${label}"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    "Scripts/${script}"
}

echo "HIGDesign governance checks"

run_check verify_requirements_present.sh "Requirements"
run_check verify_ui_guidelines_present.sh "UI guidelines"
run_check verify_xcode_previews_present.sh "Xcode previews"
run_check verify_view_naming.sh "View naming"
run_check verify_no_uikit.sh "No UIKit"
run_check verify_no_gcd.sh "No GCD"
run_check verify_component_token_usage.sh "Component tokens"
run_check verify_photo_picker_token_usage.sh "Photo picker tokens"
run_check verify_no_committed_signing.sh "Committed signing"
run_check verify_showcase_coverage.sh "Showcase coverage"
run_check verify_docc_coverage.sh "DocC coverage"

echo ""
echo "Governance checks passed."