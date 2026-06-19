#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

PATTERN='import UIKit|import UIKit\.|UIColor\.|UIAccessibility\.|UIViewRepresentable|UIViewControllerRepresentable'

if grep -rEn "$PATTERN" Sources Tests >/dev/null 2>&1; then
    grep -rEn "$PATTERN" Sources Tests >&2
    echo "UIKit guard failed: HIGDesign sources must use SwiftUI only." >&2
    exit 1
fi

echo "UIKit guard passed: no UIKit imports or APIs in Sources or Tests."