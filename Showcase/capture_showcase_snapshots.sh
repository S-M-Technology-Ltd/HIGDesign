#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

if [[ "$(uname -s)" != "Darwin" ]]; then
    echo "Showcase snapshot capture requires macOS." >&2
    exit 1
fi

Scripts/publish_showcase_snapshots.sh

export HIG_SNAPSHOT_SKIP_MOBILE_PLATFORMS=1
export HIG_SNAPSHOT_OUTPUT_ROOT="$ROOT/Design/Showcase"

swift build --package-path . --target HIGSnapshotCapture
swift run --package-path . --skip-build HIGSnapshotCapture

echo "Capturing iOS/iPadOS platform snapshots on Simulator..."
HIG_SNAPSHOT_PILOT="${HIG_SNAPSHOT_PILOT:-}" Scripts/capture_ios_showcase_snapshots.sh

if [[ "${HIG_SNAPSHOT_PILOT:-}" != "1" ]]; then
    REQUIRE_SNAPSHOT_FILES=1 Scripts/verify_showcase_snapshots_present.sh
fi

echo "Showcase snapshot capture complete."