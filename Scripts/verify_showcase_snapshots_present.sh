#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

MANIFEST_PATH="$ROOT/Design/Showcase/manifest.json"
REQUIRE_FILES="${REQUIRE_SNAPSHOT_FILES:-0}"

if [[ ! -f "$MANIFEST_PATH" ]]; then
    echo "Showcase snapshot guard failed: missing $MANIFEST_PATH" >&2
    echo "Run Scripts/publish_showcase_snapshots.sh to generate the manifest." >&2
    exit 1
fi

python3 - <<'PY' "$MANIFEST_PATH" "$ROOT" "$REQUIRE_FILES"
import json
import re
import sys
from pathlib import Path

manifest_path = Path(sys.argv[1])
root = Path(sys.argv[2])
require_files = sys.argv[3] == "1"

manifest = json.loads(manifest_path.read_text(encoding="utf-8"))
entries = manifest.get("entries", [])
if not entries:
    raise SystemExit("Showcase snapshot guard failed: manifest has no entries.")

text = (root / "Showcase/ShowcaseComponent.swift").read_text(encoding="utf-8")
components = sorted(set(re.findall(r"^\s*case ([a-zA-Z]+)\b", text, re.MULTILINE)))

platform_map = {
    "photoPicker": ["ios"],
    "photoEditor": ["ios"],
    "slider": ["macos", "ios", "ipados", "visionos"],
    "segmentedControl": ["macos", "ios", "ipados", "visionos", "tvos"],
    "tabBar": ["macos", "ios", "ipados", "visionos", "tvos"],
    "sidebar": ["macos", "ios", "ipados", "visionos"],
}

def platforms_for(component: str) -> list[str]:
    if component in platform_map:
        return platform_map[component]
    return ["macos", "ios", "ipados", "visionos", "tvos", "watchos"]

themes = {"system", "highContrast", "brand"}
schemes = {"light", "dark"}

theme_keys = {
    (e["component"], e["theme"], e["colorScheme"])
    for e in entries
    if e.get("kind", "theme") == "theme"
}
platform_keys = {
    (e["component"], e["platform"])
    for e in entries
    if e.get("kind") == "platform"
}

missing = []
for component in components:
    for theme in themes:
        for scheme in schemes:
            if (component, theme, scheme) not in theme_keys:
                missing.append(f"theme:{component}-{theme}-{scheme}")
    for platform in platforms_for(component):
        if (component, platform) not in platform_keys:
            missing.append(f"platform:{component}-{platform}")

if missing:
    print("Showcase snapshot guard failed: manifest missing entries:", file=sys.stderr)
    for item in missing:
        print(f"  {item}", file=sys.stderr)
    raise SystemExit(1)

if require_files:
    missing_files = []
    for entry in entries:
        file_path = root / "Design/Showcase" / entry["file"]
        if not file_path.is_file():
            missing_files.append(entry["file"])
    if missing_files:
        print("Showcase snapshot guard failed: missing PNG files:", file=sys.stderr)
        for item in missing_files:
            print(f"  {item}", file=sys.stderr)
        raise SystemExit(1)

print(
    f"Showcase snapshot guard passed: manifest covers {len(components)} components ({len(entries)} entries)."
)
PY