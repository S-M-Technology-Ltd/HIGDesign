import HIGComponents
import HIGTokensComponent
import HIGTokensRaw
import Testing

@Test
func lightboxTokensUseReadableMetrics() {
    let tokens = HIGSystemLightboxTokens()
    #expect(tokens.minMediaHeight >= HIGSpacing.massive.rawValue)
    #expect(tokens.contentPadding >= HIGSpacing.xs.rawValue)
    #expect(tokens.controlSize >= HIGSpacing.massive.rawValue - 4)
    #expect(tokens.indicatorSize > 0)
    #expect(tokens.stackSpacing >= HIGSpacing.xxs.rawValue)
}
