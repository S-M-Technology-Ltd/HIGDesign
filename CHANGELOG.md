# Changelog

All notable changes to HIGDesign are documented here. The project follows [Semantic Versioning](https://semver.org/) from v1.0.0 onward.

## 1.0.1 — 2026-06-19

Patch release fixing PhotoPicker build issues, sample-app warnings, and showcase snapshot rendering.

### Fixed

- PhotoPicker iOS build: missing `HIGTokensComponent` imports in showcase and preview views
- `ViewBuilder` `buildLimitedAvailability` warnings in PhotoPicker chrome and album list
- Ten `HIGDesignSample` build warnings (deprecated `onChange`, redundant `await`, Sendable PhotoKit capture, unused values)
- Showcase snapshots rendering as blank/transparent PNGs in headless capture
- Showcase snapshot layout painting content in the bottom half of the canvas with large black margins
- Missing `AccentColor` asset in the sample app catalog

### Changed

- Showcase snapshot capture uses an off-screen `NSWindow` + `NSHostingView` renderer
- Platform showcase snapshots for simple components use a compact 520pt canvas height
- All 385 showcase snapshots re-captured with correct framing and theme backgrounds

## 1.0.0 — 2026-06-19

First stable public release.

### Added

- 33 `HIG*` SwiftUI components across actions, inputs, controls, content, layout, navigation, and feedback
- Layered design token system (raw, semantic, component) with `HIGTheme` environment injection
- Built-in themes: `HIGSystemTheme`, `HIGHighContrastTheme`, `HIGBrandTheme`
- `HIGPhotoPicker` (iOS) with album browsing, preview crop, and limited-library banner
- Sample Xcode project (`Sample/HIGDesignSample.xcodeproj`) for iOS and macOS
- Showcase app (`HIGShowcaseApp`) with theme and Dynamic Type controls
- 385 committed showcase snapshots (198 theme variants + 187 per-platform renders)
- Consumer guide: [Docs/HOW_TO_USE.md](Docs/HOW_TO_USE.md)
- Component token guard: `Scripts/verify_component_token_usage.sh`

### Changed

- All component view code resolves visual values from design tokens (no hardcoded literals)
- Snapshot manifest v2 with platform-specific entries under `Design/Showcase/snapshots/platforms/`

### Platform support

- iOS 18, iPadOS 18, macOS 15, visionOS 2, tvOS 18, watchOS 11
- Swift 6, SwiftUI-only (no UIKit)

## 0.13.0 and earlier

Pre-1.0 phase milestones. See git history on `develop` for incremental component and token deliveries.