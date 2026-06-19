#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

DOCC_DIR="$ROOT/Sources/HIGDesign/HIGDesign.docc"
if [[ ! -d "$DOCC_DIR" ]]; then
    echo "DocC coverage guard failed: missing $DOCC_DIR" >&2
    exit 1
fi

EXPECTED_SYMBOLS=(
    HIGTheme
    HIGThemeableView
    HIGSystemTheme
    HIGHighContrastTheme
    HIGButton
    HIGButtonRole
    HIGButtonSize
    HIGTextField
    HIGToggle
    HIGCheckbox
    HIGRadio
    HIGRadioOption
    HIGSegmentedControl
    HIGSlider
    HIGSecureField
    HIGSearchField
    HIGPicker
    HIGPhotoPicker
    HIGPhotoPickerConfiguration
    HIGPhotoAsset
    HIGPhotoMediaType
    HIGDivider
    HIGProgressView
    HIGCard
    HIGTabBar
    HIGTabItem
    HIGToast
    HIGSidebar
    HIGSidebarItem
    HIGAlertButtonRole
    HIGAlert
    HIGAlertBanner
    HIGAlertBannerStyle
    HIGToastQueue
    HIGToastQueueConfiguration
    HIGNavigationBar
    HIGToolbar
    HIGToolbarTextAction
    HIGNavigationBarDisplayMode
    higPadding
    higToolbar
    higAlert
    higToast
    higToastQueue
    higNavigationBarTitle
    higNavigationBar
    HIGLabel
    HIGLabelStyle
    HIGBadge
    HIGBadgeStyle
    HIGActivityIndicator
    HIGActivityIndicatorSize
    HIGList
    HIGFormSection
    HIGIcon
    HIGIconSize
    HIGIconStyle
    HIGAvatar
    HIGLink
    HIGBulletList
    HIGTextEditor
    HIGStepper
    HIGMenuButton
    HIGTag
    HIGTagStyle
    HIGRemovableTag
    HIGMenuButtonPresentation
    HIGBrandTheme
    HIGActivityIndicatorTokens
    HIGNavigationBarTextAction
    HIGNavigationBarIconAction
    HIGToolbarIconAction
    HIGConditionalView
    HIGScrollableContainer
)

missing=()
for symbol in "${EXPECTED_SYMBOLS[@]}"; do
    if ! grep -rq "${symbol}" "$DOCC_DIR"; then
        missing+=("$symbol")
    fi
done

if ((${#missing[@]} > 0)); then
    echo "DocC coverage guard failed: symbols missing from HIGDesign.docc:" >&2
    printf '  %s\n' "${missing[@]}" >&2
    exit 1
fi

echo "DocC coverage guard passed: public API symbols are documented in HIGDesign.docc."