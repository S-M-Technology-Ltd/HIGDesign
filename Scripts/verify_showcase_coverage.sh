#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

EXPECTED=(
    button textField toggle divider progressView card panel breadcrumb pageHeader pagination tabs accordion steps pearlSteps timeline statusIndicator emptyState closeButton modal tooltip popover drawer confirmationDialog networkProgressBar buttonGroup menuToggle inputGroup fieldMessage datePicker timePicker select autocomplete tagInput dataTable dropZone adminShell codeBlock carousel mediaRow hero listGroup barChart lineChart pieChart areaChart tabBar toolbar
    alert toast sidebar navigationBar label badge activityIndicator matrixLoader list form
    checkbox radio segmentedControl slider secureField searchField picker
    icon avatar link bulletList textEditor stepper menuButton tag photoPicker photoEditor longTextEditor
)

missing=()
for component in "${EXPECTED[@]}"; do
    if ! grep -q "case ${component}" Showcase/ShowcaseComponent.swift; then
        missing+=("$component")
    fi
done

if ((${#missing[@]} > 0)); then
    echo "Showcase coverage guard failed: missing ShowcaseComponent cases:" >&2
    printf '  %s\n' "${missing[@]}" >&2
    exit 1
fi

showcase_key_for() {
    case "$1" in
        HIGButton) echo button ;;
        HIGButtonGroup) echo buttonGroup ;;
        HIGMenuToggle) echo menuToggle ;;
        HIGTextField) echo textField ;;
        HIGInputGroup) echo inputGroup ;;
        HIGFieldMessage) echo fieldMessage ;;
        HIGDatePicker) echo datePicker ;;
        HIGTimePicker) echo timePicker ;;
        HIGSelect) echo select ;;
        HIGAutocomplete) echo autocomplete ;;
        HIGTagInput) echo tagInput ;;
        HIGDataTable) echo dataTable ;;
        HIGDropZone) echo dropZone ;;
        HIGAdminShell) echo adminShell ;;
        HIGCodeBlock) echo codeBlock ;;
        HIGCarousel) echo carousel ;;
        HIGMediaRow) echo mediaRow ;;
        HIGHero) echo hero ;;
        HIGListGroup) echo listGroup ;;
        HIGListGroupRow) echo listGroup ;;
        HIGBarChart) echo barChart ;;
        HIGLineChart) echo lineChart ;;
        HIGPieChart) echo pieChart ;;
        HIGAreaChart) echo areaChart ;;
        HIGToggle) echo toggle ;;
        HIGCheckbox) echo checkbox ;;
        HIGRadio) echo radio ;;
        HIGSegmentedControl) echo segmentedControl ;;
        HIGSlider) echo slider ;;
        HIGSecureField) echo secureField ;;
        HIGSearchField) echo searchField ;;
        HIGPicker) echo picker ;;
        HIGDivider) echo divider ;;
        HIGProgressView) echo progressView ;;
        HIGCard) echo card ;;
        HIGPanel) echo panel ;;
        HIGBreadcrumb) echo breadcrumb ;;
        HIGPageHeader) echo pageHeader ;;
        HIGPagination) echo pagination ;;
        HIGTabs) echo tabs ;;
        HIGAccordion) echo accordion ;;
        HIGAccordionSection) echo accordion ;;
        HIGSteps) echo steps ;;
        HIGPearlSteps) echo pearlSteps ;;
        HIGTimeline) echo timeline ;;
        HIGStatusIndicator) echo statusIndicator ;;
        HIGEmptyState) echo emptyState ;;
        HIGCloseButton) echo closeButton ;;
        HIGModal) echo modal ;;
        HIGTooltipLabel) echo tooltip ;;
        HIGPopoverContainer) echo popover ;;
        HIGDrawer) echo drawer ;;
        HIGNetworkProgressBar) echo networkProgressBar ;;
        HIGTabBar) echo tabBar ;;
        HIGToast) echo toast ;;
        HIGAlertBanner) echo alert ;;
        HIGAlert) echo alert ;;
        HIGSidebar) echo sidebar ;;
        HIGLabel) echo label ;;
        HIGBadge) echo badge ;;
        HIGActivityIndicator) echo activityIndicator ;;
        HIGMatrixLoader) echo matrixLoader ;;
        HIGList) echo list ;;
        HIGFormSection) echo form ;;
        HIGIcon) echo icon ;;
        HIGAvatar) echo avatar ;;
        HIGLink) echo link ;;
        HIGBulletList) echo bulletList ;;
        HIGTextEditor) echo textEditor ;;
        HIGStepper) echo stepper ;;
        HIGMenuButton) echo menuButton ;;
        HIGTag) echo tag ;;
        HIGRemovableTag) echo tag ;;
        HIGNavigationBar) echo navigationBar ;;
        HIGNavigationBarTextAction) echo navigationBar ;;
        HIGNavigationBarIconAction) echo navigationBar ;;
        HIGToolbar) echo toolbar ;;
        HIGToolbarTextAction) echo toolbar ;;
        HIGToolbarIconAction) echo toolbar ;;
        HIGPhotoPicker) echo photoPicker ;;
        HIGPhotoEditor) echo photoEditor ;;
        HIGLongTextEditor) echo longTextEditor ;;
        *) return 1 ;;
    esac
}

while IFS= read -r component; do
    showcase_key="$(showcase_key_for "$component" || true)"
    if [[ -z "${showcase_key}" ]]; then
        echo "Showcase coverage guard failed: no mapping for ${component}." >&2
        exit 1
    fi
    if ! grep -q "case ${showcase_key}" Showcase/ShowcaseComponent.swift; then
        echo "Showcase coverage guard failed: ${component} has no ShowcaseComponent case (${showcase_key})." >&2
        exit 1
    fi
done < <(
    grep -rhoE 'public struct (HIG[A-Za-z]+).*: View( \{| where)' Sources/HIGComponents 2>/dev/null \
        | sed -E 's/public struct (HIG[A-Za-z]+).*/\1/' \
        | sort -u
)

echo "Showcase coverage guard passed: all public components are represented in Showcase."