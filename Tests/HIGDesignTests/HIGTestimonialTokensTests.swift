import HIGComponents
import HIGTokensComponent
import HIGTokensRaw
import Testing

@Test
func testimonialTokensUseReadableMetrics() {
    let tokens = HIGSystemTestimonialTokens()
    #expect(tokens.contentPadding >= HIGSpacing.xs.rawValue)
    #expect(tokens.stackSpacing >= HIGSpacing.xxs.rawValue)
    #expect(tokens.authorSpacing >= 0)
    #expect(tokens.cornerRadius >= 0)
}
