#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

build_platform() {
    local name="$1"
    local sdk="$2"
    local triple="$3"
    echo "==> Building $name ($triple)"
    swift build --package-path . --sdk "$sdk" --triple "$triple"
}

build_platform "macOS" "$(xcrun --sdk macosx --show-sdk-path)" "$(uname -m)-apple-macosx13.0"
build_platform "iOS" "$(xcrun --sdk iphoneos --show-sdk-path)" "arm64-apple-ios16.0"
build_platform "tvOS" "$(xcrun --sdk appletvos --show-sdk-path)" "arm64-apple-tvos16.0"
build_platform "watchOS" "$(xcrun --sdk watchos --show-sdk-path)" "arm64_32-apple-watchos9.0"
build_platform "visionOS" "$(xcrun --sdk xros --show-sdk-path)" "arm64-apple-xros1.0"

echo "All platform builds succeeded."