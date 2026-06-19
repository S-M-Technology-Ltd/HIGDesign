#if os(iOS)
import CoreGraphics
import Foundation
import Photos

/// A lightweight, sendable reference to a photo library asset.
public struct HIGPhotoAsset: Identifiable, Sendable {
    public let id: String
    public let mediaType: PHAssetMediaType
    public let pixelWidth: Int
    public let pixelHeight: Int
    public let creationDate: Date?
    public let isLocallyAvailable: Bool

    public init(
        id: String,
        mediaType: PHAssetMediaType,
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

    public init(phAsset: PHAsset) {
        self.init(
            id: phAsset.localIdentifier,
            mediaType: phAsset.mediaType,
            pixelWidth: phAsset.pixelWidth,
            pixelHeight: phAsset.pixelHeight,
            creationDate: phAsset.creationDate,
            isLocallyAvailable: true
        )
    }

    /// Metadata dictionary compatible with the legacy UIKit picker.
    public var metadata: [String: Any] {
        [
            "mediaType": mediaType,
            "size": CGSize(width: pixelWidth, height: pixelHeight),
            "creationTimestamp": Int(creationDate?.timeIntervalSince1970 ?? 0),
        ]
    }
}

extension HIGPhotoAsset: Equatable, Hashable {
    public static func == (lhs: HIGPhotoAsset, rhs: HIGPhotoAsset) -> Bool {
        lhs.id == rhs.id
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

// MARK: - Image Export

public enum HIGPhotoImageLoadingError: Error, Equatable, Sendable {
    case assetNotFound
    case imageUnavailable
    case downloadFailed
    case cancelled
    case networkAccessDisabled
}

extension Collection where Element == HIGPhotoAsset {
    /// Loads full-size images for the selected assets using async/await.
    public func loadImages(
        configuration: HIGPhotoPickerConfiguration = .init(),
        progress: (@Sendable (Int, Int, Double) -> Void)? = nil
    ) async throws -> [HIGPhotoLoadedImage] {
        let client = ImageLoadingClient(configuration: configuration)
        var images: [HIGPhotoLoadedImage] = []
        let totalCount = count
        images.reserveCapacity(totalCount)

        for (index, asset) in enumerated() {
            try Task.checkCancellation()
            let cgImage = try await client.loadFullSizeImage(
                for: asset,
                progress: { value in
                    progress?(index, totalCount, value)
                }
            )
            images.append(HIGPhotoLoadedImage(cgImage: cgImage, metadata: asset.metadata))
        }

        return images
    }
}

extension Collection where Element == HIGPhotoAsset {
    /// Loads full-size images with legacy metadata wrappers.
    public func loadPhotoImages(
        configuration: HIGPhotoPickerConfiguration = .init(),
        progress: (@Sendable (Int, Int, Double) -> Void)? = nil
    ) async throws -> [HIGPhotoLoadedImage] {
        try await loadImages(configuration: configuration, progress: progress)
    }
}#endif
