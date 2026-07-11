import HIGTokensComponent
import HIGTokensRaw
import Testing

@Test
func networkProgressBarTokensUseReadableMetrics() {
    let tokens = HIGSystemNetworkProgressBarTokens()
    #expect(tokens.height > 0)
    #expect(tokens.height <= HIGSpacing.sm.rawValue)
    #expect(tokens.indeterminateBandFraction > 0)
    #expect(tokens.indeterminateBandFraction < 1)
}
