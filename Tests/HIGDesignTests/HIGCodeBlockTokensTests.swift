import HIGTokensComponent
import HIGTokensRaw
import Testing

@Test
func codeBlockTokensUseReadableMetrics() {
    let tokens = HIGSystemCodeBlockTokens()
    #expect(tokens.minHeight >= HIGSpacing.md.rawValue)
    #expect(tokens.maxHeight >= tokens.minHeight)
    #expect(tokens.horizontalPadding >= HIGSpacing.xs.rawValue)
    #expect(tokens.headerSpacing >= HIGSpacing.xxs.rawValue)
}
