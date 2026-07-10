import HIGTokensComponent
import HIGTokensRaw
import Testing

@Test
func modalTokensUseReadableMetrics() {
    let tokens = HIGSystemModalTokens()
    #expect(tokens.contentPadding >= HIGSpacing.md.rawValue)
    #expect(tokens.cornerRadius >= HIGRadius.md.rawValue)
    #expect(tokens.maxWidth >= 320)
    #expect(tokens.borderWidth > 0)
}
