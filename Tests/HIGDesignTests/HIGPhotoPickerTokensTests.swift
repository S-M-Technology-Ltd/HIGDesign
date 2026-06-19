import HIGTokensComponent
import Testing

@Test
func photoPickerTokensDefineGridAndBannerMetrics() {
    let tokens = HIGSystemPhotoPickerTokens()

    #expect(tokens.gridColumnCount == 3)
    #expect(tokens.gridSpacing > 0)
    #expect(tokens.selectionBadgeSize > 0)
    #expect(tokens.limitedBannerToggleHeight >= 40)
    #expect(tokens.headerGrabberHeight > 0)
    #expect(tokens.previewMaximumZoomScale >= 1)
    #expect(tokens.compositionGridLineOpacity > 0)
    #expect(tokens.compositionGridLineOpacity < 1)
}