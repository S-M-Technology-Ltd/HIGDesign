## Unreleased

### Added

### Changed

### Fixed

## 1.6.0 — 2026-07-15

Minor release for Showcase **Components / Pages** navigation, complex application page recipes, feedback Extend parity, and `HIGImageFrame` layout hardening.

### Added

- Showcase root **Components** / **Pages** tabs — library demos vs full app/page recipes
- Complex application page recipes: Ops Dashboard, Analytics Report, Order Desk, Workspace Settings, Support Console, Billing Center, Onboarding Flow
- Semantic `theme.colors.success` role on `HIGColorSemanticTokens`
- `HIGBadgeStyle` success / warning / info roles
- `HIGAlertBannerStyle.success` and optional `onDismiss` on `HIGAlertBanner`
- `HIGToastStyle`, `HIGToastItem`, styled `higToast` / queue enqueue APIs
- `HIGCard` optional subtitle; `HIGProgressView` optional `showsPercentage`
- `HIGImageFrameAspect.portrait` (3:4) and `.custom(CGFloat)` for library tiles and non-preset ratios
- `HIGImageFrame` `showsBorder` and `cornerRadius` overrides for embedding under parent card chrome

### Changed

- `HIGFieldMessage` success kind uses `theme.colors.success`
- Admin port tracker: core Extend rows closed (toast, badge, alerts, button loading, card, progress)
- `HIGImageFrame` fixed-aspect path pins width, fill/fit + clip so intrinsic media size cannot stretch grids

## 1.5.0 — 2026-07-12

Minor release completing the **admin catalog expansion**: optional admin theme, admin shell, panels and wayfinding, advanced forms, Swift Charts family, content hybrids, media surfaces, onboarding coach marks, MapKit map recipe, and Wave 9 Showcase app/page recipes. Zero third-party runtime dependencies.

### Added

#### Themes & shell
- `HIGAdminTheme` / `HIGAdminThemeHue` — optional admin-density theme (Remark-inspired hues, denser spacing)
- Showcase theme choice: **Admin**
- `HIGAdminShell` / `HIGAdminShellStyle` — six shell layouts (sidebar, icon rail, top bar, top icon, centered, drawer)

#### Surfaces & wayfinding
- `HIGPanel`, `HIGPanelGroup`, `HIGWidget`, `HIGDashboardGrid`, `HIGCounter`
- `HIGBreadcrumb`, `HIGPageHeader`, `HIGPagination`, `HIGTabs`, `HIGAccordion`
- `HIGSteps`, `HIGPearlSteps`, `HIGTimeline`, `HIGStatusIndicator`, `HIGEmptyState`

#### Overlays & chrome
- `HIGCloseButton`, `HIGModal`, `HIGTooltipLabel` / `higTooltip`, `HIGPopoverContainer` / `higPopover`
- `HIGDrawer` / `higDrawer`, `higConfirmationDialog`, `HIGNetworkProgressBar`
- `HIGButtonGroup`, `HIGMenuToggle`, `HIGCoachMark` / `higCoachMark`

#### Advanced forms & data
- `HIGInputGroup`, `HIGFieldMessage`, `HIGDatePicker`, `HIGTimePicker`
- `HIGSelect`, `HIGAutocomplete`, `HIGTagInput`, `HIGDropZone`, `HIGDataTable`
- `HIGCalendar`, `HIGTreeView`, `HIGReorderableList`

#### Content hybrids & media
- `HIGCodeBlock`, `HIGCarousel`, `HIGLightbox`, `HIGMediaRow`, `HIGHero`, `HIGListGroup`
- `HIGChatBubble`, `HIGComment`, `HIGCover`, `HIGImageOverlay`, `HIGImageFrame`
- `HIGRibbon`, `HIGPricingCard`, `HIGRating`, `HIGTestimonial`
- `HIGColorSelector`, `HIGSocialButton`, `HIGVideoPlayer`

#### Charts (Swift Charts)
- `HIGBarChart`, `HIGLineChart`, `HIGPieChart`, `HIGAreaChart` (+ `HIGChartPoint`)

#### Showcase recipes (composition only)
- MapKit **Map** recipe (`ShowcaseMapView`)
- Wave 9.1: **13 app recipes** (mailbox → work)
- Wave 9.2: **17 page recipes** covering 34 Remark pages (variants consolidated)

#### Docs & tracker
- `Docs/ADMIN_TEMPLATE_PORT.md` capability tracker
- DocC `AdminCatalog` article; expanded `Components.md` symbol index
- Gallery / HOW_TO_USE / PRD updates for the admin program

### Notes
- Extend rows (toasts polish, button loading, etc.) remain optional follow-ons — see tracker
- No third-party runtime dependencies introduced
- Maps and apps/pages are Showcase recipes, not library business modules

## 1.4.0 — 2026-07-10

Minor release adding a 112-animation matrix loader catalog and multi-platform sample verification gates.

### Added

- `HIGMatrixLoader` — clean-room animated dot-matrix loading indicator with **112** catalog animations (`HIGMatrixLoaderID`: square 23, circular 20, hex 10, 3×3 20, triangle 20, fun 18, icon 1), eight convenience styles, size tokens, Reduce Motion poses, and deterministic `seed` selection
- `HIGMatrixLoaderTokens` / `theme.matrixLoader` component token wiring across system, brand, and high-contrast themes
- Showcase page (full family gallery), unit tests, DocC symbols, and requirements for Matrix Loader
- `Scripts/verify_platform_api_guards.sh` and `Scripts/verify_local_pr.sh` to catch unguarded AppKit/UIKit APIs and require iOS + macOS sample builds

### Fixed

- iOS sample / Showcase build failure from unguarded `Color(nsColor:)` in snapshot platform chrome

## 1.3.1 — 2026-07-06

Patch release polishing macOS showcase snapshots, README discoverability, and GitHub Pages imagery.

### Changed

- Re-captured all macOS platform showcase snapshots with improved window chrome compositing
- README hero and gallery use macOS showcase renders (Button, Long Text Editor, Photo Editor, Card)
- GitHub Pages hero and component gallery updated to macOS snapshot paths
- README discoverability polish: table of contents, star CTA, audience section, and keyword footer

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