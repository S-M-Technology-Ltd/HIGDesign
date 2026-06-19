# Themes Requirements

## Summary

Theme contract, environment injection, and built-in system themes for HIGDesign.

## All platforms

### Theme contract

- Define `HIGTheme` as the root theme protocol composing semantic and component token providers.
- Provide `HIGThemeableView` as the required app integration wrapper.
- Expose `@Environment(\.higTheme)` for component access.
- Missing theme injection is a programmer error and must trap or assert in debug builds.

### Built-in themes

- `HIGSystemTheme` follows the active `ColorScheme`.
- `HIGHighContrastTheme` overrides semantic colors for increased contrast.
- `HIGCompactTheme` optimizes spacing and typography for constrained layouts.

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

- `HIGThemeableView` injects size class environment values on UIKit-backed platforms.

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