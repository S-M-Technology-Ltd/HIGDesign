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
import json, sys
from pathlib import Path

manifest_path = Path(sys.argv[1])
root = Path(sys.argv[2])
require_files = sys.argv[3] == "1"

manifest = json.loads(manifest_path.read_text(encoding="utf-8"))
entries = manifest.get("entries", [])
if not entries:
    raise SystemExit("Showcase snapshot guard failed: manifest has no entries.")

components = sorted({
    line.split("case ", 1)[1].strip()
    for line in Path(root / "Showcase/ShowcaseComponent.swift").read_text(encoding="utf-8").splitlines()
    if "case " in line and "var " not in line and "switch" not in line and ":" in line.split("case ", 1)[-1]
})

# Parse enum cases directly
import re
text = (root / "Showcase/ShowcaseComponent.swift").read_text(encoding="utf-8")
components = sorted(set(re.findall(r"^\s*case ([a-zA-Z]+)\b", text, re.MULTILINE)))

themes = {"system", "highContrast", "brand"}
schemes = {"light", "dark"}
manifest_keys = {(e["component"], e["theme"], e["colorScheme"]) for e in entries}

missing = []
for component in components:
    for theme in themes:
        for scheme in schemes:
            if (component, theme, scheme) not in manifest_keys:
                missing.append(f"{component}-{theme}-{scheme}")

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

print(f"Showcase snapshot guard passed: manifest covers {len(components)} components ({len(entries)} entries).")
PY