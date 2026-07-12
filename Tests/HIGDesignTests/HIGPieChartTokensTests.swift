import HIGComponents
import HIGTokensComponent
import HIGTokensRaw
import Testing

@Test
func pieChartTokensUseReadableMetrics() {
    let tokens = HIGSystemPieChartTokens()
    #expect(tokens.minHeight >= HIGSpacing.massive.rawValue)
    #expect(tokens.contentPadding >= HIGSpacing.xs.rawValue)
    #expect(tokens.sectorInset >= 0)
    #expect(tokens.donutInnerRadiusRatio > 0)
    #expect(tokens.donutInnerRadiusRatio < 1)
    #expect(tokens.stackSpacing >= HIGSpacing.xxs.rawValue)
}

@Test
func pieChartStyleCasesAreStable() {
    #expect(HIGPieChartStyle.allCases.count == 2)
    #expect(HIGPieChartStyle.pie.rawValue == "pie")
    #expect(HIGPieChartStyle.donut.rawValue == "donut")
}
