# HIGDesign Architecture

## Overview

HIGDesign is a modular Swift Package that delivers an Apple HIG-aligned design system for SwiftUI apps across six Apple platforms. The package is SwiftUI-only and does not use UIKit. Minimum OS releases cover the latest three calendar years (iOS 18, macOS 15, tvOS 18, watchOS 11, visionOS 2).

## Module Graph

```text
HIGFoundations
  → HIGTokensRaw
    → HIGTokensSemantic
      → HIGTokensComponent
        → HIGThemesContract
          → HIGThemesSystem
          → HIGPlatform
          → HIGBridging
            → HIGComponents
            → HIGModifiers
              → exported HIGDesign
```

## Responsibilities

| Module | Responsibility |
|--------|----------------|
| `HIGFoundations` | idioms, size classes, logging, accessibility helpers |
| `HIGTokensRaw` | system primitives and HIG measurements |
| `HIGTokensSemantic` | role-based token protocols |
| `HIGTokensComponent` | component-specific token protocols |
| `HIGThemesContract` | `HIGTheme`, `HIGThemeableView`, environment keys |
| `HIGThemesSystem` | built-in light, dark, high-contrast, and compact themes |
| `HIGPlatform` | capability detection and layout adapters |
| `HIGBridging` | optional Cocoa bridges |
| `HIGComponents` | public `HIG*` SwiftUI components |
| `HIGModifiers` | token-backed view modifiers |
| `HIGDesign` | umbrella export target |

## Design Decisions

### HIG-first visuals

All public styling resolves from HIG tokens and themes. Components do not hardcode brand colors or custom font families.

### Environment-driven theming

Apps inject themes with `HIGThemeableView`. Components read `@Environment(\.higTheme)`.

### Native SwiftUI first

All implementation is SwiftUI-native. UIKit imports and representables are prohibited. Optional bridging, if added later, must use SwiftUI-only patterns.

### Platform capability model

Shared platform checks live in `HIGPlatform` so components do not accumulate copy-pasted `#if os()` logic.

## Reference Inputs

- `../ouds-ios` — token layering and theme contract
- `../SwiftUIX` — platform abstraction and bridging patterns
- `../SwiftUI-Design-System-Pro` — token categories and modifier DSL ideas
- `../promptory-apple` — requirements and HIG review process

## Current State

Phase 7 controls and inputs expansion builds on the Phase 1–6 foundation, which compiles on all six platforms (macOS, iOS, tvOS, watchOS, visionOS).

| Module | Status |
|--------|--------|
| `HIGFoundations` | Implemented — idioms, size classes, logging, `HIGAccessibilityPreferences`, WCAG contrast |
| `HIGTokensRaw` | Implemented — spacing, radius, motion primitives |
| `HIGTokensSemantic` | Implemented — color, typography, spacing protocols; SwiftUI semantic platform colors |
| `HIGTokensComponent` | Implemented — button token protocol |
| `HIGThemesContract` | Implemented — `HIGTheme`, environment key, `HIGThemeableView` |
| `HIGThemesSystem` | Implemented — system and high-contrast themes |
| `HIGPlatform` | Implemented — `HIGPlatformCapabilities` |
| `HIGComponents` | Implemented — actions, inputs, controls, feedback, layout, and navigation components |
| `HIGModifiers` | Implemented — `higPadding`, `higToolbar`, `HIGToolbarTextAction` |
| `HIGShowcase` | Implemented — cross-platform component gallery executable |

| `HIGDesign` | Implemented — umbrella re-exports |
| `HIGBridging` | Implemented — optional SwiftUI layout helpers (`HIGConditionalView`, `HIGScrollableContainer`) |

Verification: `Scripts/build_all_platforms.sh`, `swift test`, and all governance guards (including `verify_no_uikit.sh`) pass locally.

Next phase: feedback and indicator expansion, removable tag flows, and custom `HIGTheme` authoring scaffolding.