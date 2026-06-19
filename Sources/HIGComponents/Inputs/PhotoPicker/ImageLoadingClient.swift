#if os(iOS)
import CoreGraphics
import Foundation
import ImageIO
import Photos

public struct ImageLoadResult: Sendable {
    public let cgImage: CGImage
    public let isInCloud: Bool

    public init(cgImage: CGImage, isInCloud: Bool) {
        self.cgImage = cgImage
        self.isInCloud = isInCloud
    }
}

private struct PhotoKitCGImagePayload: @unchecked Sendable {
    let cgImage: CGImage
    let isInCloud: Bool
}

private struct ImageRequestStrategy {
    let deliveryMode: PHImageRequestOptionsDeliveryMode
    let resizeMode: PHImageRequestOptionsResizeMode
    let version: PHImageRequestOptionsVersion
}

/// Loads images from PhotoKit on a dedicated actor to avoid blocking the main actor.
public final class ImageLoadingClient: @unchecked Sendable {
    private let configuration: HIGPhotoPickerConfiguration
    private let coordinator: PhotoKitCoordinator
    private let isPreviewMode: Bool
    private let displayScale: CGFloat

    public init(
        configuration: HIGPhotoPickerConfiguration = .init(),
        imageManager: PHCachingImageManager = PHCachingImageManager(),
        isPreviewMode: Bool = false,
        displayScale: CGFloat? = nil
    ) {
        self.configuration = configuration
        self.isPreviewMode = isPreviewMode
        self.displayScale = displayScale ?? PhotoKitImageSizing.displayScale()
        self.coordinator = PhotoKitCoordinator(
            imageManager: imageManager,
            displayScale: self.displayScale
        )
    }

    #if DEBUG
    public static var preview: ImageLoadingClient {
        ImageLoadingClient(configuration: .init(), isPreviewMode: true)
    }
    #endif

    public func prepareAssets(ids: [String]) {
        guard !isPreviewMode else { return }

        Task { await coordinator.prepareAssets(ids: ids) }
    }

    public func ensurePrepared(assetID: String) async {
        guard !isPreviewMode else { return }
        _ = await coordinator.cachedAsset(for: assetID)
    }

    public func loadThumbnail(
        for asset: HIGPhotoAsset,
        targetSize: CGSize,
        allowsNetwork: Bool = false
    ) async throws -> ImageLoadResult {
        if isPreviewMode {
            return try previewThumbnail(for: asset)
        }

        guard let phAsset = await coordinator.cachedAsset(for: asset.id) else {
            throw HIGPhotoImageLoadingError.assetNotFound
        }
        guard phAsset.mediaType == .image else {
            throw HIGPhotoImageLoadingError.imageUnavailable
        }

        let pixelSize = PhotoKitImageSizing.pixelSize(for: targetSize, scale: displayScale)
        do {
            return try await requestCGImageWithFallbacks(
                key: "thumb-\(asset.id)",
                asset: phAsset,
                targetSize: pixelSize,
                allowsNetwork: allowsNetwork,
                strategies: Self.thumbnailStrategies,
                progress: nil
            )
        } catch {
            return try await requestThumbnailData(
                key: "thumb-\(asset.id)-data",
                asset: phAsset,
                maxPixelSize: Int(max(pixelSize.width, pixelSize.height)),
                allowsNetwork: allowsNetwork
            )
        }
    }

    public func loadDisplayImage(
        for asset: HIGPhotoAsset,
        targetSize: CGSize,
        allowsNetwork: Bool = false
    ) async throws -> ImageLoadResult {
        if isPreviewMode {
            return try previewThumbnail(for: asset)
        }

        guard let phAsset = await coordinator.cachedAsset(for: asset.id) else {
            throw HIGPhotoImageLoadingError.assetNotFound
        }
        guard phAsset.mediaType == .image else {
            throw HIGPhotoImageLoadingError.imageUnavailable
        }

        return try await loadPreviewImage(
            for: asset,
            targetSize: targetSize,
            allowsNetwork: allowsNetwork
        )
    }

