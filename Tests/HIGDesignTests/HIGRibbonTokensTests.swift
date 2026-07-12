import HIGComponents
import HIGTokensComponent
import HIGTokensRaw
import Testing

@Test
func ribbonTokensUseReadableMetrics() {
    let tokens = HIGSystemRibbonTokens()
    #expect(tokens.horizontalPadding >= HIGSpacing.xxs.rawValue)
    #expect(tokens.verticalPadding >= 0)
    #expect(tokens.cornerRadius >= 0)
    #expect(tokens.edgeInset >= HIGSpacing.xxs.rawValue)
}
