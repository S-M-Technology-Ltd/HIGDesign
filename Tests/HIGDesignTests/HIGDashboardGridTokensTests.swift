import HIGComponents
import HIGTokensComponent
import HIGTokensRaw
import Testing

@Test
func dashboardGridTokensUseReadableMetrics() {
    let tokens = HIGSystemDashboardGridTokens()
    #expect(tokens.minColumnWidth >= HIGSpacing.massive.rawValue * 2)
    #expect(tokens.columnSpacing >= HIGSpacing.xxs.rawValue)
    #expect(tokens.rowSpacing >= HIGSpacing.xxs.rawValue)
    #expect(tokens.titleSpacing >= 0)
}
