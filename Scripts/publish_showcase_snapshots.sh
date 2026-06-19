#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

MANIFEST_PATH="Design/Showcase/manifest.json"
SNAPSHOT_DIR="Design/Showcase/snapshots"
PLATFORM_DIR="$SNAPSHOT_DIR/platforms"

mkdir -p "$SNAPSHOT_DIR" "$PLATFORM_DIR"/{macos,ios,ipados,visionos,tvos,watchos}

components=()
while IFS= read -r component; do
    components+=("$component")
done < <(rg -o 'case ([a-zA-Z]+)' Showcase/ShowcaseComponent.swift | sed -E 's/case //' | sort -u)

if ((${#components[@]} == 0)); then
    echo "No ShowcaseComponent cases found." >&2
    exit 1
fi

python3 - <<'PY' "$MANIFEST_PATH" "$ROOT" "${components[@]}"
import json
import re
import sys
from pathlib import Path

manifest_path = Path(sys.argv[1])
root = Path(sys.argv[2])
components = sys.argv[3:]

text = (root / "Showcase/ShowcaseComponent.swift").read_text(encoding="utf-8")
case_blocks = re.split(r"var supportedSnapshotPlatforms", text)[0]
platform_map = {
    "all": ["macos", "ios", "ipados", "visionos", "tvos", "watchos"],
    "slider": ["macos", "ios", "ipados", "visionos"],
    "segmented_tab": ["macos", "ios", "ipados", "visionos", "tvos"],
    "sidebar": ["macos", "ios", "ipados", "visionos"],
    "photoPicker": ["ios"],
}

def platforms_for(component: str) -> list[str]:
    if component == "photoPicker":
        return platform_map["photoPicker"]
    if component == "slider":
        return platform_map["slider"]
    if component in {"segmentedControl", "tabBar"}:
        return platform_map["segmented_tab"]
    if component == "sidebar":
        return platform_map["sidebar"]
    return platform_map["all"]

themes = ["system", "highContrast", "brand"]
schemes = ["light", "dark"]
entries = []

for component in components:
    for theme in themes:
        for scheme in schemes:
            entries.append({
                "kind": "theme",
                "component": component,
                "theme": theme,
                "colorScheme": scheme,
                "file": f"snapshots/{component}-{theme}-{scheme}.png",
            })

    for platform in platforms_for(component):
        entries.append({
            "kind": "platform",
            "component": component,
            "platform": platform,
            "theme": "system",
            "colorScheme": "light",
            "file": f"snapshots/platforms/{platform}/{component}-system-light.png",
        })

manifest = {"version": 2, "entries": entries}
with open(manifest_path, "w", encoding="utf-8") as handle:
    json.dump(manifest, handle, indent=2)
    handle.write("\n")

theme_count = sum(1 for entry in entries if entry["kind"] == "theme")
platform_count = sum(1 for entry in entries if entry["kind"] == "platform")
print(f"Wrote {len(entries)} manifest entries to {manifest_path} ({theme_count} theme, {platform_count} platform).")
PY

echo "Snapshot publishing scaffold updated."
echo "Capture PNGs with Scripts/capture_showcase_snapshots.sh"