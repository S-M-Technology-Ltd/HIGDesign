import HIGTokensComponent
import HIGTokensRaw
import Testing

@Test
func popoverTokensUseReadableMetrics() {
    let tokens = HIGSystemPopoverTokens()
    #expect(tokens.contentPadding >= HIGSpacing.sm.rawValue)
    #expect(tokens.maxWidth >= 240)
    #expect(tokens.borderWidth > 0)
    #expect(tokens.cornerRadius >= HIGRadius.sm.rawValue)
}
