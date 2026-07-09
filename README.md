# HIGDesign

<p align="center">
  <strong>The SwiftUI design system that actually follows Apple Human Interface Guidelines — on every Apple platform.</strong>
</p>

<p align="center">
  <a href="https://github.com/S-M-Technology-Ltd/HIGDesign/stargazers"><img src="https://img.shields.io/github/stars/S-M-Technology-Ltd/HIGDesign?style=social" alt="GitHub stars"></a>
  <a href="https://github.com/S-M-Technology-Ltd/HIGDesign/releases"><img src="https://img.shields.io/github/v/release/S-M-Technology-Ltd/HIGDesign?label=latest" alt="Release"></a>
  <a href="Package.swift"><img src="https://img.shields.io/badge/Swift-6.4-orange.svg" alt="Swift 6.4"></a>
  <a href="Package.swift"><img src="https://img.shields.io/badge/platforms-iOS%20%7C%20iPadOS%20%7C%20macOS%20%7C%20tvOS%20%7C%20visionOS%20%7C%20watchOS-blue.svg" alt="All Apple platforms"></a>
  <a href="LICENSE"><img src="https://img.shields.io/badge/license-MIT-lightgrey.svg" alt="MIT"></a>
  <a href="https://swiftpackageindex.com/S-M-Technology-Ltd/HIGDesign"><img src="https://img.shields.io/badge/SPI-HIGDesign-purple?logo=swift" alt="Swift Package Index"></a>
</p>

<p align="center">
  <a href="https://s-m-technology-ltd.github.io/HIGDesign/"><strong>Live component gallery</strong></a>
  ·
  <a href="Docs/HOW_TO_USE.md">Docs</a>
  ·
  <a href="https://github.com/S-M-Technology-Ltd/HIGDesign/releases">Releases</a>
  ·
  <a href="Docs/ARCHITECTURE.md">Architecture</a>
</p>

<p align="center">
  <img src="Design/Showcase/snapshots/button-system-light.png" alt="HIGButton — system theme" width="320">
  <img src="Design/Showcase/snapshots/button-brand-light.png" alt="HIGButton — brand theme" width="320">
  <img src="Design/Showcase/snapshots/button-highContrast-light.png" alt="HIGButton — high contrast" width="320">
</p>

---

## Why HIGDesign?

Building a design system for 6 Apple platforms is **weeks of work**. HIGDesign gives you:

- **36 production-ready SwiftUI components** — buttons, toggles, pickers, photo editors, sidebars, and more
- **Layered design tokens** (`Raw → Semantic → Component → Theme`) — zero hardcoded values
- **One-line theme switching** — change `HIGSystemTheme()` to `HIGBrandTheme()` and every component updates
- **Six-platform support** — iOS, iPadOS, macOS, tvOS, watchOS, and visionOS, all from a single codebase
- **Apple HIG compliance** — every spacing, radius, and color maps to documented Apple guidelines
- **384 showcase snapshots** — proof that every theme, platform, and color scheme renders correctly

```swift
// Before: raw SwiftUI — inconsistent, no theming
Button(action: {}) { Text("Save").padding(12).background(.blue) }

// After: HIGDesign — token-driven, theme-aware, HIG-correct
HIGButton("Save", role: .primary) {}
```

---

## Quick start

**1. Add the package** — Xcode → File → Add Package Dependencies:
```
https://github.com/S-M-Technology-Ltd/HIGDesign.git
```

**2. Wrap your app and start building:**

```swift
import HIGDesign

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            HIGThemeableView(theme: HIGSystemTheme()) {
                VStack(spacing: 16) {
                    HIGTextField("Email", text: $email)
                    HIGToggle("Notifications", isOn: $notifications)
                    HIGButton("Continue", role: .primary) { print("tapped") }
                }
                .higPadding(.screenEdge)
            }
        }
    }
}
```

Full guide → **[Docs/HOW_TO_USE.md](Docs/HOW_TO_USE.md)**

---

## Components

