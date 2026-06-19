# Changelog

All notable changes to HIGDesign are documented here. The project follows [Semantic Versioning](https://semver.org/) from v1.0.0 onward.

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