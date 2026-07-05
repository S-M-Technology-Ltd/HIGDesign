#!/usr/bin/env bash
set -euo pipefail

PACKAGE_URL="https://github.com/S-M-Technology-Ltd/HIGDesign"
SUBMIT_URL="https://swiftpackageindex.com/add-a-package?url=${PACKAGE_URL}"
PACKAGE_PAGE="https://swiftpackageindex.com/S-M-Technology-Ltd/HIGDesign"

cat <<EOF
Swift Package Index — HIGDesign
================================

1. Submit (one-time, ~30 seconds):
   ${SUBMIT_URL}

2. Package page (live after indexing, usually within hours):
   ${PACKAGE_PAGE}

3. Verify: search "HIGDesign" on https://swiftpackageindex.com

Repo checklist for SPI:
  ✓ Public GitHub repository
  ✓ Package.swift at repository root
  ✓ Semantic version tags (v1.0.0, v1.0.1, v1.1.0, v1.2.0, v1.2.1, v1.3.0)
  ✓ MIT license
EOF

if command -v open >/dev/null 2>&1; then
  open "${SUBMIT_URL}"
fi