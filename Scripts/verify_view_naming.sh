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
    echo "View naming guard skipped: no SwiftUI source directories yet."
    exit 0
fi

VIEW_PATTERN='^[[:space:]]*(private[[:space:]]+|fileprivate[[:space:]]+|internal[[:space:]]+|public[[:space:]]+)?struct[[:space:]]+[A-Za-z_][A-Za-z0-9_]*[^:]*:[^{]*[[:<:]]View[[:>:]]'

swift_files=()
while IFS= read -r file; do
    swift_files+=("$file")
done < <(
    grep -rlE "$VIEW_PATTERN" "${existing_paths[@]}" 2>/dev/null | sort || true
)

if ((${#swift_files[@]} == 0)); then
    echo "View naming guard skipped: no SwiftUI View types yet."
    exit 0
fi

violations=()

for file in "${swift_files[@]}"; do
    while IFS= read -r view_type; do
        violations+=("${file#"$ROOT_DIR/"}: $view_type")
    done < <(
        perl -ne 'if (/^\s*(?:(?:private|fileprivate|internal|public)\s+)?struct\s+([A-Za-z_][A-Za-z0-9_]*)\s*:[^{]*\bView\b/) {
            my $name = $1;
            print "$name\n" unless $name =~ /^HIG[A-Z]/ || $name =~ /View$/;
        }' "$file"
    )
done

if ((${#violations[@]} > 0)); then
    echo "SwiftUI View types must use the HIG prefix or end with the View suffix:"
    printf '  %s\n' "${violations[@]}"
    exit 1
fi

echo "View naming guard passed: public components use HIG*, helpers end with View."