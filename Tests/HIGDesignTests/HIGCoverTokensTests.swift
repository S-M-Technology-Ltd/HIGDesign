import HIGComponents
import HIGTokensComponent
import HIGTokensRaw
import Testing

@Test
func coverTokensUseReadableMetrics() {
    let tokens = HIGSystemCoverTokens()
    #expect(tokens.minHeight >= HIGSpacing.massive.rawValue)
    #expect(tokens.contentPadding >= HIGSpacing.sm.rawValue)
    #expect(tokens.stackSpacing >= HIGSpacing.xxs.rawValue)
    #expect(tokens.cornerRadius >= 0)
    #expect(tokens.scrimOpacity > 0)
    #expect(tokens.scrimOpacity <= 1)
}
