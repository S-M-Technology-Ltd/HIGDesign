import HIGComponents
import HIGTokensComponent
import HIGTokensRaw
import Testing

@Test
func barChartTokensUseReadableMetrics() {
    let tokens = HIGSystemBarChartTokens()
    #expect(tokens.minHeight >= HIGSpacing.massive.rawValue)
    #expect(tokens.contentPadding >= HIGSpacing.xs.rawValue)
    #expect(tokens.barCornerRadius >= 0)
    #expect(tokens.stackSpacing >= HIGSpacing.xxs.rawValue)
}

@Test
func chartPointIdentityDefaultsToLabel() {
    let point = HIGChartPoint(label: "Mon", value: 10)
    #expect(point.id == "Mon")
    #expect(point.value == 10)
}
