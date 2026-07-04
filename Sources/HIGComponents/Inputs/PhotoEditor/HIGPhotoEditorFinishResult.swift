#if os(iOS)
import CoreGraphics
import Foundation

/// Cropped image and metadata returned when the editor finishes.
public struct HIGPhotoEditorFinishResult: Equatable, Sendable {
    public let croppedImage: CGImage
    public let cropRect: CGRect
    public let angle: Int
    public let croppingStyle: HIGPhotoEditorCroppingStyle
    public let aspectRatio: HIGPhotoEditorAspectRatio

    public init(
        croppedImage: CGImage,
        cropRect: CGRect,
        angle: Int,
        croppingStyle: HIGPhotoEditorCroppingStyle,
        aspectRatio: HIGPhotoEditorAspectRatio
    ) {
        self.croppedImage = croppedImage
        self.cropRect = cropRect
        self.angle = HIGPhotoEditorCropState.normalizedAngle(angle)
        self.croppingStyle = croppingStyle
        self.aspectRatio = aspectRatio
    }
}
#endif