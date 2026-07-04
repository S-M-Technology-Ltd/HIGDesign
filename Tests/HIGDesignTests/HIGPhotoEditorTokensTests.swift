import HIGTokensComponent
import Testing

@Test
func photoEditorTokensExposeZoomAndInsetValues() {
    let tokens = HIGSystemPhotoEditorTokens()

    #expect(tokens.maximumZoomScale > 1)
    #expect(tokens.cropRegionHorizontalInset > 0)
    #expect(tokens.minimumCropRegionSide > 0)
}