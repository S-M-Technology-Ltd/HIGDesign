import HIGThemesSystem
import Testing

@Test
func systemThemeUsesExpectedName() {
    let theme = HIGSystemTheme()
    #expect(theme.name == "System")
}