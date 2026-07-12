import HIGComponents
import HIGTokensComponent
import HIGTokensRaw
import Testing

@Test
func ratingTokensUseReadableMetrics() {
    let tokens = HIGSystemRatingTokens()
    #expect(tokens.starPointSize > 0)
    #expect(tokens.starSpacing >= HIGSpacing.xxs.rawValue)
    #expect(tokens.minTapTarget >= HIGSpacing.massive.rawValue)
    #expect(tokens.labelSpacing >= HIGSpacing.xxs.rawValue)
}
