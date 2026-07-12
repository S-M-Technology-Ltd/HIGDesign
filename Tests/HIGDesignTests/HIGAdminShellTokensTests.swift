import HIGComponents
import HIGTokensComponent
import HIGTokensRaw
import Testing

@Test
func adminShellTokensUseReadableMetrics() {
    let tokens = HIGSystemAdminShellTokens()
    #expect(tokens.contentPadding >= HIGSpacing.sm.rawValue)
    #expect(tokens.brandPadding >= HIGSpacing.xs.rawValue)
    #expect(tokens.sidebarMinWidth >= 160)
    #expect(tokens.sidebarIdealWidth >= tokens.sidebarMinWidth)
    #expect(tokens.sidebarMaxWidth >= tokens.sidebarIdealWidth)
    #expect(tokens.iconRailWidth >= HIGSpacing.massive.rawValue)
    #expect(tokens.iconRailIconPointSize > 0)
    #expect(tokens.iconRailItemSpacing >= HIGSpacing.xxs.rawValue)
}

@Test
func adminShellStyleCasesAreStable() {
    #expect(HIGAdminShellStyle.allCases.count == 2)
    #expect(HIGAdminShellStyle.sidebar.rawValue == "sidebar")
    #expect(HIGAdminShellStyle.iconRail.rawValue == "iconRail")
}
