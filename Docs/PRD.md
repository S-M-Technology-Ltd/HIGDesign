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

## Current Milestone: v1.0.1 (released)

v1.0.1 is a patch release (2026-06-19) fixing PhotoPicker build warnings, sample-app warnings, and showcase snapshot rendering.

Delivered in v1.0.1:

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