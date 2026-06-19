/// Assets and preview crop state returned when ``HIGInstagramPhotosPicker`` finishes.
public struct HIGInstagramPhotosPickerFinishResult: Equatable, Sendable {
    public let assets: [HIGInstagramPhotosAsset]
    public let previewCrop: HIGInstagramPhotosPreviewCrop

    public init(
        assets: [HIGInstagramPhotosAsset],
        previewCrop: HIGInstagramPhotosPreviewCrop
    ) {
        self.assets = assets
        self.previewCrop = previewCrop
    }
}