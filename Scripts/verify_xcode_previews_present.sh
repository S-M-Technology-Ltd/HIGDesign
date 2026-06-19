#!/bin/bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
SEARCH_PATHS=(
    "$ROOT_DIR/Sources/HIGComponents"
    "$ROOT_DIR/Sources/HIGModifiers"
    "$ROOT_DIR/Sources/HIGThemesContract"
    "$ROOT_DIR/Sources/HIGBridging"
    "$ROOT_DIR/Showcase"
)

existing_paths=()
for path in "${SEARCH_PATHS[@]}"; do
    if [[ -d "$path" ]]; then
        existing_paths+=("$path")
    fi
done

if ((${#existing_paths[@]} == 0)); then
    echo "Xcode preview coverage guard skipped: no SwiftUI source directories yet."
    exit 0
fi

VIEW_PATTERN='^[[:space:]]*(private[[:space:]]+|fileprivate[[:space:]]+|internal[[:space:]]+|public[[:space:]]+)?struct[[:space:]]+[A-Za-z_][A-Za-z0-9_]*[^:]*:[^{]*[[:<:]]View[[:>:]]'

swift_files=()
while IFS= read -r file; do
    swift_files+=("$file")
done < <(
    grep -rlE "$VIEW_PATTERN" "${existing_paths[@]}" 2>/dev/null \
        | grep -v '/Inputs/PhotoPicker/' \
        | sort || true
)

if ((${#swift_files[@]} == 0)); then
    echo "Xcode preview coverage guard skipped: no SwiftUI View types yet."
    exit 0
fi

missing=()

for file in "${swift_files[@]}"; do
    while IFS= read -r view_type; do
        if ! grep -Eq "#Preview\\(\"${view_type}([\"[:space:]—-])" "$file"; then
            missing+=("${file#"$ROOT_DIR/"}: $view_type")
        fi
    done < <(
        perl -ne 'print "$1\n" if /^\s*public\s+struct\s+([A-Za-z_][A-Za-z0-9_]*)\s*:[^{]*\bView\b/' "$file"
    )
done

if ((${#missing[@]} > 0)); then
    echo "SwiftUI View types missing a same-file, type-named #Preview:"
    printf '  %s\n' "${missing[@]}"
    exit 1
fi

echo "Xcode preview coverage guard passed: every View type has a same-file preview."