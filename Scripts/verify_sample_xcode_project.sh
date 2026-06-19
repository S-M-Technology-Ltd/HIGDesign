#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

if [[ "$(uname -s)" != "Darwin" ]]; then
    echo "Sample Xcode project verification requires macOS." >&2
    exit 1
fi

PROJECT="$ROOT/Sample/HIGDesignSample.xcodeproj"

if ! rg -q 'INFOPLIST_KEY_NSPhotoLibraryUsageDescription' "$PROJECT/project.pbxproj"; then
    echo "Sample Xcode project guard failed: iOS target is missing NSPhotoLibraryUsageDescription." >&2
    exit 1
fi

if ! rg -q 'INFOPLIST_KEY_PHPhotoLibraryPreventAutomaticLimitedAccessAlert' "$PROJECT/project.pbxproj"; then
    echo "Sample Xcode project guard failed: iOS target is missing PHPhotoLibraryPreventAutomaticLimitedAccessAlert." >&2
    exit 1
fi

xcodebuild \
    -project "$PROJECT" \
    -scheme HIGDesignSampleMac \
    -destination 'platform=macOS' \
    build >/dev/null

xcodebuild \
    -project "$PROJECT" \
    -scheme HIGDesignSample \
    -destination 'generic/platform=iOS Simulator' \
    build >/dev/null

echo "Sample Xcode project guard passed: HIGDesignSample and HIGDesignSampleMac build successfully."