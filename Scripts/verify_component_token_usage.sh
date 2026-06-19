#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
COMPONENTS_DIR="$ROOT/Sources/HIGComponents"

if [[ ! -d "$COMPONENTS_DIR" ]]; then
    echo "Component token guard failed: directory not found at $COMPONENTS_DIR" >&2
    exit 1
fi

PATTERNS=(
    'Color\.primary'
    'Color\.secondary'
    'Color\.white'
    'Color\.black'
    'Color\.orange'
    'Color\(\.system'
    '\.padding\([0-9]'
    'spacing: [0-9]'
    'lineWidth: [0-9]'
    'opacity\(0\.'
    'duration: 0\.'
    'frame\(height: [0-9]'
    'frame\(width: [0-9]'
    'cornerRadius\([0-9]'
)

python3 - <<'PY' "$COMPONENTS_DIR" "${PATTERNS[@]}"
import re
import sys
from pathlib import Path

components_dir = Path(sys.argv[1])
patterns = [re.compile(p) for p in sys.argv[2:]]
violations = []

for path in sorted(components_dir.rglob("*.swift")):
    lines = path.read_text(encoding="utf-8").splitlines()
    in_preview = False
    preview_depth = 0

    for index, line in enumerate(lines, start=1):
        stripped = line.strip()

        if stripped.startswith("#if DEBUG"):
            in_preview = True
            preview_depth = 1
            continue

        if in_preview:
            if stripped.startswith("#if"):
                preview_depth += 1
            elif stripped.startswith("#endif"):
                preview_depth -= 1
                if preview_depth == 0:
                    in_preview = False
            continue

        for pattern in patterns:
            if pattern.search(line):
                violations.append(f"{path.relative_to(components_dir.parent.parent)}:{index}:{line.strip()}")
                break

if violations:
    print("Component token guard failed: hardcoded visual literals found.", file=sys.stderr)
    for item in violations:
        print(item, file=sys.stderr)
    raise SystemExit(1)

print("Component token guard passed.")
PY