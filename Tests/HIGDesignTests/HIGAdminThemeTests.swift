import HIGThemesSystem
import HIGTokensRaw
import Testing

@Test
func adminThemeUsesAdminNameByDefault() {
    let theme = HIGAdminTheme()
    #expect(theme.name == "Admin")
    #expect(theme.panel.contentPadding > 0)
}

@Test
func adminThemeSupportsHueSkins() {
    let purple = HIGAdminTheme(name: "Admin Purple", hue: .purple)
    #expect(purple.name == "Admin Purple")
    #expect(HIGAdminThemeHue.allCases.contains(.purple))
}

@Test
func adminThemeUsesDenserSpacingThanSystemDefaults() {
    let system = HIGSystemTheme()
    let admin = HIGAdminTheme()
    #expect(admin.spacing.screenEdge <= system.spacing.screenEdge)
    #expect(admin.spacing.item <= system.spacing.item)
    #expect(admin.panel.contentPadding == HIGSpacing.md.rawValue)
}

@Test
func adminThemeHueCasesCoverPrimarySkins() {
    #expect(HIGAdminThemeHue.allCases.count == 6)
}
