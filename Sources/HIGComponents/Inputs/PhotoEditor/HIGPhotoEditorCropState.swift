#if os(iOS)
import CoreGraphics
import Foundation

/// Zoom, pan, rotation, and crop-region state for ``HIGPhotoEditor``.
public struct HIGPhotoEditorCropState: Equatable, Sendable {
    public var offsetX: CGFloat
    public var offsetY: CGFloat
    public var scale: CGFloat
    public var angle: Int
    public var cropRegionWidth: CGFloat
    public var cropRegionHeight: CGFloat

    public init(
        offsetX: CGFloat = 0,
        offsetY: CGFloat = 0,
        scale: CGFloat = 1,
        angle: Int = 0,
        cropRegionWidth: CGFloat = 0,
        cropRegionHeight: CGFloat = 0
    ) {
        self.offsetX = offsetX
        self.offsetY = offsetY
        self.scale = Self.clampedScale(scale)
        self.angle = Self.normalizedAngle(angle)
        self.cropRegionWidth = cropRegionWidth
        self.cropRegionHeight = cropRegionHeight
    }

    public static let identity = HIGPhotoEditorCropState()

    public static let minimumScale: CGFloat = 1

    public static func clampedScale(_ scale: CGFloat, maximum: CGFloat = 4) -> CGFloat {
        min(max(scale, minimumScale), maximum)
    }

    public static func normalizedAngle(_ angle: Int) -> Int {
        let remainder = angle % 360
        return remainder < 0 ? remainder + 360 : remainder
    }

    public var cropRegionSize: CGSize {
        CGSize(width: cropRegionWidth, height: cropRegionHeight)
    }
}
#endif