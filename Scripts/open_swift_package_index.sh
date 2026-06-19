#!/usr/bin/env bash
set -euo pipefail

PACKAGE_URL="https://github.com/S-M-Technology-Ltd/HIGDesign"
SUBMIT_URL="https://swiftpackageindex.com/add-a-package?url=${PACKAGE_URL}"

echo "HIGDesign Swift Package Index"
echo "Package URL: ${PACKAGE_URL}"
echo ""
echo "If the package is not listed yet, submit it at:"
echo "  ${SUBMIT_URL}"
echo ""
echo "Package page (after indexing):"
echo "  https://swiftpackageindex.com/S-M-Technology-Ltd/HIGDesign"
echo ""

if command -v open >/dev/null 2>&1; then
  open "${SUBMIT_URL}"
fi