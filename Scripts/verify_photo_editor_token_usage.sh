#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
PHOTO_EDITOR_DIR="$ROOT/Sources/HIGComponents/Inputs/PhotoEditor"

if [[ ! -d "$PHOTO_EDITOR_DIR" ]]; then
    echo "Photo editor token guard failed: directory not found at $PHOTO_EDITOR_DIR" >&2
    exit 1
fi

VIEW_FILES=("$PHOTO_EDITOR_DIR"/Views/*.swift)
PATTERNS=(
    'Color\.primary'
    'Color\.secondary'
    'Color\.black'
    'Color\(\.system'
    '\.padding\([0-9]'
    'spacing: [0-9]'
    'lineWidth: [0-9]'
    'opacity\(0\.'
)

for pattern in "${PATTERNS[@]}"; do
    if matches="$(grep -En "$pattern" "${VIEW_FILES[@]}" 2>/dev/null || true)"; then
        if [[ -n "$matches" ]]; then
            echo "Photo editor token guard failed: hardcoded visual value matching '$pattern'." >&2
            echo "$matches" >&2
            exit 1
        fi
    fi
done

echo "Photo editor token guard passed."