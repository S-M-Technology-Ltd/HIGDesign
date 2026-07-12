import HIGComponents
import HIGTokensComponent
import HIGTokensRaw
import Testing

@Test
func chatBubbleTokensUseReadableMetrics() {
    let tokens = HIGSystemChatBubbleTokens()
    #expect(tokens.contentPaddingHorizontal >= HIGSpacing.xxs.rawValue)
    #expect(tokens.contentPaddingVertical >= HIGSpacing.xxs.rawValue)
    #expect(tokens.stackSpacing >= HIGSpacing.xxs.rawValue)
    #expect(tokens.cornerRadius >= 0)
    #expect(tokens.sideGutter >= HIGSpacing.md.rawValue)
}
