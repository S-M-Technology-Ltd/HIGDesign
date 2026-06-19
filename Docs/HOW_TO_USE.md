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
    .package(url: "https://github.com/S-M-Technology-Ltd/HIGDesign.git", from: "1.0.1"),
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
| `HIGDesign` | Full library — tokens, themes, components, modifiers |
| `HIGDesignCore` | Tokens and theme contract only |
| `HIGDesignComponents` | Components and modifiers without umbrella re-export |
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

Conform to `HIGTheme` or compose from `HIGSystemTheme` and override specific token protocols. Keep component token shapes stable so `HIG*` views continue to resolve spacing and typography predictably.

## Components

33 public `HIG*` SwiftUI components ship in v1.0.0. Each maps to an Apple HIG section and resolves styling from `theme.<component>`.

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
| Component gallery (GitHub Pages) | https://s-m-technology-ltd.github.io/HIGDesign/ |
| DocC catalog | Open `HIGDesign` in Xcode → **Product → Build Documentation** |
| Swift Package Index | https://swiftpackageindex.com/S-M-Technology-Ltd/HIGDesign |

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