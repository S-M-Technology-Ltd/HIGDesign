# How to Use HIGDesign

HIGDesign is a SwiftUI-only design system for Apple platforms. This guide covers installation, theming, components, and verification for app developers consuming the public package.

## Requirements

| Platform | Minimum OS |
|----------|------------|
| iOS / iPadOS | 18 |
| macOS | 15 |
| visionOS | 2 |
| tvOS | 18 |
| watchOS | 11 |

Swift 6 toolchain. Xcode 16 or later recommended.

## Installation

Add HIGDesign to your `Package.swift` dependency list:

```swift
dependencies: [
    .package(url: "https://github.com/promptdora/HIGDesign.git", from: "1.3.1"),
],
targets: [
    .target(
        name: "YourApp",
        dependencies: [
            .product(name: "HIGDesign", package: "HIGDesign"),
        ]
    ),
]
```

### Product imports

| Product | Use when |
|---------|----------|
| `HIGDesign` | Full library — tokens, themes, components, modifiers, icons |
| `HIGDesignCore` | Tokens and theme contract only |
| `HIGDesignComponents` | Components and modifiers without umbrella re-export |
| `HIGDesignIcons` | Heroicons catalog, tokens, and `HIGHeroIcon` only |
| `HIGDesignPlatform` | Platform capability helpers |
| `HIGShowcase` | Building an internal component gallery (not required for apps) |

## Quick start

Wrap your app content in a theme container. Components read the active theme from the SwiftUI environment.

```swift
import HIGDesign
import SwiftUI

@main
struct MyApp: App {
    @State private var email = ""
    @State private var notificationsEnabled = true

    var body: some Scene {
        WindowGroup {
            HIGThemeableView(theme: HIGSystemTheme()) {
                VStack(spacing: HIGSpacing.lg.rawValue) {
                    HIGTextField("Email", text: $email, placeholder: "name@example.com")
                    HIGToggle("Notifications", isOn: $notificationsEnabled)
                    HIGButton("Continue", role: .primary) {
                        // action
                    }
                }
                .higPadding(.screenEdge)
            }
        }
    }
}
```

## Theming

### Built-in themes

| Theme | Purpose |
|-------|---------|
| `HIGSystemTheme()` | Default Apple HIG appearance |
| `HIGHighContrastTheme()` | Increased contrast emphasis |
| `HIGBrandTheme(name:accent:)` | Brand accent override on system defaults |

Switch themes by changing the value passed to `HIGThemeableView`:

```swift
HIGThemeableView(theme: HIGBrandTheme(name: "Acme", accent: .purple)) {
    ContentView()
}
```

### Design token layers

HIGDesign resolves all visual values through tokens — never hardcoded literals in component code.

```text
HIGTokensRaw        → spacing, radius, border, opacity, motion
HIGTokensSemantic   → colors, typography, spacing roles
HIGTokensComponent  → per-component metrics (button height, field padding, …)
HIGTheme            → active token bundle injected via environment
```

Read tokens in custom views:

```swift
@Environment(\.higTheme) private var theme

var body: some View {
    Text("Hello")
        .foregroundStyle(theme.colors.labelPrimary)
        .padding(theme.spacing.screenEdge)
}
```

### Custom themes

Create your own theme by conforming to `HIGTheme`. Thanks to protocol extension defaults, you only need to declare the properties you want to customize — everything else inherits system defaults.

**Minimal example — accent color only:**

```swift
import HIGDesign

struct MyTheme: HIGTheme {
    let name = "My Theme"
    let colors = HIGSystemColorSemanticTokens(accent: .purple)
}
```

**Full customisation — spacing, typography, and component tokens:**

