#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

if [[ "$(uname -s)" != "Darwin" ]]; then
    echo "Showcase snapshot capture requires macOS." >&2
    exit 1
fi

Scripts/publish_showcase_snapshots.sh
swift build --package-path . --target HIGSnapshotCapture
swift run --package-path . --skip-build HIGSnapshotCapture
REQUIRE_SNAPSHOT_FILES=1 Scripts/verify_showcase_snapshots_present.sh

echo "Showcase snapshot capture complete."