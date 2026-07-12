import HIGComponents
import HIGTokensComponent
import HIGTokensRaw
import Testing

@Test
func coachMarkTokensUseReadableMetrics() {
    let tokens = HIGSystemCoachMarkTokens()
    #expect(tokens.contentPadding >= HIGSpacing.sm.rawValue)
    #expect(tokens.stackSpacing >= HIGSpacing.xxs.rawValue)
    #expect(tokens.maxWidth >= HIGSpacing.massive.rawValue * 4)
    #expect(tokens.scrimOpacity > 0)
    #expect(tokens.scrimOpacity <= 1)
    #expect(tokens.cornerRadius >= 0)
}