```swift
struct ProTheme: HIGTheme {
    let name = "Pro"

    let colors = HIGSystemColorSemanticTokens(
        accent: .indigo,
        destructive: .orange
    )

    let typography = HIGSystemTypographySemanticTokens(
        headline: .title.weight(.bold),
        button: .headline
    )

    let spacing = HIGSystemSpacingSemanticTokens(
        screenEdge: 24,
        section: 32,
        item: 12
    )

    let button = HIGSystemButtonTokens(
        minHeight: 52,
        cornerRadius: 14
    )

    let card = HIGSystemCardTokens(
        cornerRadius: 20,
        contentPadding: 20
    )

    let textField = HIGSystemTextFieldTokens(
        cornerRadius: 12,
        borderWidth: 2
    )
}
```

**Override from a base theme:**

```swift
struct AdaptiveTheme: HIGTheme {
    let name = "Adaptive"
    let base = HIGSystemTheme()

    var colors: any HIGColorSemanticTokens {
        HIGSystemColorSemanticTokens(
            accent: .mint,
            backgroundPrimary: .white,
            backgroundSecondary: Color(.systemGray6)
        )
    }
    // all other properties inherit from protocol extension defaults
}
```

Switch to your custom theme the same way as any built-in:

```swift
HIGThemeableView(theme: MyTheme()) {
    ContentView()
}
```

**Token category overrides:**

Every token category supports independent overrides. Mix and match freely:

| Category | What you control |
|---|---|
| `colors` | `labelPrimary`, `labelSecondary`, `accent`, `destructive`, `warning`, backgrounds, fills, separators |
| `typography` | `largeTitle`, `title`, `headline`, `body`, `callout`, `caption`, `button` |
| `spacing` | `screenEdge`, `section`, `item`, `compactItem` |
| `opacity` | `hidden`, `disabled`, `pressedPrimary`, `subtleFill`, `bannerBorder`, `full` |
| `border` | `hairline` |
| `motion` | `quick`, `standard`, `emphasized` |
| `button` … `longTextEditor` | Per-component sizing, padding, radius, font, and style metrics |

The protocol extension in `HIGThemesContract` ensures every `HIGTheme` property has a system default, so you never need to declare properties you're not changing.

## Components

36 public `HIG*` SwiftUI components ship in the current mainline (including `HIGMatrixLoader` in 1.4.0). Each maps to an Apple HIG section and resolves styling from `theme.<component>`.

### Actions

```swift
HIGButton("Save", role: .primary) { }
HIGMenuButton("Options", systemImage: "ellipsis.circle") {
    Button("Rename") {}
    Button("Delete", role: .destructive) {}
}
```

### Inputs

```swift
HIGTextField("Name", text: $name, placeholder: "Full name")
HIGSecureField("Password", text: $password)
HIGSearchField("Search", text: $query)
HIGTextEditor("Notes", text: $notes)
HIGPicker("Sort", selection: $sort, options: SortOrder.allCases)
```

`HIGPhotoPicker` is iOS-only and requires host-app privacy keys:

```xml
<key>NSPhotoLibraryUsageDescription</key>
<string>Choose photos to attach.</string>
<key>PHPhotoLibraryPreventAutomaticLimitedAccessAlert</key>
<true/>
```

### Controls

```swift
HIGToggle("Wi-Fi", isOn: $wifiEnabled)
HIGCheckbox("Email updates", isOn: $emailUpdates)
HIGRadio("Daily", selection: $frequency, tag: .daily)
HIGSegmentedControl("Filter", selection: $filter, options: Filter.allCases)
HIGSlider("Volume", value: $volume, in: 0...100)
HIGStepper("Guests", value: $guestCount, in: 1...10)
```

### Navigation

```swift
HIGNavigationBar("Settings", trailing: { HIGButton("Edit", role: .borderless) {} })
HIGToolbar("Document") { HIGButton("Share", role: .secondary) {} }
HIGTabBar(selection: $tab, items: tabs)
HIGSidebar(selection: $section, items: sections)
```

Navigation components are also available as modifiers (`higNavigationBar`, `higToolbar`).

### Feedback

```swift
HIGProgressView("Uploading", value: 0.42)
HIGActivityIndicator("Loading")
HIGAlert("Delete item?", message: "This cannot be undone.", primaryButtonTitle: "Delete", primaryButtonRole: .destructive)
HIGAlertBanner("Sync complete", message: "Changes saved to iCloud.")
HIGToast("Settings saved")
```

