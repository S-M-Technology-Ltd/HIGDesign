import HIGComponents
import HIGTokensComponent
import HIGTokensRaw
import Testing

@Test
func lineChartTokensUseReadableMetrics() {
    let tokens = HIGSystemLineChartTokens()
    #expect(tokens.minHeight >= HIGSpacing.massive.rawValue)
    #expect(tokens.contentPadding >= HIGSpacing.xs.rawValue)
    #expect(tokens.lineWidth > 0)
    #expect(tokens.symbolSize > 0)
    #expect(tokens.stackSpacing >= HIGSpacing.xxs.rawValue)
}