    public func loadFullSizeImage(
        for asset: HIGPhotoAsset,
        progress: (@Sendable (Double) -> Void)? = nil
    ) async throws -> CGImage {
        if isPreviewMode {
            return try await previewFullSizeImage(for: asset, progress: progress)
        }

        guard let phAsset = await coordinator.cachedAsset(for: asset.id) else {
            throw HIGPhotoImageLoadingError.assetNotFound
        }
        guard phAsset.mediaType == .image else {
            throw HIGPhotoImageLoadingError.imageUnavailable
        }

        do {
            let payload = try await requestImageData(
                key: "full-\(asset.id)",
                asset: phAsset,
                deliveryMode: .highQualityFormat,
                allowsNetwork: configuration.iCloudNetworkAccessAllowed,
                progress: progress
            )

            if payload.isInCloud, !configuration.iCloudNetworkAccessAllowed {
                throw HIGPhotoImageLoadingError.networkAccessDisabled
            }

            if let cgImage = CGImageDecoding.decodeFullSize(from: payload.data) {
                return cgImage
            }
        } catch {
            if case HIGPhotoImageLoadingError.networkAccessDisabled = error {
                throw error
            }
        }

        let result = try await requestCGImageWithFallbacks(
            key: "full-\(asset.id)",
            asset: phAsset,
            targetSize: PhotoKitImageSizing.fullSizeTarget(for: phAsset),
            allowsNetwork: configuration.iCloudNetworkAccessAllowed,
            strategies: Self.fullSizeStrategies,
            progress: progress
        )

        if result.isInCloud, !configuration.iCloudNetworkAccessAllowed {
            throw HIGPhotoImageLoadingError.networkAccessDisabled
        }

        return result.cgImage
    }

    public func startCaching(assetIDs: [String], targetSize: CGSize) {
        guard !isPreviewMode else { return }

        let options = thumbnailOptions(allowsNetwork: false)
        Task { await coordinator.startCaching(assetIDs: assetIDs, targetSize: targetSize, options: options) }
    }

    public func stopCaching(assetIDs: [String], targetSize: CGSize) {
        guard !isPreviewMode else { return }

        let options = thumbnailOptions(allowsNetwork: false)
        Task { await coordinator.stopCaching(assetIDs: assetIDs, targetSize: targetSize, options: options) }
    }

    public func cancel(for key: String) {
        guard !isPreviewMode else { return }

        Task { await coordinator.cancel(matching: key) }
    }

    public func cancelAll() {
        guard !isPreviewMode else { return }

        Task { await coordinator.cancelAll() }
    }

    public func loadPreviewImage(
        for asset: HIGPhotoAsset,
        targetSize: CGSize,
        allowsNetwork: Bool = true
    ) async throws -> ImageLoadResult {
        if isPreviewMode {
            return try previewThumbnail(for: asset)
        }

        guard let phAsset = await coordinator.cachedAsset(for: asset.id) else {
            throw HIGPhotoImageLoadingError.assetNotFound
        }
        guard phAsset.mediaType == .image else {
            throw HIGPhotoImageLoadingError.imageUnavailable
        }

        let pixelSize = PhotoKitImageSizing.pixelSize(for: targetSize, scale: displayScale)

        do {
            return try await requestCGImageWithFallbacks(
                key: "preview-\(asset.id)",
                asset: phAsset,
                targetSize: pixelSize,
                allowsNetwork: allowsNetwork,
                strategies: Self.previewStrategies,
                progress: nil
            )
        } catch {
            return try await requestThumbnailData(
                key: "preview-\(asset.id)-data",
                asset: phAsset,
                maxPixelSize: Int(max(pixelSize.width, pixelSize.height)),
                allowsNetwork: allowsNetwork
            )
        }
    }

    private static let previewStrategies: [ImageRequestStrategy] = [
        ImageRequestStrategy(
            deliveryMode: .highQualityFormat,
            resizeMode: .fast,
            version: .current
        ),
        ImageRequestStrategy(
            deliveryMode: .opportunistic,
            resizeMode: .fast,
            version: .current
        ),
        ImageRequestStrategy(
            deliveryMode: .highQualityFormat,
            resizeMode: .fast,
            version: .unadjusted
        ),
    ]

    private static let thumbnailStrategies: [ImageRequestStrategy] = [
        ImageRequestStrategy(
            deliveryMode: .highQualityFormat,
            resizeMode: .fast,
            version: .current
        ),
        ImageRequestStrategy(
            deliveryMode: .opportunistic,
            resizeMode: .fast,
            version: .current
        ),
        ImageRequestStrategy(
            deliveryMode: .fastFormat,
            resizeMode: .fast,
            version: .unadjusted
        ),
    ]

    private static let fullSizeStrategies: [ImageRequestStrategy] = [
        ImageRequestStrategy(
            deliveryMode: .highQualityFormat,
            resizeMode: .fast,
            version: .current
        ),
        ImageRequestStrategy(
            deliveryMode: .opportunistic,
            resizeMode: .fast,
            version: .current
        ),
        ImageRequestStrategy(
            deliveryMode: .highQualityFormat,
            resizeMode: .fast,
            version: .unadjusted
        ),
    ]

