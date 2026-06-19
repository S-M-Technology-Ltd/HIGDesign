#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CONFIG_DIR="$ROOT/Sample/Config"
LOCAL="$CONFIG_DIR/Signing.local.xcconfig"
EXAMPLE="$CONFIG_DIR/Signing.local.xcconfig.example"

if [[ -f "$LOCAL" ]]; then
    echo "Signing.local.xcconfig already exists at:"
    echo "  $LOCAL"
    exit 0
fi

cp "$EXAMPLE" "$LOCAL"
echo "Created local signing config:"
echo "  $LOCAL"
echo "Edit DEVELOPMENT_TEAM before building to a physical iPhone or iPad."