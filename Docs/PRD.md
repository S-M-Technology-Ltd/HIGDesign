# HIGDesign PRD

Module-level business requirements with per-platform sections (`### iOS`, `### iPadOS`, `### macOS`, `### visionOS`, `### tvOS`, `### watchOS`) live in [`Requirements/`](../Requirements/README.md). This PRD stays the product overview; detailed BA acceptance criteria belong in each module's `REQ.md`.

## Summary

HIGDesign is a native Apple-platform SwiftUI design system library for building applications that follow Apple Human Interface Guidelines consistently across iOS, iPadOS, macOS, visionOS, tvOS, and watchOS. The package is SwiftUI-only and supports OS releases from the latest three calendar years.

The library provides:

- A layered design token system.
- A theme contract and built-in system themes.
- Reusable `HIG*` SwiftUI components.
- Cross-platform modifiers and adapters.
- Optional bridging for SwiftUI gaps.
- A Showcase app for visual verification and documentation.

## Problem

Teams building multi-platform Apple apps repeatedly reimplement the same HIG decisions:

- semantic color usage
- typography scale and Dynamic Type behavior
- spacing and layout conventions
- component states and accessibility
- platform-specific adaptations for Mac, TV, watch, and vision

HIGDesign centralizes those decisions in one testable Swift package.

## Target Users

### App developers

Developers building SwiftUI apps who want HIG-correct components without adopting a brand-specific design system.

### Design-system maintainers

Teams that need a theme contract, token layers, and modular package boundaries for white-label or custom themes.

### Agent-assisted contributors

Coding agents and reviewers who need explicit BA requirements, coding rules, and HIG checklists before implementation.

## Product Principles

1. Apple HIG is the source of truth.
2. System colors, SF Pro, and SF Symbols come first.
3. Native SwiftUI is the default implementation path.
4. Themes are environment-driven, not singleton-driven.
5. Modules stay small, explicit, and acyclic.
6. Accessibility is part of the definition of done.
7. Platform differences are intentional and documented.

## Reference Inputs

HIGDesign synthesizes architecture and patterns from:

- `../ouds-ios` for token layers, theme contract, modular SPM products, and accessibility discipline
- `../SwiftUIX` for platform abstraction and optional bridging
- `../SwiftUI-Design-System-Pro` for token categories and modifier DSL ideas
- `../promptory-apple` for agent rules, BA requirements structure, and HIG review process

## Package Products

| Product | Purpose |
|---------|---------|
| `HIGDesign` | Umbrella import for tokens, themes, components, and modifiers |
| `HIGDesignCore` | Foundations, tokens, and theme contract |
| `HIGDesignComponents` | Public `HIG*` components and modifiers |
| `HIGDesignPlatform` | Idiom and capability adapters |
| `HIGDesignBridging` | Optional Cocoa bridges |

## Current Milestone: Admin catalog expansion (post-v1.4.0)

Next program after v1.4.0: port **all** Remark Admin Template capabilities into HIG-native components, optional `HIGAdminTheme`, admin shell, charts (Swift Charts), and Showcase recipes. Tracker: [`Docs/ADMIN_TEMPLATE_PORT.md`](ADMIN_TEMPLATE_PORT.md).

First delivery slices:

- Inventory tracker document
- `HIGAdminTheme` + Showcase theme choice
- `HIGPanel` (primary admin surface) with tokens, tests, Showcase, DocC
- `HIGBreadcrumb` + `HIGPageHeader` wayfinding chrome
- `HIGPagination`, `HIGTabs`, `HIGAccordion` content navigation
- `HIGSteps` and `HIGPearlSteps` process indicators
- `HIGTimeline` activity timeline
- `HIGStatusIndicator`, avatar status overlay, and `HIGEmptyState`
- `HIGCloseButton` and `HIGModal` overlay chrome
- `higTooltip` / `HIGTooltipLabel` and `higPopover` / `HIGPopoverContainer`
- `HIGDrawer` / `higDrawer` slide panels
- `higConfirmationDialog` and `HIGNetworkProgressBar`
- `HIGButtonGroup` action clusters
- `HIGMenuToggle` hamburger control (Wave 2 overlay kit complete)
- `HIGInputGroup` and `HIGFieldMessage` (Wave 3 forms start)
- `HIGDatePicker` and `HIGTimePicker` (Wave 3.2 date/time)
- `HIGSelect` and `HIGAutocomplete` (Wave 3.3 select / typeahead)
- `HIGTagInput` (Wave 3.4 freeform tags; Wave 3 advanced forms complete)
- `HIGDataTable` / `HIGDataTableColumn` (Wave 4.1 data display start)

## Previous Milestone: v1.4.0 (released)

v1.4.0 is a minor release (2026-07-10) adding a 112-animation matrix loader catalog and multi-platform sample verification gates.

