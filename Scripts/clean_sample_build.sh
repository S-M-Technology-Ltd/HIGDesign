#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

if [[ "$(uname -s)" != "Darwin" ]]; then
    echo "Sample clean build requires macOS." >&2
    exit 1
fi

echo "Cleaning Swift package artifacts..."
swift package clean

PROJECT="$ROOT/Sample/HIGDesignSample.xcodeproj"

echo "Cleaning HIGDesignSample Xcode build..."
xcodebuild -project "$PROJECT" -scheme HIGDesignSample -destination 'generic/platform=iOS Simulator' clean >/dev/null

DERIVED_DATA_ROOT="$HOME/Library/Developer/Xcode/DerivedData"
if compgen -G "$DERIVED_DATA_ROOT/HIGDesignSample-*" >/dev/null; then
    echo "Removing stale HIGDesignSample DerivedData..."
    rm -rf "$DERIVED_DATA_ROOT"/HIGDesignSample-*
fi

echo "Sample clean complete. Rebuild HIGDesignSample in Xcode, delete the app from the simulator, then run again."