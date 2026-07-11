import HIGTokensComponent
import HIGTokensRaw
import Testing

@Test
func selectTokensUseReadableMetrics() {
    let tokens = HIGSystemSelectTokens()
    #expect(tokens.minHeight >= HIGSpacing.md.rawValue)
    #expect(tokens.suggestionRowMinHeight >= HIGSpacing.md.rawValue)
    #expect(tokens.maxSuggestionHeight >= tokens.suggestionRowMinHeight)
    #expect(tokens.horizontalPadding >= HIGSpacing.xs.rawValue)
    #expect(tokens.chipSpacing >= HIGSpacing.xxs.rawValue)
}
