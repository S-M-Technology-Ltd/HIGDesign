import HIGComponents
import HIGTokensComponent
import HIGTokensRaw
import Testing

@Test
func counterTokensUseReadableMetrics() {
    let tokens = HIGSystemCounterTokens()
    #expect(tokens.contentPadding >= HIGSpacing.xs.rawValue)
    #expect(tokens.minHeight >= HIGSpacing.massive.rawValue)
    #expect(tokens.iconPointSize > 0)
    #expect(tokens.stackSpacing >= HIGSpacing.xxs.rawValue)
}

@Test
func counterTrendCasesAreStable() {
    #expect(HIGCounterTrend.allCases.count == 3)
    #expect(HIGCounterTrend.up.rawValue == "up")
    #expect(HIGCounterTrend.down.rawValue == "down")
    #expect(HIGCounterTrend.neutral.rawValue == "neutral")
}
