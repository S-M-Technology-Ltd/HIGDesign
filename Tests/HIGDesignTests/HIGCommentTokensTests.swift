import HIGComponents
import HIGTokensComponent
import HIGTokensRaw
import Testing

@Test
func commentTokensUseReadableMetrics() {
    let tokens = HIGSystemCommentTokens()
    #expect(tokens.contentPaddingVertical >= HIGSpacing.xxs.rawValue)
    #expect(tokens.stackSpacing >= 0)
    #expect(tokens.avatarSpacing >= HIGSpacing.xxs.rawValue)
    #expect(tokens.separatorWidth > 0)
}
