import HIGTokensComponent
import HIGTokensRaw
import Testing

@Test
func pearlStepsTokensUseReadableMetrics() {
    let tokens = HIGSystemPearlStepsTokens()
    #expect(tokens.pearlSize >= HIGSpacing.sm.rawValue)
    #expect(tokens.currentPearlSize >= tokens.pearlSize)
    #expect(tokens.minTapTarget >= 44)
    #expect(tokens.itemSpacing >= HIGSpacing.xs.rawValue)
}
