import HIGTokensComponent
import HIGTokensRaw
import Testing

@Test
func dataTableTokensUseReadableMetrics() {
    let tokens = HIGSystemDataTableTokens()
    #expect(tokens.minRowHeight >= HIGSpacing.md.rawValue)
    #expect(tokens.minColumnWidth >= HIGSpacing.xl.rawValue)
    #expect(tokens.horizontalPadding >= HIGSpacing.xs.rawValue)
    #expect(tokens.columnSpacing >= HIGSpacing.sm.rawValue)
}
