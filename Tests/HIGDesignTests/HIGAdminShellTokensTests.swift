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
    #expect(tokens.topBarMinHeight >= HIGSpacing.massive.rawValue)
    #expect(tokens.topBarIconPointSize > 0)
    #expect(tokens.topBarItemSpacing >= HIGSpacing.xxs.rawValue)
    #expect(tokens.centeredMaxWidth >= tokens.sidebarMaxWidth)
}

@Test
func adminShellStyleCasesAreStable() {
    #expect(HIGAdminShellStyle.allCases.count == 6)
    #expect(HIGAdminShellStyle.sidebar.rawValue == "sidebar")
    #expect(HIGAdminShellStyle.iconRail.rawValue == "iconRail")
    #expect(HIGAdminShellStyle.topBar.rawValue == "topBar")
    #expect(HIGAdminShellStyle.topIcon.rawValue == "topIcon")
    #expect(HIGAdminShellStyle.centered.rawValue == "centered")
    #expect(HIGAdminShellStyle.drawer.rawValue == "drawer")
}
