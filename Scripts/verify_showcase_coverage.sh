#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

EXPECTED=(
    button textField toggle divider progressView card tabBar toolbar
    alert toast sidebar navigationBar label badge activityIndicator list form
    checkbox radio segmentedControl slider secureField searchField picker
)

missing=()
for component in "${EXPECTED[@]}"; do
    if ! rg -q "case ${component}" Showcase/ShowcaseComponent.swift; then
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
        HIGTextField) echo textField ;;
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
        HIGTabBar) echo tabBar ;;
        HIGToast) echo toast ;;
        HIGAlertBanner) echo alert ;;
        HIGSidebar) echo sidebar ;;
        HIGLabel) echo label ;;
        HIGBadge) echo badge ;;
        HIGActivityIndicator) echo activityIndicator ;;
        HIGList) echo list ;;
        HIGFormSection) echo form ;;
        *) return 1 ;;
    esac
}

while IFS= read -r component; do
    showcase_key="$(showcase_key_for "$component" || true)"
    if [[ -z "${showcase_key}" ]]; then
        echo "Showcase coverage guard failed: no mapping for ${component}." >&2
        exit 1
    fi
    if ! rg -q "case ${showcase_key}" Showcase/ShowcaseComponent.swift; then
        echo "Showcase coverage guard failed: ${component} has no ShowcaseComponent case (${showcase_key})." >&2
        exit 1
    fi
done < <(rg --no-filename -o 'public struct (HIG[A-Za-z]+): View' Sources/HIGComponents | sed -E 's/public struct (HIG[A-Za-z]+): View/\1/' | sort -u)

echo "Showcase coverage guard passed: all public components are represented in Showcase."