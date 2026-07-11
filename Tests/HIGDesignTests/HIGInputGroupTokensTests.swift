import HIGTokensComponent
import HIGTokensRaw
import Testing

@Test
func inputGroupTokensUseReadableMetrics() {
    let tokens = HIGSystemInputGroupTokens()
    #expect(tokens.minHeight >= 44)
    #expect(tokens.horizontalPadding >= HIGSpacing.sm.rawValue)
    #expect(tokens.borderWidth > 0)
    #expect(tokens.adornmentSpacing >= HIGSpacing.xs.rawValue)
}
