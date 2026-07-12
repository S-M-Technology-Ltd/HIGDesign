import HIGComponents
import HIGTokensComponent
import HIGTokensRaw
import Testing

@Test
func pricingCardTokensUseReadableMetrics() {
    let tokens = HIGSystemPricingCardTokens()
    #expect(tokens.contentPadding >= HIGSpacing.sm.rawValue)
    #expect(tokens.stackSpacing >= HIGSpacing.xxs.rawValue)
    #expect(tokens.featureSpacing >= HIGSpacing.xxs.rawValue)
    #expect(tokens.cornerRadius >= 0)
    #expect(tokens.featuredBorderWidth >= tokens.borderWidth)
    #expect(tokens.featureIconPointSize > 0)
}
