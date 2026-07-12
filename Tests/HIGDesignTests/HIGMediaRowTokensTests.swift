import HIGTokensComponent
import HIGTokensRaw
import Testing

@Test
func mediaRowTokensUseReadableMetrics() {
    let tokens = HIGSystemMediaRowTokens()
    #expect(tokens.minHeight >= HIGSpacing.md.rawValue)
    #expect(tokens.spacing >= HIGSpacing.xs.rawValue)
    #expect(tokens.horizontalPadding >= HIGSpacing.xs.rawValue)
    #expect(tokens.verticalPadding >= HIGSpacing.xxs.rawValue)
}
