#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

if [[ "$(uname -s)" != "Darwin" ]]; then
    echo "Showcase snapshot diff verification requires macOS." >&2
    exit 1
fi

TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

export HIG_SNAPSHOT_OUTPUT_ROOT="$TMP"
Scripts/publish_showcase_snapshots.sh >/dev/null
swift build --package-path . --target HIGSnapshotCapture >/dev/null
swift run --package-path . --skip-build HIGSnapshotCapture >/dev/null

python3 - <<'PY' "$ROOT" "$TMP"
import hashlib
import json
import sys
from pathlib import Path

root = Path(sys.argv[1])
temp_root = Path(sys.argv[2])
manifest = json.loads((root / "Design/Showcase/manifest.json").read_text(encoding="utf-8"))

mismatches = []
missing = []

for entry in manifest.get("entries", []):
    relative = entry["file"]
    committed = root / "Design/Showcase" / relative
    captured = temp_root / relative

    if not committed.is_file():
        missing.append(relative)
        continue
    if not captured.is_file():
        missing.append(f"captured:{relative}")
        continue

    committed_hash = hashlib.sha256(committed.read_bytes()).hexdigest()
    captured_hash = hashlib.sha256(captured.read_bytes()).hexdigest()
    if committed_hash != captured_hash:
        mismatches.append(relative)

if missing:
    print("Showcase snapshot diff failed: missing files:", file=sys.stderr)
    for item in missing:
        print(f"  {item}", file=sys.stderr)
    raise SystemExit(1)

if mismatches:
    print("Showcase snapshot diff failed: committed PNGs differ from capture output:", file=sys.stderr)
    for item in mismatches:
        print(f"  {item}", file=sys.stderr)
    print("Run Scripts/capture_showcase_snapshots.sh and commit updated PNGs.", file=sys.stderr)
    raise SystemExit(1)

print(f"Showcase snapshot diff passed: {len(manifest.get('entries', []))} PNGs match committed artifacts.")
PY