# API Stability

HIGDesign 1.0.0 marks the first stable public API for the core SwiftUI design system.

## Stable Surfaces

The following modules are covered by semantic versioning from v1.0.0 onward:

- `HIGFoundations`, `HIGTokensRaw`, `HIGTokensSemantic`, `HIGTokensComponent`
- `HIGThemesContract`, `HIGThemesSystem`
- `HIGComponents`, `HIGModifiers`, `HIGPlatform`
- Umbrella `HIGDesign` and `HIGDesignCore` / `HIGDesignComponents` products

## Versioning Policy

- **Major** — breaking changes to public types, initializer signatures, or default behavior documented in release notes.
- **Minor** — additive APIs such as new components, tokens, theme properties, or optional parameters with defaults.
- **Patch** — bug fixes, snapshot updates, documentation corrections, and non-breaking internal improvements.

## Component API Shape

Public components follow a consistent pattern:

1. A `public struct HIG*: View` that reads ``HIGTheme`` from the environment.
2. Optional companion enums for roles, styles, or sizes.
3. Modifier-based alternatives (`hig*`) where composition on existing views is the primary workflow.

Navigation components ship as both views and modifiers:

- ``HIGNavigationBar`` and ``higNavigationBar(_:displayMode:leading:trailing:)``
- ``HIGToolbar`` and ``higToolbar(_:)``

## Deprecation Process

1. Mark APIs `@available(*, deprecated, message:)` in the release that introduces the replacement.
2. Document the migration path in release notes and DocC.
3. Remove deprecated APIs in the next major version only after at least one minor release with the deprecation present.

## Pre-1.0 History

Versions 0.1.0 through 0.11.0 were iterative delivery milestones. Breaking changes were permitted between those minor milestones while the component catalog and theme contract matured.

## Optional Bridging

`HIGBridging` and `HIGDesignBridging` remain experimental. Their APIs may evolve more quickly until a dedicated bridging stability milestone is declared.