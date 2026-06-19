# Getting Started

Import the umbrella product and wrap your interface in a system theme.

```swift
import HIGDesign

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            HIGThemeableView(theme: HIGSystemTheme()) {
                VStack(spacing: 16) {
                    HIGTextField("Email", text: $email, placeholder: "name@example.com")
                    HIGToggle("Notifications", isOn: $notificationsEnabled)
                    HIGButton("Continue", role: .primary) { }
                }
                .higPadding(.screenEdge)
            }
        }
    }
}
```

## Showcase

Open `Sample/HIGDesignSample.xcodeproj` in Xcode, or run the `HIGShowcaseApp` executable from the command line on macOS:

```bash
swift run HIGShowcaseApp
```

The showcase demonstrates light, dark, high-contrast, Dynamic Type, and Reduce Motion states for every shipped component.