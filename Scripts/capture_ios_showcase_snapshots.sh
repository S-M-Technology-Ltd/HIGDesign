#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

if [[ "$(uname -s)" != "Darwin" ]]; then
    echo "iOS showcase snapshot capture requires macOS." >&2
    exit 1
fi

DERIVED_DATA="${TMPDIR:-/tmp}/hig-ios-snapshot-derived"
DESTINATION="${HIG_IOS_SNAPSHOT_DESTINATION:-platform=iOS Simulator,name=iPhone 17 Pro}"
BUNDLE_ID="${HIG_IOS_SNAPSHOT_BUNDLE_ID:-HIGDesign.HIGShowcaseApp}"

rm -rf "$DERIVED_DATA"

xcodebuild build \
    -scheme HIGShowcaseApp \
    -destination "$DESTINATION" \
    -derivedDataPath "$DERIVED_DATA" \
    > /tmp/hig-ios-snapshot-build.log 2>&1

PRODUCTS_DIR="$DERIVED_DATA/Build/Products/Debug-iphonesimulator"
EXECUTABLE_PATH="$PRODUCTS_DIR/HIGShowcaseApp"
if [[ ! -x "$EXECUTABLE_PATH" ]]; then
    echo "Failed to locate HIGShowcaseApp executable. See /tmp/hig-ios-snapshot-build.log" >&2
    exit 1
fi

APP_PATH="$DERIVED_DATA/Build/Products/Debug-iphonesimulator/HIGShowcaseApp.app"
rm -rf "$APP_PATH"
mkdir -p "$APP_PATH"

cat > "$APP_PATH/Info.plist" <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>CFBundleDevelopmentRegion</key>
    <string>en</string>
    <key>CFBundleExecutable</key>
    <string>HIGShowcaseApp</string>
    <key>CFBundleIdentifier</key>
    <string>$BUNDLE_ID</string>
    <key>CFBundleName</key>
    <string>HIGShowcaseApp</string>
    <key>CFBundlePackageType</key>
    <string>APPL</string>
    <key>CFBundleShortVersionString</key>
    <string>1.0</string>
    <key>CFBundleVersion</key>
    <string>1</string>
    <key>LSRequiresIPhoneOS</key>
    <true/>
    <key>MinimumOSVersion</key>
    <string>18.0</string>
    <key>NSPhotoLibraryUsageDescription</key>
    <string>HIGShowcase needs photo library access to demonstrate HIGPhotoPicker.</string>
    <key>PHPhotoLibraryPreventAutomaticLimitedAccessAlert</key>
    <true/>
</dict>
</plist>
EOF

cp "$EXECUTABLE_PATH" "$APP_PATH/HIGShowcaseApp"
chmod +x "$APP_PATH/HIGShowcaseApp"
for bundle in "$PRODUCTS_DIR"/*.bundle; do
    [[ -d "$bundle" ]] || continue
    cp -R "$bundle" "$APP_PATH/"
done

DEVICE_NAME="${HIG_IOS_SNAPSHOT_DEVICE_NAME:-iPhone 17 Pro}"
export DEVICE_NAME
DEVICE_ID="$(xcrun simctl list devices available -j | python3 -c "
import json, os, sys
name = os.environ.get('DEVICE_NAME', '')
data = json.load(sys.stdin)
for runtime, devices in data.get('devices', {}).items():
    if 'iOS' not in runtime:
        continue
    for device in devices:
        if device.get('name') == name and device.get('isAvailable', True):
            print(device['udid'])
            sys.exit(0)
sys.exit(1)
" 2>/dev/null || true)"
if [[ -z "$DEVICE_ID" ]]; then
    DEVICE_ID="$(xcrun simctl list devices available | rg -m1 'iPhone' | rg -o '[0-9A-F-]{36}')"
fi
if [[ -z "$DEVICE_ID" ]]; then
    echo "No available iPhone simulator found." >&2
    exit 1
fi

xcrun simctl boot "$DEVICE_ID" >/dev/null 2>&1 || true
xcrun simctl install "$DEVICE_ID" "$APP_PATH"

# simctl launch only forwards env vars prefixed with SIMCTL_CHILD_.
SIMCTL_CHILD_HIG_CAPTURE_IOS_SNAPSHOTS=1 \
SIMCTL_CHILD_HIG_SNAPSHOT_REPO_ROOT="$ROOT" \
SIMCTL_CHILD_HIG_SNAPSHOT_OUTPUT_ROOT="$ROOT/Design/Showcase" \
SIMCTL_CHILD_HIG_SNAPSHOT_PILOT="${HIG_SNAPSHOT_PILOT:-}" \
xcrun simctl launch --console "$DEVICE_ID" "$BUNDLE_ID" 2>&1 | tee /tmp/hig-ios-snapshot-launch.log

if ! rg -q "Captured iOS showcase snapshots" /tmp/hig-ios-snapshot-launch.log; then
    echo "iOS showcase snapshot capture failed. See /tmp/hig-ios-snapshot-launch.log" >&2
    exit 1
fi

echo "iOS showcase snapshot capture complete."