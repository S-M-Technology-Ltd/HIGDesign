# Custom Themes

HIGDesign themes are environment-driven values described by ``HIGTheme``. Use built-in themes for HIG defaults, then layer brand overrides when you need a white-label accent or typography change.

## Built-in themes

- ``HIGSystemTheme`` — default semantic colors and component tokens
- ``HIGHighContrastTheme`` — increased contrast destructive color and inherited system tokens
- ``HIGBrandTheme`` — system defaults with a custom accent color

## Apply a theme

Wrap screens in ``HIGThemeableView`` and pass any ``HIGTheme`` conformance:

```swift
HIGThemeableView(theme: HIGBrandTheme(name: "Acme", accent: .purple)) {
    ContentView()
}
```

## Author a custom theme

1. Start from ``HIGSystemTheme`` and override only the token groups you need.
2. Keep component token protocols (`HIGButtonTokens`, `HIGTagTokens`, `HIGActivityIndicatorTokens`, and so on) intact so components continue to resolve spacing and typography predictably.
3. Prefer semantic color overrides (`HIGSystemColorSemanticTokens`) over hard-coded view styling.
4. Register the theme through ``HIGThemeableView`` or `@Environment(\\.higThemeStorage)` in tests and previews.

For full control, declare a `struct` that conforms to ``HIGTheme`` and supply each token provider explicitly. Use ``HIGBrandTheme`` when only the accent color changes.