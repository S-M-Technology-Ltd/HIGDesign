# HIGDesign

**Ship Apple-native UI faster.** HIGDesign is a SwiftUI design system with 33 ready-made components, layered design tokens, and built-in themes — aligned with [Apple Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/) across every Apple platform.

<p align="center">
  <img src="Design/Showcase/snapshots/button-system-light.png" alt="HIGButton showcase" width="720">
</p>

<p align="center">
  <a href="https://github.com/S-M-Technology-Ltd/HIGDesign/releases"><img src="https://img.shields.io/github/v/release/S-M-Technology-Ltd/HIGDesign?label=version" alt="Release"></a>
  <a href="Package.swift"><img src="https://img.shields.io/badge/Swift-6-orange.svg" alt="Swift 6"></a>
  <a href="Package.swift"><img src="https://img.shields.io/badge/Platforms-iOS%20·%20iPadOS%20·%20macOS%20·%20visionOS%20·%20tvOS%20·%20watchOS-blue.svg" alt="Platforms"></a>
  <a href="Docs/HOW_TO_USE.md"><img src="https://img.shields.io/badge/SPM-compatible-brightgreen.svg" alt="SPM"></a>
  <a href="https://swiftpackageindex.com/S-M-Technology-Ltd/HIGDesign"><img src="https://img.shields.io/badge/Swift%20Package%20Index-ready-4B366A.svg" alt="Swift Package Index"></a>
  <a href="LICENSE"><img src="https://img.shields.io/badge/License-MIT-lightgrey.svg" alt="MIT"></a>
</p>

<p align="center">
  <a href="https://s-m-technology-ltd.github.io/HIGDesign/"><strong>Explore the component gallery →</strong></a>
  &nbsp;·&nbsp;
  <a href="Docs/HOW_TO_USE.md">Integration guide</a>
  &nbsp;·&nbsp;
  <a href="https://github.com/S-M-Technology-Ltd/HIGDesign/releases">Releases</a>
</p>

---

## Why teams pick HIGDesign

| | |
|---|---|
| **HIG-first, not generic** | Components map to Apple HIG patterns — buttons, forms, navigation, feedback — with platform-appropriate behavior baked in. |
| **Theme without rewiring** | Swap `HIGSystemTheme`, `HIGHighContrastTheme`, or `HIGBrandTheme` at the root. Every component reads `@Environment(\.higTheme)`. |
| **Tokens, not magic numbers** | Raw → semantic → component token layers keep spacing, color, motion, and borders consistent and testable. |
| **SwiftUI-only** | No UIKit. One package targets iOS 18+, macOS 15+, visionOS 2+, tvOS 18+, and watchOS 11+. |
| **See before you ship** | 385 committed showcase snapshots, a browsable gallery app, and a sample Xcode project you can run today. |

## Install in 60 seconds

**Xcode:** File → Add Package Dependencies →  
`https://github.com/S-M-Technology-Ltd/HIGDesign.git` (from `1.0.1`)

**Package.swift:**

```swift
dependencies: [
    .package(url: "https://github.com/S-M-Technology-Ltd/HIGDesign.git", from: "1.0.1"),
],
targets: [
    .target(name: "YourApp", dependencies: ["HIGDesign"]),
]
```

Wrap your app root once:

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

Full walkthrough: **[Docs/HOW_TO_USE.md](Docs/HOW_TO_USE.md)**

## What's in the box

**33 `HIG*` components** across six categories:

| Category | Examples |
|----------|----------|
| Actions | `HIGButton`, `HIGMenuButton` |
| Inputs | `HIGTextField`, `HIGSearchField`, `HIGPhotoPicker` (iOS) |
| Controls | `HIGToggle`, `HIGCheckbox`, `HIGSlider`, `HIGSegmentedControl` |
| Content | `HIGLabel`, `HIGBadge`, `HIGAvatar`, `HIGTag` |
| Layout & navigation | `HIGCard`, `HIGList`, `HIGTabBar`, `HIGSidebar`, `HIGNavigationBar` |
| Feedback | `HIGAlert`, `HIGToast`, `HIGProgressView` |

Browse every component with live theme and Dynamic Type controls:

```bash
open Sample/HIGDesignSample.xcodeproj   # iOS + macOS sample
swift run HIGShowcaseApp                # macOS showcase from CLI
```

**Online gallery:** [s-m-technology-ltd.github.io/HIGDesign](https://s-m-technology-ltd.github.io/HIGDesign/)

## Documentation

| Resource | Description |
|----------|-------------|
| [Component gallery (GitHub Pages)](https://s-m-technology-ltd.github.io/HIGDesign/) | Marketing site with snapshot previews |
| [HOW_TO_USE.md](Docs/HOW_TO_USE.md) | Integration, theming, and platform notes |
| [HIGDesign DocC](Sources/HIGDesign/HIGDesign.docc/) | API catalog — open in Xcode via **Product → Build Documentation** |
| [Swift Package Index](https://swiftpackageindex.com/S-M-Technology-Ltd/HIGDesign) | Package metadata, builds, and API browser |
| [CHANGELOG.md](CHANGELOG.md) | Release history |
| [ARCHITECTURE.md](Docs/ARCHITECTURE.md) | Module graph and token layers |

## Token architecture

```text
HIGTokensRaw → HIGTokensSemantic → HIGTokensComponent → HIGTheme → HIG* Views
```

Components never hardcode colors or spacing — they resolve values from `theme.<component>` tokens. Custom brand accents plug in through `HIGBrandTheme`.

## Try it locally

```bash
git clone https://github.com/S-M-Technology-Ltd/HIGDesign.git
cd HIGDesign
open Sample/HIGDesignSample.xcodeproj
```

| Scheme | Destination | What you get |
|--------|-------------|--------------|
| `HIGDesignSampleMac` | My Mac | Full 33-component catalog |
| `HIGDesignSample` | iPhone / iPad Simulator | Touch layouts + Photo Picker |

See [Sample/README.md](Sample/README.md) for signing and PhotoKit privacy keys.

## Contributing & quality

HIGDesign is built for production apps. Before opening a PR:

```bash
swift build --package-path .
swift test --package-path .
Scripts/verify_component_token_usage.sh
Scripts/verify_showcase_snapshot_diff.sh
```

Agent and architecture docs live under [Docs/](Docs/) and [AGENTS.md](AGENTS.md).

## License

MIT — see [LICENSE](LICENSE). Apple platform trademarks belong to Apple Inc.