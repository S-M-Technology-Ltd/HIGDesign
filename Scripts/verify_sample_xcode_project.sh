#!/usr/bin/env bash
# Verifies the Xcode sample app builds for **both** iOS Simulator and macOS.
# Always run this after Showcase / Sample / multi-platform API changes.
# `swift test` alone is not enough — it does not compile the sample iOS target.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

if [[ "$(uname -s)" != "Darwin" ]]; then
    echo "Sample Xcode project verification requires macOS." >&2
    exit 1
fi

# Fast static guard (seconds) before expensive xcodebuild (minutes).
echo "==> Platform API guards (Showcase / Sources / Sample)"
"$ROOT/Scripts/verify_platform_api_guards.sh"

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

echo "==> Building HIGDesignSampleMac (macOS)"
xcodebuild \
    -project "$PROJECT" \
    -scheme HIGDesignSampleMac \
    -destination 'platform=macOS' \
    build

echo "==> Building HIGDesignSample (iOS Simulator)"
xcodebuild \
    -project "$PROJECT" \
    -scheme HIGDesignSample \
    -destination 'generic/platform=iOS Simulator' \
    build

echo "Sample Xcode project guard passed: HIGDesignSample and HIGDesignSampleMac build successfully."