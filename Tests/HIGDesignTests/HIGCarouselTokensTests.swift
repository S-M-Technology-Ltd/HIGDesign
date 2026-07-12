import HIGTokensComponent
import HIGTokensRaw
import Testing

@Test
func carouselTokensUseReadableMetrics() {
    let tokens = HIGSystemCarouselTokens()
    #expect(tokens.minHeight >= HIGSpacing.massive.rawValue)
    #expect(tokens.indicatorSize >= HIGSpacing.xxs.rawValue)
    #expect(tokens.indicatorSpacing >= HIGSpacing.xxs.rawValue)
    #expect(tokens.contentPadding >= HIGSpacing.sm.rawValue)
}