Delivered in v1.4.0:

- `HIGMatrixLoader` with 112 clean-room catalog animations (`HIGMatrixLoaderID`)
- `theme.matrixLoader` tokens, Showcase gallery, unit tests, DocC, and requirements
- Platform API guards and mandatory iOS + macOS sample verification scripts
- iOS sample fix for unguarded AppKit color APIs in Showcase snapshot chrome

Previous: v1.3.1 (released 2026-07-06) polished macOS showcase snapshots, README discoverability, and GitHub Pages imagery.

Delivered in v1.3.1:

- Re-captured macOS platform showcase snapshots with improved window chrome compositing
- README hero and gallery use macOS showcase renders
- GitHub Pages hero and gallery updated to macOS snapshot paths
- README discoverability polish (table of contents, star CTA, audience section)

v1.3.0 (2026-07-05) delivered:

- `HIGPhotoEditor` for crop, rotate, and aspect-ratio editing on iOS and macOS
- `HIGLongTextEditor` for rich HTML editing with formatting toolbar
- `HIGButtonStyle` with liquid glass on iOS 26+ and bordered fallback
- Pixel-matched showcase snapshot pipeline (iPhone device frames, macOS window chrome)
- PhotoPicker `ImageLoadingClient` replacing `PhotoKitCoordinator` actor
- Showcase welcome landing, A–Z catalog sort, and README iPhone hero snapshot

v1.2.1 (2026-06-27) delivered:

- Synchronous theme registration so `HIGThemeManager` and previews do not crash during view body builds
- Heroicon rendering fix for large fixed sizes via uniform view-box scaling
- Showcase Icon playground, per-sample API snippets, and token-backed showcase layouts
- `Scripts/verify_showcase_token_usage.sh` showcase design-token guard

v1.2.0 (2026-06-26) delivered:

- `HIGIcons` module with 324 Heroicons v2 outline and solid icons
- `HIGHeroIcon`, `HIGHeroIconToken`, and `HIGThemeManager` for token-based icon resolution
- `HIGDesignIcons` SPM product for icon-only consumers
- `HIGScaledDimension` and Dynamic Type scaling for `HIGIcon` and `HIGHeroIcon`
- `HIGIconSize.fixed(CGFloat)` and `HIGIconStyle.tint(Color)` for custom icon metrics and colors
- `Scripts/generate_hero_icons.py` to regenerate the icon catalog from Heroicons source

v1.1.0 (2026-06-20) delivered:

- `HIGActivityIndicatorStyle` with ten custom indicator styles plus the system default
- `higShimmer(isActive:mode:)` modifier with theme-backed `HIGShimmerTokens`
- PhotoPicker image loading migrated to `PhotoKitCoordinator` actor (no GCD)
- Picker chrome liquid glass buttons on iOS 26+ with bordered fallback
- `Scripts/verify_no_gcd.sh` and portable `grep`-based verification scripts

v1.0.1 (2026-06-19) delivered:

- Reliable headless showcase snapshot capture with correctly framed, non-blank PNGs
- Compact platform snapshot canvases for simple components
- PhotoPicker iOS build and `ViewBuilder` availability warning fixes
- Sample app `AccentColor` asset and warning-free iOS build

v1.0.0 (2026-06-19) delivered:

- 33 `HIG*` SwiftUI components with design-token enforcement across the catalog
- API stability policy and semantic versioning from v1.0.0
- Sample Xcode project and [HOW_TO_USE.md](HOW_TO_USE.md) consumer guide
- 385 committed showcase snapshots (theme + per-platform matrix)
- `HIGPhotoPicker` on iOS with sample privacy keys

Phase 12 (complete, v0.12.0) delivered:

- `HIGNavigationBar` and `HIGToolbar` as composable `View` components alongside existing modifiers
- API stability guide (pre-1.0 policy)
- showcase snapshot fidelity improvements with per-component labeling and no duplicate navigation chrome
- thirty-three-component `HIGShowcase` catalog (including `HIGPhotoPicker` on iOS)

This milestone does not include:

- Cocoa/UIKit bridging implementations beyond scaffolding
- remote third-party dependencies
- production brand theme packs beyond scaffolding

## Success Metrics

- Every public component maps to a HIG guideline section.
- Every module has BA requirements and tests.
- Package builds on all six platform destinations in CI.
- Showcase demonstrates light, dark, increased contrast, and Dynamic Type states.
- Consumers can import only the modules they need.

## Out of Scope

- Web, Android, or cross-platform UI toolkits
- Application business logic frameworks such as TCA
- Cloud sync, persistence, StoreKit, or analytics SDKs
- Brand-specific themes unless implemented as explicit `HIGTheme` conformances
- Remote runtime dependencies in the core package