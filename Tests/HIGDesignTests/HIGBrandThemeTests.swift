import HIGThemesSystem
import SwiftUI
import Testing

@Test
func brandThemeOverridesAccentColor() {
    let theme = HIGBrandTheme(name: "Acme", accent: .purple)
    #expect(theme.name == "Acme")
    #expect(theme.colors.accent == .purple)
}

@Test
func brandThemeInheritsSystemButtonTokens() {
    let base = HIGSystemTheme()
    let theme = HIGBrandTheme(name: "Acme", accent: .purple, base: base)
    #expect(theme.button.minHeight == base.button.minHeight)
}