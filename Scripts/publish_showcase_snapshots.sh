#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

MANIFEST_PATH="Design/Showcase/manifest.json"
SNAPSHOT_DIR="Design/Showcase/snapshots"
THEMES=(system highContrast brand)
SCHEMES=(light dark)

mkdir -p "$SNAPSHOT_DIR"

components=()
while IFS= read -r component; do
    components+=("$component")
done < <(rg -o 'case ([a-zA-Z]+)' Showcase/ShowcaseComponent.swift | sed -E 's/case //' | sort -u)

if ((${#components[@]} == 0)); then
    echo "No ShowcaseComponent cases found." >&2
    exit 1
fi

python3 - <<'PY' "$MANIFEST_PATH" "${components[@]}"
import json, sys
path = sys.argv[1]
components = sys.argv[2:]
themes = ["system", "highContrast", "brand"]
schemes = ["light", "dark"]
entries = []
for component in components:
    for theme in themes:
        for scheme in schemes:
            entries.append({
                "component": component,
                "theme": theme,
                "colorScheme": scheme,
                "file": f"snapshots/{component}-{theme}-{scheme}.png",
            })
manifest = {"version": 1, "entries": entries}
with open(path, "w", encoding="utf-8") as handle:
    json.dump(manifest, handle, indent=2)
    handle.write("\n")
print(f"Wrote {len(entries)} manifest entries to {path}")
PY

echo "Snapshot publishing scaffold updated."
echo "Capture PNGs into ${SNAPSHOT_DIR} using Xcode Previews or Simulator screenshots."
echo "Filenames must match manifest entries, for example: button-system-light.png"