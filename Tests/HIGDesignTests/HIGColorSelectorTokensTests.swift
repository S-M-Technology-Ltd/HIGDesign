import HIGComponents
import HIGTokensComponent
import HIGTokensRaw
import Testing

@Test
func colorSelectorTokensUseReadableMetrics() {
    let tokens = HIGSystemColorSelectorTokens()
    #expect(tokens.swatchSize >= HIGSpacing.md.rawValue)
    #expect(tokens.swatchSpacing >= HIGSpacing.xxs.rawValue)
    #expect(tokens.minTapTarget >= HIGSpacing.massive.rawValue)
    #expect(tokens.selectionRingWidth > 0)
    #expect(tokens.checkmarkPointSize > 0)
}
