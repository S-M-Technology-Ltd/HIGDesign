import CoreGraphics
import HIGComponents
import Testing

@Test
func photoEditorConfigurationForcesSquareAspectForCircularStyle() {
    let configuration = HIGPhotoEditorConfiguration(
        croppingStyle: .circular,
        aspectRatio: .ratio16x9
    )

    #expect(configuration.effectiveAspectRatio == .square)
}

@Test
func photoEditorCropStateNormalizesAngle() {
    #expect(HIGPhotoEditorCropState.normalizedAngle(450) == 90)
    #expect(HIGPhotoEditorCropState.normalizedAngle(-90) == 270)
}

@Test
func photoEditorAspectRatioResolvesOriginalFromImageSize() {
    let landscape = HIGPhotoEditorAspectRatio.original.resolvedAspect(
        for: CGSize(width: 1600, height: 900),
        orientation: .landscape
    )
    let portrait = HIGPhotoEditorAspectRatio.original.resolvedAspect(
        for: CGSize(width: 900, height: 1600),
        orientation: .portrait
    )
    #expect(abs(landscape - (16.0 / 9.0)) < 0.001)
    #expect(abs(portrait - (9.0 / 16.0)) < 0.001)
}

@Test
func photoEditorAspectRatioFlipsPresetForPortraitOrientation() {
    let landscape = HIGPhotoEditorAspectRatio.ratio4x3.resolvedAspect(
        for: CGSize(width: 1200, height: 800),
        orientation: .landscape
    )
    let portrait = HIGPhotoEditorAspectRatio.ratio4x3.resolvedAspect(
        for: CGSize(width: 1200, height: 800),
        orientation: .portrait
    )

    #expect(abs(landscape - (4.0 / 3.0)) < 0.001)
    #expect(abs(portrait - (3.0 / 4.0)) < 0.001)
}

@Test
func photoEditorLandscapeAndPortraitPresetsUseExpectedAspects() {
    #expect(abs(HIGPhotoEditorAspectRatio.landscape.presetAspect! - (16.0 / 9.0)) < 0.001)
    #expect(abs(HIGPhotoEditorAspectRatio.portrait.presetAspect! - (9.0 / 16.0)) < 0.001)
}

@Test
func photoEditorFittedCropRegionHonorsAspectRatio() {
    let size = HIGPhotoEditorImageProcessor.fittedCropRegionSize(
        aspect: 1,
        availableSize: CGSize(width: 300, height: 500),
        horizontalInset: 16,
        verticalInset: 32,
        minimumSide: 120
    )

    #expect(abs(size.width - size.height) < 0.5)
    #expect(size.width <= 268)
    #expect(size.height <= 436)
}

@Test
func photoEditorImageCropRectProducesValidPixels() {
    let rect = HIGPhotoEditorImageProcessor.imageCropRect(
        imageWidth: 1200,
        imageHeight: 800,
        cropRegionWidth: 300,
        cropRegionHeight: 300,
        offsetX: 12,
        offsetY: -8,
        scale: 1.5
    )

    #expect(rect.width > 0)
    #expect(rect.height > 0)
    #expect(rect.minX >= 0)
    #expect(rect.minY >= 0)
    #expect(rect.maxX <= 1200)
    #expect(rect.maxY <= 800)
}

@Test
func photoEditorRendersCroppedImage() throws {
    let source = try #require(makeSolidTestImage(width: 200, height: 100))
    let cropState = HIGPhotoEditorCropState(
        scale: 1,
        cropRegionWidth: 100,
        cropRegionHeight: 100
    )

    let result = try #require(
        HIGPhotoEditorImageProcessor.renderResult(
            from: source,
            cropState: cropState,
            croppingStyle: .default,
            aspectRatio: .square,
            aspectRatioOrientation: .landscape
        )
    )

    #expect(result.croppedImage.width > 0)
    #expect(result.croppedImage.height > 0)
    #expect(result.angle == 0)
}

private func makeSolidTestImage(width: Int, height: Int) -> CGImage? {
    guard let context = CGContext(
        data: nil,
        width: width,
        height: height,
        bitsPerComponent: 8,
        bytesPerRow: 0,
        space: CGColorSpaceCreateDeviceRGB(),
        bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
    ) else {
        return nil
    }

    context.setFillColor(red: 0.2, green: 0.4, blue: 0.9, alpha: 1)
    context.fill(CGRect(x: 0, y: 0, width: width, height: height))
    return context.makeImage()
}