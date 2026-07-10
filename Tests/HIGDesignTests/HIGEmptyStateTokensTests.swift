import HIGTokensComponent
import HIGTokensRaw
import Testing

@Test
func emptyStateTokensUseReadableMetrics() {
    let tokens = HIGSystemEmptyStateTokens()
    #expect(tokens.iconPointSize >= HIGSpacing.xxl.rawValue)
    #expect(tokens.stackSpacing >= HIGSpacing.sm.rawValue)
    #expect(tokens.maxContentWidth >= 240)
}
