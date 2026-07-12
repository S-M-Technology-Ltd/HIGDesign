import HIGTokensComponent
import HIGTokensRaw
import Testing

@Test
func listGroupTokensUseReadableMetrics() {
    let tokens = HIGSystemListGroupTokens()
    #expect(tokens.rowMinHeight >= HIGSpacing.md.rawValue)
    #expect(tokens.horizontalPadding >= HIGSpacing.xs.rawValue)
    #expect(tokens.verticalPadding >= HIGSpacing.xxs.rawValue)
    #expect(tokens.iconSpacing >= HIGSpacing.xxs.rawValue)
    #expect(tokens.headerSpacing >= HIGSpacing.xxs.rawValue)
}
