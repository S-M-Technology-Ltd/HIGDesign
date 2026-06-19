#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

if [[ -f "$ROOT/HIGDesign.xcworkspace/contents.xcworkspacedata" ]]; then
    open "$ROOT/HIGDesign.xcworkspace"
elif [[ -f "$ROOT/Package.swift" ]]; then
    open "$ROOT/Package.swift"
else
    echo "No Package.swift or HIGDesign.xcworkspace found in $ROOT" >&2
    exit 1
fi