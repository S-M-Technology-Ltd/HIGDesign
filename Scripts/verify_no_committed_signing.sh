#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

if rg -n 'DEVELOPMENT_TEAM|PROVISIONING_PROFILE' Sample/HIGDesignSample.xcodeproj/project.pbxproj 2>/dev/null; then
    echo "Committed signing guard failed: keep team/profile overrides in Sample/Config/Signing.local.xcconfig only." >&2
    exit 1
fi

if git ls-files --error-unmatch Sample/Config/Signing.local.xcconfig >/dev/null 2>&1; then
    echo "Committed signing guard failed: Sample/Config/Signing.local.xcconfig must not be tracked." >&2
    exit 1
fi

echo "Committed signing guard passed: no personal signing settings in git."