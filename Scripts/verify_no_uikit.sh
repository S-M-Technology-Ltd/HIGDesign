#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

PATTERN='import UIKit|import UIKit\.|UIColor\.|UIAccessibility\.|UIViewRepresentable|UIViewControllerRepresentable'

if rg -n "$PATTERN" Sources Tests; then
    echo "UIKit guard failed: HIGDesign sources must use SwiftUI only." >&2
    exit 1
fi

echo "UIKit guard passed: no UIKit imports or APIs in Sources or Tests."