| | |
|---|---|
| **Actions** | `HIGButton` · `HIGMenuButton` · `HIGLink` |
| **Inputs** | `HIGTextField` · `HIGSecureField` · `HIGSearchField` · `HIGTextEditor` · `HIGLongTextEditor` · `HIGPhotoPicker` · `HIGPhotoEditor` · `HIGPicker` |
| **Controls** | `HIGToggle` · `HIGCheckbox` · `HIGRadio` · `HIGSegmentedControl` · `HIGSlider` · `HIGStepper` |
| **Content** | `HIGLabel` · `HIGBadge` · `HIGIcon` · `HIGAvatar` · `HIGTag` · `HIGBulletList` |
| **Layout** | `HIGDivider` · `HIGCard` · `HIGList` · `HIGForm` |
| **Navigation** | `HIGTabBar` · `HIGToolbar` · `HIGSidebar` · `HIGNavigationBar` |
| **Feedback** | `HIGProgressView` · `HIGActivityIndicator` · `HIGAlert` · `HIGToast` |
| **Icons** | `HIGHeroIcon` — 324 outline + solid icons from Heroicons v2 |

<p align="center">
  <img src="Design/Showcase/snapshots/icon-system-light.png" alt="324 Heroicons" width="280">
  <img src="Design/Showcase/snapshots/card-system-light.png" alt="Card" width="280">
  <img src="Design/Showcase/snapshots/toast-system-light.png" alt="Toast" width="280">
</p>
<p align="center">
  <img src="Design/Showcase/snapshots/tabBar-system-light.png" alt="Tab Bar" width="280">
  <img src="Design/Showcase/snapshots/navigationBar-system-light.png" alt="Nav Bar" width="280">
  <img src="Design/Showcase/snapshots/photoPicker-system-light.png" alt="Photo Picker" width="280">
</p>

---

## Themes

Three built-in themes, each with light and dark variants:

| Theme | Use case |
|---|---|
| `HIGSystemTheme()` | Prod apps — matches the platform's native look |
| `HIGHighContrastTheme()` | Accessibility — elevated contrast for WCAG compliance |
| `HIGBrandTheme(name:accent:)` | Brand identity — custom accent color across every component |

Switching takes one line:

```swift
HIGThemeableView(theme: HIGBrandTheme(name: "Acme", accent: .purple)) { ... }
```

---

## Features

| Feature | |
|---|---|
| **Layer** | |
| Layered token system | Raw → Semantic → Component · no magic numbers |
| Environment theming | `@Environment(\.higTheme)` on every view |
| Dynamic Type | Scales with system font size out of the box |
| Reduce Motion | Respects system accessibility settings |
| VoiceOver | All components include accessibility labels |
| **DX** | |
| Modular SPM | Import just what you need — `HIGDesign`, `HIGIcons`, or individual modules |
| Swift 6 strict | Full concurrency safety, `Sendable` tokens |
| DocC catalog | Open in Xcode → Product → Build Documentation |
| CI-verified | Token usage guards · 61 unit tests · six-platform builds |
| Zero dependencies | No third-party runtime dependencies |

---

## See it in action

Browse every component live → **[s-m-technology-ltd.github.io/HIGDesign](https://s-m-technology-ltd.github.io/HIGDesign/)**

Or run the interactive showcase locally:

```bash
git clone https://github.com/S-M-Technology-Ltd/HIGDesign.git
cd HIGDesign && open Sample/HIGDesignSample.xcodeproj
```

---

## Documentation

| Resource | Description |
|---|---|
| [Live gallery](https://s-m-technology-ltd.github.io/HIGDesign/) | Visual component browser |
| [HOW_TO_USE.md](Docs/HOW_TO_USE.md) | Integration & theming guide |
| [ARCHITECTURE.md](Docs/ARCHITECTURE.md) | Module graph for contributors |
| [CHANGELOG.md](CHANGELOG.md) | Release history |
| [Swift Package Index](https://swiftpackageindex.com/S-M-Technology-Ltd/HIGDesign) | Build status & API browser |
| [Requirements](Requirements/README.md) | Per-module requirements |

---

## Contributing

PRs are welcome — see [CONTRIBUTING](Docs/ARCHITECTURE.md). Before submitting:

```bash
Scripts/build_all_platforms.sh
swift test
Scripts/verify_sample_xcode_project.sh
```

---

## License

MIT — see [LICENSE](LICENSE). Apple platform trademarks belong to Apple Inc.

---

<p align="center">
  <sub>If HIGDesign saves you time,</sub>
  <br>
  <a href="https://github.com/S-M-Technology-Ltd/HIGDesign"><strong>⭐ star the repo</strong></a>
  <sub>— it helps other developers discover it.</sub>
</p>
