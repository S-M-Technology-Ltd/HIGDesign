import CoreGraphics

/// Preview crop state returned when ``HIGInstagramPhotosPicker`` finishes.
public struct HIGInstagramPhotosPreviewCrop: Equatable, Sendable {
    public var offsetX: CGFloat
    public var offsetY: CGFloat
    public var scale: CGFloat
    public var previewSide: CGFloat

    public init(
        offsetX: CGFloat = 0,
        offsetY: CGFloat = 0,
        scale: CGFloat = 1,
        previewSide: CGFloat = 0
    ) {
        self.offsetX = offsetX
        self.offsetY = offsetY
        self.scale = scale
        self.previewSide = previewSide
    }
}