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

## Current Milestone: Phase 5 Content and Indicators

Phase 5 adds content and layout primitives, list/form components, and showcase snapshot publishing.

This milestone includes:

- `HIGLabel`, `HIGBadge`, `HIGActivityIndicator`, `HIGList`, and `HIGFormSection`
- badge and list token protocols on `HIGTheme`
- seventeen-component `HIGShowcase` catalog
- snapshot manifest workflow (`publish_showcase_snapshots.sh`, `verify_showcase_snapshots_present.sh`)

This milestone does not include:

- full component library delivery
- committed PNG snapshot artifacts in CI
- bridging implementations
- remote third-party dependencies
- custom brand themes beyond system defaults

## Next Milestone: Phase 6 Navigation and Feedback Expansion

The next milestone delivers:

- `HIGAlert` banner variant, `HIGToast` queueing, and `HIGSidebar` list styling
- `HIGNavigationBar` composable API
- automated PNG snapshot capture in CI

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