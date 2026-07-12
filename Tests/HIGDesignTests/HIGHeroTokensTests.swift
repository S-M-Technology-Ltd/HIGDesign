import HIGComponents
import HIGTokensComponent
import HIGTokensRaw
import Testing

@Test
func heroTokensUseReadableMetrics() {
    let tokens = HIGSystemHeroTokens()
    #expect(tokens.minHeight >= HIGSpacing.massive.rawValue)
    #expect(tokens.contentPadding >= HIGSpacing.md.rawValue)
    #expect(tokens.stackSpacing >= HIGSpacing.xs.rawValue)
    #expect(tokens.actionSpacing >= HIGSpacing.xxs.rawValue)
}

@Test
func heroStyleCasesAreStable() {
    #expect(HIGHeroStyle.allCases.count == 2)
    #expect(HIGHeroStyle.standard.rawValue == "standard")
    #expect(HIGHeroStyle.accent.rawValue == "accent")
}
