#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

if [[ "$(uname -s)" != "Darwin" ]]; then
    echo "Sample Xcode project verification requires macOS." >&2
    exit 1
fi

PROJECT="$ROOT/Sample/HIGDesignSample.xcodeproj"

INFO_PLIST="$ROOT/Sample/HIGDesignSample/Info.plist"

if ! grep -q 'INFOPLIST_FILE = HIGDesignSample/Info.plist' "$PROJECT/project.pbxproj"; then
    echo "Sample Xcode project guard failed: iOS target is missing INFOPLIST_FILE." >&2
    exit 1
fi

if ! grep -q 'NSPhotoLibraryUsageDescription' "$INFO_PLIST"; then
    echo "Sample Xcode project guard failed: Info.plist is missing NSPhotoLibraryUsageDescription." >&2
    exit 1
fi

if ! grep -q 'PHPhotoLibraryPreventAutomaticLimitedAccessAlert' "$INFO_PLIST"; then
    echo "Sample Xcode project guard failed: Info.plist is missing PHPhotoLibraryPreventAutomaticLimitedAccessAlert." >&2
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