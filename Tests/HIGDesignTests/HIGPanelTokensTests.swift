import HIGTokensComponent
import HIGTokensRaw
import Testing

@Test
func panelTokensUseReadablePaddingAndTargets() {
    let tokens = HIGSystemPanelTokens()
    #expect(tokens.contentPadding >= HIGSpacing.md.rawValue)
    #expect(tokens.cornerRadius >= HIGRadius.md.rawValue)
    #expect(tokens.borderWidth > 0)
    #expect(tokens.minActionTarget >= 44)
    #expect(tokens.actionIconPointSize > 0)
    #expect(tokens.headerSpacing >= HIGSpacing.xs.rawValue)
}

@Test
func panelTokensAcceptCustomDensity() {
    let tokens = HIGSystemPanelTokens(
        cornerRadius: HIGRadius.sm.rawValue,
        contentPadding: HIGSpacing.sm.rawValue,
        headerSpacing: HIGSpacing.xxs.rawValue
    )
    #expect(tokens.cornerRadius == HIGRadius.sm.rawValue)
    #expect(tokens.contentPadding == HIGSpacing.sm.rawValue)
    #expect(tokens.headerSpacing == HIGSpacing.xxs.rawValue)
}
