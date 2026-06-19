import Foundation

/// A lightweight reference to a photo-library asset selected through ``HIGInstagramPhotosPicker``.
public struct HIGInstagramPhotosAsset: Identifiable, Sendable, Hashable, Equatable {
    public let id: String
    public let mediaType: HIGInstagramPhotosMediaType
    public let pixelWidth: Int
    public let pixelHeight: Int
    public let creationDate: Date?
    public let isLocallyAvailable: Bool

    public init(
        id: String,
        mediaType: HIGInstagramPhotosMediaType,
        pixelWidth: Int,
        pixelHeight: Int,
        creationDate: Date?,
        isLocallyAvailable: Bool
    ) {
        self.id = id
        self.mediaType = mediaType
        self.pixelWidth = pixelWidth
        self.pixelHeight = pixelHeight
        self.creationDate = creationDate
        self.isLocallyAvailable = isLocallyAvailable
    }
}