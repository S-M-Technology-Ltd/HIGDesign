#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
PHOTO_PICKER_DIR="$ROOT/Sources/HIGComponents/Inputs/PhotoPicker"

if [[ ! -d "$PHOTO_PICKER_DIR" ]]; then
    echo "Photo picker token guard failed: directory not found at $PHOTO_PICKER_DIR" >&2
    exit 1
fi

if rg -n 'PickerDesign' "$PHOTO_PICKER_DIR" >/dev/null 2>&1; then
    echo "Photo picker token guard failed: PickerDesign is deprecated; use theme.photoPicker tokens." >&2
    rg -n 'PickerDesign' "$PHOTO_PICKER_DIR" >&2 || true
    exit 1
fi

VIEW_FILES=("$PHOTO_PICKER_DIR"/Views/*.swift)
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
    if matches="$(rg -n "$pattern" "${VIEW_FILES[@]}" 2>/dev/null || true)"; then
        if [[ -n "$matches" ]]; then
            echo "Photo picker token guard failed: hardcoded visual value matching '$pattern'." >&2
            echo "$matches" >&2
            exit 1
        fi
    fi
done

echo "Photo picker token guard passed."