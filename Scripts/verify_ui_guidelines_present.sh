#!/bin/bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"

required_docs=(
    "Docs/UI_DESIGN_GUIDELINES.md"
    "Docs/AGENT_RULES.md"
    "AGENTS.md"
    "CODING_STANDARDS.md"
)

missing=()

for doc in "${required_docs[@]}"; do
    if [[ ! -f "$ROOT_DIR/$doc" ]]; then
        missing+=("$doc")
    fi
done

ui_doc="$ROOT_DIR/Docs/UI_DESIGN_GUIDELINES.md"
if [[ -f "$ui_doc" ]]; then
    if ! rg -q '^## Mandatory Apple HIG Rule' "$ui_doc"; then
        missing+=("Docs/UI_DESIGN_GUIDELINES.md (missing mandatory HIG rule section)")
    fi

    if ! rg -q 'PR Checklist' "$ui_doc"; then
        missing+=("Docs/UI_DESIGN_GUIDELINES.md (missing PR checklist)")
    fi
fi

if ((${#missing[@]} > 0)); then
    echo "UI guidelines guard failed:"
    printf '  %s\n' "${missing[@]}"
    exit 1
fi

echo "UI guidelines guard passed."