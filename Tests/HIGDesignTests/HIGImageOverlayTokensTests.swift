import HIGComponents
import HIGTokensComponent
import HIGTokensRaw
import Testing

@Test
func imageOverlayTokensUseReadableMetrics() {
    let tokens = HIGSystemImageOverlayTokens()
    #expect(tokens.panelPadding >= HIGSpacing.xxs.rawValue)
    #expect(tokens.minHeight >= HIGSpacing.massive.rawValue)
    #expect(tokens.cornerRadius >= 0)
    #expect(tokens.scrimOpacity > 0)
    #expect(tokens.scrimOpacity <= 1)
}