    private func requestCGImageWithFallbacks(
        key: String,
        asset: PHAsset,
        targetSize: CGSize,
        allowsNetwork: Bool,
        strategies: [ImageRequestStrategy],
        progress: (@Sendable (Double) -> Void)?
    ) async throws -> ImageLoadResult {
        var lastError: Error = HIGPhotoImageLoadingError.imageUnavailable

        for (index, strategy) in strategies.enumerated() {
            do {
                let payload = try await requestCGImage(
                    key: "\(key)-\(index)",
                    asset: asset,
                    targetSize: targetSize,
                    strategy: strategy,
                    allowsNetwork: allowsNetwork,
                    progress: progress
                )
                return ImageLoadResult(
                    cgImage: payload.cgImage,
                    isInCloud: payload.isInCloud
                )
            } catch {
                lastError = error
                if case HIGPhotoImageLoadingError.cancelled = error {
                    throw error
                }

                if strategies.count == 1 || index == strategies.count - 1 {
                    break
                }
            }
        }

        throw lastError
    }

    private func requestThumbnailData(
        key: String,
        asset: PHAsset,
        maxPixelSize: Int,
        allowsNetwork: Bool
    ) async throws -> ImageLoadResult {
        let payload = try await requestImageData(
            key: key,
            asset: asset,
            deliveryMode: .fastFormat,
            allowsNetwork: allowsNetwork,
            progress: nil
        )

        guard let cgImage = CGImageDecoding.decodeThumbnail(from: payload.data, maxPixelSize: maxPixelSize) else {
            throw HIGPhotoImageLoadingError.imageUnavailable
        }

        return ImageLoadResult(
            cgImage: cgImage,
            isInCloud: payload.isInCloud
        )
    }

    private func requestCGImage(
        key: String,
        asset: PHAsset,
        targetSize: CGSize,
        strategy: ImageRequestStrategy,
        allowsNetwork: Bool,
        progress: (@Sendable (Double) -> Void)?
    ) async throws -> PhotoKitCGImagePayload {
        let payload = try await requestImageData(
            key: key,
            asset: asset,
            deliveryMode: strategy.deliveryMode,
            resizeMode: strategy.resizeMode,
            version: strategy.version,
            allowsNetwork: allowsNetwork,
            progress: progress
        )

        let maxPixelSize = Int(max(targetSize.width, targetSize.height))
        guard let cgImage = CGImageDecoding.decodeThumbnail(from: payload.data, maxPixelSize: maxPixelSize)
            ?? CGImageDecoding.decodeFullSize(from: payload.data)
        else {
            throw HIGPhotoImageLoadingError.imageUnavailable
        }

        return PhotoKitCGImagePayload(cgImage: cgImage, isInCloud: payload.isInCloud)
    }

    private func requestImageData(
        key: String,
        asset: PHAsset,
        deliveryMode: PHImageRequestOptionsDeliveryMode,
        resizeMode: PHImageRequestOptionsResizeMode = .none,
        version: PHImageRequestOptionsVersion = .current,
        allowsNetwork: Bool,
        progress: (@Sendable (Double) -> Void)?
    ) async throws -> PhotoKitDataPayload {
        try await coordinator.requestImageData(
            key: key,
            asset: asset,
            deliveryMode: deliveryMode,
            resizeMode: resizeMode,
            version: version,
            allowsNetwork: allowsNetwork,
            progress: progress
        )
    }

    private func thumbnailOptions(allowsNetwork: Bool) -> PHImageRequestOptions {
        let options = PHImageRequestOptions()
        options.deliveryMode = .fastFormat
        options.resizeMode = .fast
        options.version = .current
        options.isNetworkAccessAllowed = allowsNetwork
        return options
    }

    #if DEBUG
    private func previewThumbnail(for asset: HIGPhotoAsset) throws -> ImageLoadResult {
        let seed = PreviewColorSeed.value(for: asset.id)
        guard let cgImage = HIGPhotoPreviewData.placeholderCGImage(seed: seed, size: 300) else {
            throw HIGPhotoImageLoadingError.imageUnavailable
        }
        return ImageLoadResult(cgImage: cgImage, isInCloud: !asset.isLocallyAvailable)
    }

    private func previewFullSizeImage(
        for asset: HIGPhotoAsset,
        progress: (@Sendable (Double) -> Void)?
    ) async throws -> CGImage {
        progress?(0.5)
        try await Task.sleep(nanoseconds: 200_000_000)
        let seed = PreviewColorSeed.value(for: asset.id)
        guard let cgImage = HIGPhotoPreviewData.placeholderCGImage(seed: seed, size: 800) else {
            throw HIGPhotoImageLoadingError.imageUnavailable
        }
        progress?(1)
        return cgImage
    }
    #endif
}

#if DEBUG
private enum PreviewColorSeed {
    static func value(for string: String) -> Int {
        var hasher = Hasher()
        hasher.combine(string)
        return hasher.finalize()
    }
}
#endif
#endif