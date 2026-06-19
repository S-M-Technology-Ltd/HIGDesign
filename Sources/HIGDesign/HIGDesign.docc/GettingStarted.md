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

Run the `HIGShowcase` executable target in Xcode or from the command line on macOS:

```bash
swift run HIGShowcase
```

The showcase demonstrates light, dark, high-contrast, Dynamic Type, and Reduce Motion states for every shipped component.