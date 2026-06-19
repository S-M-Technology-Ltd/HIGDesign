# API Stability

HIGDesign is pre-1.0. Phase milestones use `0.x.y` versions while the public component catalog matures.

## Current Policy (pre-1.0)

- **Minor (`0.x.0`)** — new components, tokens, themes, or additive APIs.
- **Patch (`0.x.y`)** — bug fixes, snapshot updates, and documentation corrections.
- Breaking changes are allowed between minor milestones when documented in release notes.

## Target v1.0.0 Policy

When v1.0.0 ships, semantic versioning will apply to:

- `HIGFoundations`, `HIGTokensRaw`, `HIGTokensSemantic`, `HIGTokensComponent`
- `HIGThemesContract`, `HIGThemesSystem`
- `HIGComponents`, `HIGModifiers`, `HIGPlatform`
- Umbrella `HIGDesign` and `HIGDesignCore` / `HIGDesignComponents` products

Planned rules at v1.0.0:

- **Major** — breaking public API or documented default-behavior changes.
- **Minor** — additive APIs with default-preserving parameters.
- **Patch** — fixes and non-breaking internal improvements.

## Component API Shape

Public components follow a consistent pattern:

1. A `public struct HIG*: View` that reads ``HIGTheme`` from the environment.
2. Optional companion enums for roles, styles, or sizes.
3. Modifier-based alternatives (`hig*`) where composition on existing views is the primary workflow.

Navigation components ship as both views and modifiers:

- ``HIGNavigationBar`` and ``higNavigationBar(_:displayMode:leading:trailing:)``
- ``HIGToolbar`` and ``higToolbar(_:)``

## Deprecation Process (from v1.0.0 onward)

1. Mark APIs `@available(*, deprecated, message:)` in the release that introduces the replacement.
2. Document the migration path in release notes and DocC.
3. Remove deprecated APIs in the next major version only after at least one minor release with the deprecation present.

## Optional Bridging

`HIGBridging` and `HIGDesignBridging` remain experimental. Their APIs may evolve more quickly until a dedicated bridging stability milestone is declared.