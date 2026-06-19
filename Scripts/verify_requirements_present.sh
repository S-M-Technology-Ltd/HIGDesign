#!/bin/bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
REQUIREMENTS_DIR="$ROOT_DIR/Requirements"
INDEX_DOC="$REQUIREMENTS_DIR/README.md"

required_modules=(
    Foundation
    Tokens
    Themes
    Platform
    Components
    Modifiers
    Bridging
    Showcase
)

missing=()

if [[ ! -f "$INDEX_DOC" ]]; then
    echo "Missing Requirements index: Requirements/README.md" >&2
    exit 1
fi

for module in "${required_modules[@]}"; do
    req_file="$REQUIREMENTS_DIR/$module/REQ.md"
    if [[ ! -f "$req_file" ]]; then
        missing+=("Requirements/$module/REQ.md")
        continue
    fi

    if ! rg -q '^## (All platforms|Requirements)' "$req_file"; then
        missing+=("Requirements/$module/REQ.md (missing requirements section)")
    fi

    if ! rg -q '^### (iOS|macOS|watchOS|tvOS|visionOS)' "$req_file"; then
        missing+=("Requirements/$module/REQ.md (missing platform section)")
    fi
done

readme_doc="$ROOT_DIR/README.md"
if ! rg -q 'Requirements/' "$readme_doc"; then
    echo "README.md must link Requirements/" >&2
    exit 1
fi

if ((${#missing[@]} > 0)); then
    echo "Requirements guard failed:"
    printf '  %s\n' "${missing[@]}"
    exit 1
fi

echo "Requirements guard passed: every module has REQ.md with platform sections."