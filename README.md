# HIGDesign

**v1.0.1** — A SwiftUI design system that follows Apple Human Interface Guidelines across iOS, iPadOS, macOS, visionOS, tvOS, and watchOS.

[![Swift 6](https://img.shields.io/badge/Swift-6-orange.svg)](Package.swift)
[![Platforms](https://img.shields.io/badge/Platforms-iOS%20·%20iPadOS%20·%20macOS%20·%20visionOS%20·%20tvOS%20·%20watchOS-blue.svg)](Package.swift)
[![SPM](https://img.shields.io/badge/SPM-compatible-brightgreen.svg)](Docs/HOW_TO_USE.md)

HIGDesign gives you HIG-correct SwiftUI components, a layered design-token system, built-in themes, and platform adapters — without UIKit or third-party UI dependencies.

## What you get

- **33 `HIG*` components** — actions, inputs, controls, content, layout, navigation, and feedback
- **Design tokens** — raw → semantic → component layers; no hardcoded dimensions or colors in view code
- **Themes** — system, high-contrast, and brand accent variants via `HIGThemeableView`
- **Six Apple platforms** — one package, intentional per-platform behavior
- **Showcase app** — browse every component with theme and Dynamic Type controls
- **385 committed snapshots** — theme matrix (198) + per-platform renders (187)

## Quick start

```swift
import HIGDesign

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            HIGThemeableView(theme: HIGSystemTheme()) {
                HIGButton("Continue", role: .primary) { }
            }
        }
    }
}
```

Add the package in Xcode: **File → Add Package Dependencies** → `https://github.com/S-M-Technology-Ltd/HIGDesign.git` (from `1.0.1`).

Full integration guide: **[Docs/HOW_TO_USE.md](Docs/HOW_TO_USE.md)**

## Architecture

```text
HIGTokensRaw → HIGTokensSemantic → HIGTokensComponent → HIGTheme → HIG* Views
```

| Layer | Examples |
|-------|----------|
| Raw | `HIGSpacing`, `HIGRadius`, `HIGBorder`, `HIGOpacity`, `HIGMotion` |
| Semantic | `labelPrimary`, `accent`, `screenEdge`, `disabled` opacity |
| Component | `HIGButtonTokens`, `HIGTextFieldTokens`, `HIGPhotoPickerTokens` |
| Theme | `HIGSystemTheme`, `HIGHighContrastTheme`, `HIGBrandTheme` |

Components read `@Environment(\.higTheme)` and resolve every padding, color, border, and animation duration from tokens.

## Component catalog

Snapshots below use the **system** theme in **light** mode (macOS canvas). Each component also has dark, high-contrast, and brand variants under [`Design/Showcase/snapshots/`](Design/Showcase/snapshots/).

### Actions

| Component | Platforms | Preview |
|-----------|-----------|---------|
| Button | 6 platforms | ![Button](Design/Showcase/snapshots/button-system-light.png) |
| Menu Button | 6 platforms | ![Menu Button](Design/Showcase/snapshots/menuButton-system-light.png) |

### Inputs

| Component | Platforms | Preview |
|-----------|-----------|---------|
| Text Field | 6 platforms | ![Text Field](Design/Showcase/snapshots/textField-system-light.png) |
| Secure Field | 6 platforms | ![Secure Field](Design/Showcase/snapshots/secureField-system-light.png) |
| Search Field | 6 platforms | ![Search Field](Design/Showcase/snapshots/searchField-system-light.png) |
| Text Editor | 6 platforms | ![Text Editor](Design/Showcase/snapshots/textEditor-system-light.png) |
| Picker | 6 platforms | ![Picker](Design/Showcase/snapshots/picker-system-light.png) |
| Photo Picker | iOS | ![Photo Picker](Design/Showcase/snapshots/photoPicker-system-light.png) |

### Controls

| Component | Platforms | Preview |
|-----------|-----------|---------|
| Toggle | 6 platforms | ![Toggle](Design/Showcase/snapshots/toggle-system-light.png) |
| Checkbox | 6 platforms | ![Checkbox](Design/Showcase/snapshots/checkbox-system-light.png) |
| Radio | 6 platforms | ![Radio](Design/Showcase/snapshots/radio-system-light.png) |
| Segmented Control | iOS, iPadOS, macOS, visionOS, tvOS | ![Segmented Control](Design/Showcase/snapshots/segmentedControl-system-light.png) |
| Slider | iOS, iPadOS, macOS, visionOS | ![Slider](Design/Showcase/snapshots/slider-system-light.png) |
| Stepper | 6 platforms | ![Stepper](Design/Showcase/snapshots/stepper-system-light.png) |

### Content

| Component | Platforms | Preview |
|-----------|-----------|---------|
| Label | 6 platforms | ![Label](Design/Showcase/snapshots/label-system-light.png) |
| Badge | 6 platforms | ![Badge](Design/Showcase/snapshots/badge-system-light.png) |
| Icon | 6 platforms | ![Icon](Design/Showcase/snapshots/icon-system-light.png) |
| Avatar | 6 platforms | ![Avatar](Design/Showcase/snapshots/avatar-system-light.png) |
| Link | 6 platforms | ![Link](Design/Showcase/snapshots/link-system-light.png) |
| Tag | 6 platforms | ![Tag](Design/Showcase/snapshots/tag-system-light.png) |
| Bullet List | 6 platforms | ![Bullet List](Design/Showcase/snapshots/bulletList-system-light.png) |

### Layout

| Component | Platforms | Preview |
|-----------|-----------|---------|
| Divider | 6 platforms | ![Divider](Design/Showcase/snapshots/divider-system-light.png) |
| Card | 6 platforms | ![Card](Design/Showcase/snapshots/card-system-light.png) |
| List | 6 platforms | ![List](Design/Showcase/snapshots/list-system-light.png) |
| Form Section | 6 platforms | ![Form](Design/Showcase/snapshots/form-system-light.png) |

### Navigation

| Component | Platforms | Preview |
|-----------|-----------|---------|
| Tab Bar | iOS, iPadOS, macOS, visionOS, tvOS | ![Tab Bar](Design/Showcase/snapshots/tabBar-system-light.png) |
| Toolbar | 6 platforms | ![Toolbar](Design/Showcase/snapshots/toolbar-system-light.png) |
| Sidebar | iOS, iPadOS, macOS, visionOS | ![Sidebar](Design/Showcase/snapshots/sidebar-system-light.png) |
| Navigation Bar | 6 platforms | ![Navigation Bar](Design/Showcase/snapshots/navigationBar-system-light.png) |

### Feedback

| Component | Platforms | Preview |
|-----------|-----------|---------|
| Progress View | 6 platforms | ![Progress View](Design/Showcase/snapshots/progressView-system-light.png) |
| Activity Indicator | 6 platforms | ![Activity Indicator](Design/Showcase/snapshots/activityIndicator-system-light.png) |
| Alert | 6 platforms | ![Alert](Design/Showcase/snapshots/alert-system-light.png) |
| Toast | 6 platforms | ![Toast](Design/Showcase/snapshots/toast-system-light.png) |

## Platform snapshots

Each component is rendered on every platform it supports, using platform-appropriate canvas sizes:

| Platform | Canvas | Snapshot path |
|----------|--------|---------------|
| macOS | 900 × 620 | `snapshots/platforms/macos/` |
| iOS | 390 × 844 | `snapshots/platforms/ios/` |
| iPadOS | 820 × 1180 | `snapshots/platforms/ipados/` |
| visionOS | 900 × 620 | `snapshots/platforms/visionos/` |
| tvOS | 960 × 540 | `snapshots/platforms/tvos/` |
| watchOS | 198 × 242 | `snapshots/platforms/watchos/` |

Example — Button on iPhone canvas:

![Button on iOS](Design/Showcase/snapshots/platforms/ios/button-system-light.png)

Regenerate all 385 snapshots:

```bash
Scripts/capture_showcase_snapshots.sh
```

## Open in Xcode

```bash
open Sample/HIGDesignSample.xcodeproj
```

| Scheme | Run on | Catalog |
|--------|--------|---------|
| `HIGDesignSampleMac` | My Mac | 33 components, sidebar navigation |
| `HIGDesignSample` | iPhone / iPad Simulator | Same catalog, touch layouts |

See [Sample/README.md](Sample/README.md) for signing and PhotoKit privacy setup.

## Documentation

| Area | Location |
|------|----------|
| **How to use** | [Docs/HOW_TO_USE.md](Docs/HOW_TO_USE.md) |
| Product overview | [Docs/PRD.md](Docs/PRD.md) |
| Architecture | [Docs/ARCHITECTURE.md](Docs/ARCHITECTURE.md) |
| UI guidelines | [Docs/UI_DESIGN_GUIDELINES.md](Docs/UI_DESIGN_GUIDELINES.md) |
| HTML HIG reference | [Design/index.html](Design/index.html) |
| Requirements | [Requirements/](Requirements/README.md) |
| API stability | [APIStability.md](Sources/HIGDesign/HIGDesign.docc/APIStability.md) |
| Changelog | [CHANGELOG.md](CHANGELOG.md) |

## Verification

```bash
Scripts/verify_requirements_present.sh
Scripts/verify_component_token_usage.sh
Scripts/verify_showcase_snapshots_present.sh
swift build --package-path .
swift test --package-path .
Scripts/build_all_platforms.sh
```

## License

See repository license terms. HIGDesign follows Apple Human Interface Guidelines; Apple platform trademarks belong to Apple Inc.