Present toasts with view modifiers:

```swift
ContentView()
    .higToast(isPresented: $showsToast, message: "Saved")
```

### Icons

HIGDesign ships two icon components:

| Component | Source | Use when |
|-----------|--------|----------|
| `HIGIcon` | SF Symbols | System-native symbol names (`"bell.fill"`) |
| `HIGHeroIcon` | Heroicons v2 (24pt) | Tokenized outline/solid icons (`.bell`, `.academicCap`) |

Both read sizing and color from the active theme, scale with **Dynamic Type** by default, and support preset or custom sizes and tints.

#### SF Symbols

```swift
HIGIcon("bell", size: .medium, style: .primary)
HIGIcon("star.fill", size: .large, style: .accent)
HIGIcon("heart.fill", size: .fixed(32), style: .tint(.pink))
```

#### Heroicons

Resolve icons from the active theme or `HIGThemeManager`:

```swift
HIGHeroIcon(.academicCap, variant: .outline)
HIGHeroIcon(.academicCap, variant: .solid, style: .accent)
HIGHeroIcon(descriptor: HIGThemeManager.outlineIcon(from: .bell), size: .large)
HIGHeroIcon(.heart, variant: .solid, size: .fixed(28), style: .tint(.orange))
```

`HIGHeroIconToken` exposes all 324 Heroicons identifiers (for example `.academicCap`, `.bell`, `.heart`). Regenerate the catalog from a local Heroicons checkout:

```bash
python3 Scripts/generate_hero_icons.py
```

#### Size and tint options

| Parameter | Values | Default |
|-----------|--------|---------|
| `size` | `.small`, `.medium`, `.large`, `.fixed(CGFloat)` | `.medium` |
| `style` | `.primary`, `.secondary`, `.accent`, `.tint(Color)` | `.primary` |

Token sizes (16 / 20 / 28 pt) and `.fixed` values are **base** sizes — they still scale with the user's Dynamic Type setting.

## Browse the catalog locally

Open the sample Xcode project to interact with every component on device or simulator:

```bash
open Sample/HIGDesignSample.xcodeproj
```

| Scheme | Destination |
|--------|-------------|
| `HIGDesignSample` | iPhone / iPad Simulator |
| `HIGDesignSampleMac` | My Mac |

Or run the macOS showcase executable:

```bash
swift run HIGShowcaseApp
```

## Snapshot gallery

## Public documentation

| Resource | URL |
|----------|-----|
| Component gallery (GitHub Pages) | https://promptdora.github.io/HIGDesign/ |
| DocC catalog | Open `HIGDesign` in Xcode → **Product → Build Documentation** |
| Swift Package Index | https://swiftpackageindex.com/promptdora/HIGDesign |

Submit the package to SPI if it is not indexed yet:

```bash
Scripts/open_swift_package_index.sh
```

## Showcase snapshots

Committed PNG snapshots live under `Design/Showcase/snapshots/`:

- **Theme matrix** — `{component}-{theme}-{colorScheme}.png` (system, highContrast, brand × light, dark)
- **Platform matrix** — `platforms/{platform}/{component}-system-light.png` (per supported platform canvas)

Regenerate locally:

```bash
Scripts/capture_showcase_snapshots.sh
```

## Verification

```bash
Scripts/verify_component_token_usage.sh
swift build --package-path .
swift test --package-path .
Scripts/build_all_platforms.sh
```

## API stability

v1.0.0 follows semantic versioning for public modules. See [APIStability.md](../Sources/HIGDesign/HIGDesign.docc/APIStability.md) for deprecation policy.

## Further reading

- [Architecture](ARCHITECTURE.md)
- [UI guidelines](UI_DESIGN_GUIDELINES.md)
- [Sample app](../Sample/README.md)
- [Requirements index](../Requirements/README.md)