import HIGComponents
import HIGTokensComponent
import HIGTokensRaw
import Testing

@Test
func imageFrameTokensUseReadableMetrics() {
    let tokens = HIGSystemImageFrameTokens()
    #expect(tokens.cornerRadius >= 0)
    #expect(tokens.borderWidth > 0)
    #expect(tokens.minHeight >= HIGSpacing.massive.rawValue)
    #expect(tokens.placeholderIconPointSize > 0)
}

@Test
func imageFrameAspectRatiosArePositive() {
    #expect(HIGImageFrameAspect.square.ratio == 1)
    #expect(HIGImageFrameAspect.photo.ratio.map { abs($0 - 4.0 / 3.0) < 0.0001 } == true)
    #expect(HIGImageFrameAspect.portrait.ratio.map { abs($0 - 3.0 / 4.0) < 0.0001 } == true)
    #expect(HIGImageFrameAspect.widescreen.ratio.map { abs($0 - 16.0 / 9.0) < 0.0001 } == true)
    #expect(HIGImageFrameAspect.custom(0.8).ratio.map { abs($0 - 0.8) < 0.0001 } == true)
    #expect(HIGImageFrameAspect.custom(0).ratio == nil)
    #expect(HIGImageFrameAspect.flexible.ratio == nil)
}
