# Tokens Requirements

## Summary

Three-layer design token system for HIGDesign: Raw, Semantic, and Component tokens.

## All platforms

### Raw tokens

- Raw tokens represent Apple system primitives or documented HIG measurements.
- Categories include color, typography, spacing, radius, border, elevation, opacity, motion, grid, and icon identifiers.
- Heroicons v2 24pt outline and solid sets are available through `HIGHeroIconToken` in `HIGIcons`.
- Icon size tokens are base point values. `HIGIcon` and `HIGHeroIcon` scale them with the system Dynamic Type size by default.
- Raw spacing uses a 4pt base grid.
- Raw typography maps to system text styles, not custom font families.
- Raw colors reference SwiftUI semantic colors or dynamic equivalents. UIKit color APIs are not permitted.

### Semantic tokens

- Semantic tokens express HIG roles such as `label.primary`, `background.secondary`, `separator`, and `accent`.
- Semantic tokens are protocol-based so themes can override values.
- Semantic color tokens must resolve correctly in light mode, dark mode, and increased contrast.
- Semantic typography tokens must map to Dynamic Type text styles.

### Component tokens

- Component tokens belong to one component family only.
- Examples include button height, field padding, badge radius, and card elevation.
- Component tokens consume semantic tokens; they must not reach into unrelated component families.
- Component view code must not hardcode UI dimensions, colors, opacity, padding, width, height, corner radius, or spacing literals. Resolve those values from `theme.<component>` or semantic tokens.
- `HIGPhotoEditorTokens` defines crop canvas, overlay, toolbar, and zoom values for ``HIGPhotoEditor``.
- `HIGMatrixLoaderTokens` defines grid count, diameters, gap fraction, opacity range, and cycle duration for ``HIGMatrixLoader``.
- `HIGPanelTokens` defines corner radius, content padding, header spacing, border width, action icon size, minimum action target, and title/description fonts for ``HIGPanel``.
- `HIGBreadcrumbTokens` defines link/current fonts, item spacing, separator size, and minimum tap target for ``HIGBreadcrumb``.
- `HIGPageHeaderTokens` defines title/subtitle fonts and stack/breadcrumb spacing for ``HIGPageHeader``.
- `HIGPaginationTokens` defines page button metrics for ``HIGPagination``.
- `HIGTabsTokens` defines fonts, underline height, and spacing for ``HIGTabs``.
- `HIGAccordionTokens` defines header/content metrics for ``HIGAccordion`` / ``HIGAccordionSection``.
- `HIGStepsTokens` defines indicator, connector, and label metrics for ``HIGSteps``.
- `HIGPearlStepsTokens` defines pearl sizes and connectors for ``HIGPearlSteps``.
- `HIGTimelineTokens` defines marker, connector, and typography metrics for ``HIGTimeline``.
- `HIGStatusIndicatorTokens` defines diameters and border width for ``HIGStatusIndicator``.
- `HIGEmptyStateTokens` defines icon size, fonts, spacing, and max content width for ``HIGEmptyState``.
- `HIGCloseButtonTokens` defines tap target and icon size for ``HIGCloseButton``.
- `HIGModalTokens` defines padding, radius, max width, and header typography for ``HIGModal``.
- `HIGTooltipTokens` defines padding, radius, font, and max width for ``HIGTooltipLabel``.
- `HIGPopoverTokens` defines padding, radius, border, and max width for ``HIGPopoverContainer``.
- `HIGDrawerTokens` defines width, padding, scrim opacity, and header metrics for ``HIGDrawer``.
- `HIGNetworkProgressBarTokens` defines height, corner radius, and indeterminate band fraction for ``HIGNetworkProgressBar``.
- `HIGButtonGroupTokens` defines inter-button spacing for ``HIGButtonGroup``.
- `HIGMenuToggleTokens` defines tap target and line metrics for ``HIGMenuToggle``.
- `HIGInputGroupTokens` defines height, padding, radius, and adornment spacing for ``HIGInputGroup``.
- `HIGFieldMessageTokens` defines font, icon size, and spacing for ``HIGFieldMessage``.
- `HIGDatePickerTokens` defines min height and font for ``HIGDatePicker`` and ``HIGTimePicker``.
- `HIGSelectTokens` defines field chrome, chevron, chip spacing, and suggestion metrics for ``HIGSelect``, ``HIGAutocomplete``, and ``HIGTagInput``.
- `HIGDataTableTokens` defines header/cell fonts, padding, row height, borders, and column metrics for ``HIGDataTable``.
- `HIGDropZoneTokens` defines min height, dash border, padding, icon size, and fonts for ``HIGDropZone``.
- `HIGAdminShellTokens` defines brand/content padding, brand font, and sidebar column widths for ``HIGAdminShell``.
- `HIGCodeBlockTokens` defines monospaced font, padding, radius, and max height for ``HIGCodeBlock``.
- `HIGCarouselTokens` defines min height, radius, indicator metrics, and content padding for ``HIGCarousel``.
- `HIGMediaRowTokens` defines padding, spacing, fonts, and border metrics for ``HIGMediaRow``.
- `HIGHeroTokens` defines min height, padding, spacing, radius, and fonts for ``HIGHero``.
- `HIGListGroupTokens` defines row metrics, fonts, and border chrome for ``HIGListGroup`` and ``HIGListGroupRow``.
- `HIGBarChartTokens` defines plot height, padding, radius, and fonts for ``HIGBarChart``.
- `HIGLineChartTokens` defines plot height, padding, line width, symbol size, and fonts for ``HIGLineChart``.
- `HIGPieChartTokens` defines plot height, padding, sector inset, donut radius, and fonts for ``HIGPieChart``.
- `HIGAreaChartTokens` defines plot height, padding, line width, and fonts for ``HIGAreaChart``.

### Naming and API

- Public token protocols and enums use the `HIG` prefix.
- Token APIs must be deterministic and side-effect free.
- Token changes require unit tests.

## Requirements

### iOS

- Raw spacing and typography defaults assume phone-first layouts with compact width support.

### iPadOS

- Grid and spacing tokens must support regular width layouts and larger readable widths.

### macOS

- Typography and spacing tokens must support desktop density without breaking Dynamic Type scaling.

### visionOS

- Elevation and materials tokens must be available for depth-aware surfaces.

### tvOS

- Component token defaults must support larger text and focus-friendly dimensions.

### watchOS

- Spacing and typography defaults must support compact watch layouts.

## Out of scope

- Brand-specific token packs beyond system defaults in the first milestone
- Figma import pipelines
- Runtime token editing UI