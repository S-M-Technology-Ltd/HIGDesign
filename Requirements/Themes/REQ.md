# Themes Requirements

## Summary

Theme contract, environment injection, and built-in system themes for HIGDesign.

## All platforms

### Theme contract

- Define `HIGTheme` as the root theme protocol composing semantic and component token providers (including `matrixLoader` for ``HIGMatrixLoader``).
- **Provide protocol extension defaults** for every `HIGTheme` requirement so users can conform with a minimal declaration — override only the token categories or component metrics they want to customise.
- Provide `HIGThemeableView` as the required app integration wrapper.
- Expose `@Environment(\.higTheme)` for component access.
- Missing theme injection is a programmer error and must trap or assert in debug builds.

### Built-in themes

- `HIGSystemTheme` follows the active `ColorScheme`.
- `HIGHighContrastTheme` overrides semantic colors for increased contrast.
- `HIGCompactTheme` optimizes spacing and typography for constrained layouts.
- `HIGAdminTheme` is an **optional** admin-density theme inspired by Remark Admin Template primary hues and page surfaces. It is not the default. Showcase exposes it as a theme choice. Accent skins use `HIGAdminThemeHue`.
- `HIGTheme` includes `panel` component tokens for ``HIGPanel``.
- `HIGTheme` includes `breadcrumb` and `pageHeader` component tokens for ``HIGBreadcrumb`` and ``HIGPageHeader``.
- `HIGTheme` includes `pagination`, `tabs`, and `accordion` component tokens for wayfinding and expandable layout.
- `HIGTheme` includes `steps` and `pearlSteps` component tokens for process indicators.
- `HIGTheme` includes `timeline` component tokens for ``HIGTimeline``.
- `HIGTheme` includes `statusIndicator` and `emptyState` component tokens.
- `HIGTheme` includes `closeButton` and `modal` component tokens for overlay chrome.
- `HIGTheme` includes `tooltip` and `popover` component tokens for helper overlays.

### Runtime behavior

- Theme switching must update dependent views without app restart.
- Themes must not use global singletons as the primary integration path.
- Theme types must be `@MainActor` when they interact with SwiftUI rendering.

### Documentation

- Theme setup must be documented with a three-step quick start:
    1. add package dependency
    2. wrap root view in `HIGThemeableView`
    3. read `higTheme` inside components or custom views

## Requirements

### iOS

- `HIGThemeableView` injects size class environment values from SwiftUI size classes.

### iPadOS

- Theme defaults must not assume compact width only.

### macOS

- Theme defaults must respect desktop color dynamic equivalents and pointer-friendly spacing.

### visionOS

- Theme injection must not break volumetric or windowed SwiftUI scenes.

### tvOS

- Theme defaults must support focus-friendly contrast and larger type.

### watchOS

- `HIGCompactTheme` is the default recommendation for watch apps.

## Out of scope

- Orange, Sosh, or other brand themes
- Runtime theme marketplace or remote theme download
- Application-specific theme persistence