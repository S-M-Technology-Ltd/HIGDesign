import HIGTokensComponent
import HIGTokensRaw
import Testing

@Test
func menuToggleTokensUseReadableMetrics() {
    let tokens = HIGSystemMenuToggleTokens()
    #expect(tokens.minTapTarget >= 44)
    #expect(tokens.lineWidth >= HIGSpacing.md.rawValue)
    #expect(tokens.lineThickness > 0)
    #expect(tokens.lineSpacing > 0)
}
