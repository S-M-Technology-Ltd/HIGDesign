#!/bin/bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"

fail() {
    echo "UI guidelines guard failed: $1" >&2
    exit 1
}

GUIDELINES="$ROOT_DIR/Docs/UI_DESIGN_GUIDELINES.md"
AGENTS="$ROOT_DIR/AGENTS.md"
STANDARDS="$ROOT_DIR/CODING_STANDARDS.md"
AGENT_RULES="$ROOT_DIR/Docs/AGENT_RULES.md"
DESIGN_LIBRARY="$ROOT_DIR/Design/hig-design-system.html"
FULL_REFERENCE="$ROOT_DIR/Design/hig/index.html"

[[ -f "$GUIDELINES" ]] || fail "Docs/UI_DESIGN_GUIDELINES.md is missing."
[[ -f "$AGENTS" ]] || fail "AGENTS.md is missing."
[[ -f "$STANDARDS" ]] || fail "CODING_STANDARDS.md is missing."
[[ -f "$AGENT_RULES" ]] || fail "Docs/AGENT_RULES.md is missing."

grep -q "Apple HIG UI Rule" "$AGENTS" || fail "AGENTS.md must mention Apple HIG UI Rule."
grep -q "Apple HIG" "$STANDARDS" || fail "CODING_STANDARDS.md must mention Apple HIG."
grep -q "Apple Human Interface Guidelines" "$AGENT_RULES" || fail "Docs/AGENT_RULES.md must reference Apple Human Interface Guidelines."
grep -Eq '^## Mandatory Apple HIG Rule' "$GUIDELINES" || fail "Docs/UI_DESIGN_GUIDELINES.md must include the mandatory Apple HIG rule."
grep -q "PR Checklist" "$GUIDELINES" || fail "Docs/UI_DESIGN_GUIDELINES.md must include a PR checklist."
grep -q "Accessibility Checklist" "$GUIDELINES" || fail "Docs/UI_DESIGN_GUIDELINES.md must include an accessibility checklist."

[[ -f "$DESIGN_LIBRARY" ]] || fail "Design/hig-design-system.html is missing."
[[ -f "$FULL_REFERENCE" ]] || fail "Design/hig/index.html is missing."

grep -q "HIGDesign HIG Design System" "$DESIGN_LIBRARY" || fail "Design/hig-design-system.html must include the HIGDesign HIG Design System."
grep -q "Apple Human Interface Guidelines" "$DESIGN_LIBRARY" || fail "Design/hig-design-system.html must reference Apple Human Interface Guidelines."

grep -q "HIGDesign HIG Full Reference" "$FULL_REFERENCE" || fail "Design/hig/index.html must include the HIGDesign HIG Full Reference."
grep -q "Design principles by HIG subpage" "$FULL_REFERENCE" || fail "Design/hig/index.html must be separated by HIG subpage."

page_count=$(find "$ROOT_DIR/Design/hig/pages" -type f -name "*.html" 2>/dev/null | wc -l | tr -d " ")
snapshot_count=$(find "$ROOT_DIR/Design/hig/snapshots" -type f -name "*.svg" 2>/dev/null | wc -l | tr -d " ")

[[ "$page_count" -ge 50 ]] || fail "Design/hig/pages must include separated HIG subpage references."
[[ "$snapshot_count" -ge 50 ]] || fail "Design/hig/snapshots must include generated snapshot images."

echo "UI guidelines guard passed: Apple HIG UI rules are documented."