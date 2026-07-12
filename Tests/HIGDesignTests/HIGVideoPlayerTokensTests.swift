import HIGComponents
import HIGTokensComponent
import HIGTokensRaw
import Testing

@Test
func videoPlayerTokensUseReadableMetrics() {
    let tokens = HIGSystemVideoPlayerTokens()
    #expect(tokens.minHeight >= HIGSpacing.massive.rawValue * 2)
    #expect(tokens.contentPadding >= HIGSpacing.xxs.rawValue)
    #expect(tokens.cornerRadius >= 0)
    #expect(tokens.placeholderIconPointSize > 0)
}
