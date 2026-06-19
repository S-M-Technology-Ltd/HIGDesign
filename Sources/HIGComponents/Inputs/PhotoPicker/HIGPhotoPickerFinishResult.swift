#if os(iOS)
import Foundation

/// Assets and preview crop state returned when the picker finishes.
public struct HIGPhotoPickerFinishResult: Equatable, Sendable {
    public let assets: [HIGPhotoAsset]
    public let previewCrop: HIGPhotoPreviewCrop

    public init(
        assets: [HIGPhotoAsset],
        previewCrop: HIGPhotoPreviewCrop
    ) {
        self.assets = assets
        self.previewCrop = previewCrop
    }
}#endif
