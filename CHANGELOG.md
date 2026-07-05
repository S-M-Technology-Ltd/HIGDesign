# Changelog

All notable changes to HIGDesign are documented here. The project follows [Semantic Versioning](https://semver.org/) from v1.0.0 onward.

## 1.3.0 — 2026-07-05

Minor release adding photo and long-form text editing, liquid-glass button styling, and a device-framed showcase snapshot pipeline.

### Added

- `HIGPhotoEditor` for crop, rotate, and aspect-ratio editing on iOS and macOS
- `HIGLongTextEditor` for rich HTML long-form editing with a formatting toolbar
- `HIGButtonStyle` with liquid glass support on iOS 26+ and bordered fallback
- Pixel-matched showcase snapshot pipeline with iPhone device frames and macOS window chrome
- `ImageLoadingClient` for PhotoPicker image loading (serial-queue concurrency model)
- Showcase welcome landing, A–Z catalog sort, and shared `ShowcaseSnapshotCatalogDetail`
- `Scripts/capture_ios_showcase_snapshots.sh` and `Scripts/verify_photo_editor_token_usage.sh`

### Changed

- PhotoPicker image loading migrated from `PhotoKitCoordinator` actor to `ImageLoadingClient`
- `HIGPhotoEditor` expanded for macOS with platform-appropriate chrome and toolbar
- Regenerated platform showcase snapshots with device frames and catalog chrome
- README hero uses a single iPhone showcase snapshot

### Fixed

- Sample app `Info.plist` keys for limited photo library access
- macOS showcase snapshot compositing and native window chrome capture

## 1.2.1 — 2026-06-27

Patch release fixing theme registration crashes, Heroicon scaling at large sizes, and Showcase preview and documentation polish.

### Fixed

- `HIGThemeManager` and `@Environment(\.higTheme)` crash when icons resolve during view body builds (synchronous theme registration)
- Heroicons distorting at large fixed sizes (e.g. 48pt) by rendering in the native 24pt view box and scaling uniformly
- Xcode Showcase previews crashing with `HIGTheme is required` (`ShowcasePreviewContainer`)

### Added

- Showcase Icon playground in settings (family, token, variant, size up to 512pt, style, tint)
- `ShowcaseSampleView`, `ShowcaseCodeSnippetView`, and API snippets beneath every showcase sample
- `Scripts/verify_showcase_token_usage.sh` and `Scripts/migrate_showcase_tokens.py`
- Activity Indicator showcase grid layout tuned for code-bearing tiles

### Changed

- Showcase view code migrated to design tokens (no hardcoded spacing, fonts, or colors)
- Improved Activity Indicator showcase grid columns for compact and regular size classes

## 1.2.0 — 2026-06-26

Minor release adding Heroicons v2 integration, Dynamic Type–aware icon sizing, and custom icon size and tint options.

### Added

- `HIGIcons` module with Heroicons v2 24pt outline and solid sets (324 icons)
- `HIGHeroIconToken`, `HIGHeroIcon`, `HIGHeroIconVariant`, and `HIGThemeManager` for token-based icon resolution
- `HIGDesignIcons` SPM product for icon-only consumers
- `Scripts/generate_hero_icons.py` to regenerate the icon catalog and Swift tokens from Heroicons source
- `HIGScaledDimension` helper for Dynamic Type–aware icon sizing
- `HIGIconSize.fixed(CGFloat)` and `HIGIconStyle.tint(Color)` for custom icon size and color

### Changed

- `HIGIcon` and `HIGHeroIcon` scale with system Dynamic Type by default
- `HIGIconSize` and `HIGIconStyle` moved to `HIGTokensComponent` and `HIGThemesContract` respectively for shared use across icon components
- Showcase Icon page demonstrates SF Symbols and Heroicons with Dynamic Type scaling

## 1.1.0 — 2026-06-20

Minor release adding custom activity indicator styles, a shimmer placeholder modifier, and PhotoPicker Swift concurrency improvements.

### Added

- `HIGActivityIndicatorStyle` with ten custom indicator styles (orbital, pulsing, arcs, rotating dots, flickering dots, scaling dots, opacity dots, equalizer, growing circle, gradient) alongside the system default
- `higShimmer(isActive:mode:)` modifier with `HIGShimmerMode` and `HIGShimmerTokens` wired through all built-in themes
- `PhotoKitCoordinator` actor for PhotoPicker image loading and caching
- `Scripts/verify_no_gcd.sh` to enforce Swift concurrency over GCD in library sources
- Unified pull request template and portable `grep`-based verification scripts

### Changed

- PhotoPicker image loading and library access migrated from GCD to Swift concurrency (`async`/`await`, actors)
- Picker chrome buttons use liquid glass style on iOS 26+ with bordered fallback
- Activity indicator showcase subsection expanded with all custom styles and shimmer examples
- Updated activity indicator showcase snapshots across theme and platform matrices

### Removed

- GitHub Actions PR Checks workflow and orchestrator scripts (`run_pr_checks.sh`, `run_governance_checks.sh`, `run_macos_checks.sh`)

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