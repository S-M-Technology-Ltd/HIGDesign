#if os(iOS)
import CoreGraphics
import Foundation
import Photos

struct PhotoKitDataPayload: Sendable {
    let data: Data
    let isInCloud: Bool
}

actor PhotoKitCoordinator {
    let imageManager: PHCachingImageManager
    let displayScale: CGFloat
    private var activeRequests: [String: PHImageRequestID] = [:]
    private var assetCache: [String: PHAsset] = [:]

    init(imageManager: PHCachingImageManager, displayScale: CGFloat) {
        self.imageManager = imageManager
        self.displayScale = displayScale
    }

    func cachedAsset(for id: String) -> PHAsset? {
        if let cached = assetCache[id] {
            return cached
        }

        let asset = PHAsset.fetchAssets(withLocalIdentifiers: [id], options: nil).firstObject
        if let asset {
            assetCache[id] = asset
        }
        return asset
    }

    func prepareAssets(ids: [String]) {
        for id in ids {
            _ = cachedAsset(for: id)
        }
    }

    func startCaching(assetIDs: [String], targetSize: CGSize, allowsNetwork: Bool) {
        let phAssets = assetIDs.compactMap { cachedAsset(for: $0) }
        guard !phAssets.isEmpty else { return }

        let options = thumbnailRequestOptions(allowsNetwork: allowsNetwork)
        let pixelSize = PhotoKitImageSizing.pixelSize(for: targetSize, scale: displayScale)
        imageManager.startCachingImages(
            for: phAssets,
            targetSize: pixelSize,
            contentMode: .aspectFill,
            options: options
        )
    }

    func stopCaching(assetIDs: [String], targetSize: CGSize, allowsNetwork: Bool) {
        let phAssets = assetIDs.compactMap { cachedAsset(for: $0) }
        guard !phAssets.isEmpty else { return }

        let options = thumbnailRequestOptions(allowsNetwork: allowsNetwork)
        let pixelSize = PhotoKitImageSizing.pixelSize(for: targetSize, scale: displayScale)
        imageManager.stopCachingImages(
            for: phAssets,
            targetSize: pixelSize,
            contentMode: .aspectFill,
            options: options
        )
    }

    func cancel(for key: String) {
        cancelRequest(for: key)
    }

    func cancel(matching keyPrefix: String) {
        let keys = activeRequests.keys.filter { $0 == keyPrefix || $0.hasPrefix("\(keyPrefix)-") }
        for key in keys {
            cancelRequest(for: key)
        }
    }

    func cancelAll() {
        let requestIDs = Array(activeRequests.values)
        activeRequests.removeAll()
        for requestID in requestIDs {
            imageManager.cancelImageRequest(requestID)
        }
    }

    func requestImageData(
        key: String,
        asset: PHAsset,
        deliveryMode: PHImageRequestOptionsDeliveryMode,
        resizeMode: PHImageRequestOptionsResizeMode,
        version: PHImageRequestOptionsVersion,
        allowsNetwork: Bool,
        progress: (@Sendable (Double) -> Void)?
    ) async throws -> PhotoKitDataPayload {
        try Task.checkCancellation()

        return try await withTaskCancellationHandler {
            try await withCheckedThrowingContinuation { continuation in
                let guardState = ContinuationGuard()

                Task {
                    await self.beginImageDataRequest(
                        key: key,
                        asset: asset,
                        deliveryMode: deliveryMode,
                        resizeMode: resizeMode,
                        version: version,
                        allowsNetwork: allowsNetwork,
                        progress: progress,
                        continuation: continuation,
                        guardState: guardState
                    )
                }
            }
        } onCancel: {
            Task { await self.cancel(matching: key) }
        }
    }

    private func beginImageDataRequest(
        key: String,
        asset: PHAsset,
        deliveryMode: PHImageRequestOptionsDeliveryMode,
        resizeMode: PHImageRequestOptionsResizeMode,
        version: PHImageRequestOptionsVersion,
        allowsNetwork: Bool,
        progress: (@Sendable (Double) -> Void)?,
        continuation: CheckedContinuation<PhotoKitDataPayload, any Error>,
        guardState: ContinuationGuard
    ) {
        cancelRequest(for: key)

        let options = PHImageRequestOptions()
        options.deliveryMode = deliveryMode
        options.resizeMode = resizeMode
        options.version = version
        options.isNetworkAccessAllowed = allowsNetwork
        options.isSynchronous = false

        if allowsNetwork, let progress {
            options.progressHandler = { value, _, _, _ in
                progress(value)
            }
        }

        let requestID = imageManager.requestImageDataAndOrientation(
            for: asset,
            options: options
        ) { data, _, _, info in
            Task {
                await self.finishImageDataRequest(
                    key: key,
                    data: data,
                    info: info,
                    continuation: continuation,
                    guardState: guardState
                )
            }
        }

        storeRequest(key: key, id: requestID)
    }

    private func finishImageDataRequest(
        key: String,
        data: Data?,
        info: [AnyHashable: Any]?,
        continuation: CheckedContinuation<PhotoKitDataPayload, any Error>,
        guardState: ContinuationGuard
    ) {
        storeRequest(key: key, id: nil)

        let cancelled = (info?[PHImageCancelledKey] as? Bool) == true
        let imageError = info?[PHImageErrorKey] as? Error
        let isInCloud = PHAssetCloudStatus.isInCloud(info: info)

        if cancelled {
            guardState.resumeOnce(continuation, throwing: HIGPhotoImageLoadingError.cancelled)
            return
        }

        if let imageError {
            guardState.resumeOnce(continuation, throwing: imageError)
            return
        }

        guard let data else {
            guardState.resumeOnce(continuation, throwing: HIGPhotoImageLoadingError.imageUnavailable)
            return
        }

        guardState.resumeOnce(
            continuation,
            returning: PhotoKitDataPayload(data: data, isInCloud: isInCloud)
        )
    }

    private func thumbnailRequestOptions(allowsNetwork: Bool) -> PHImageRequestOptions {
        let options = PHImageRequestOptions()
        options.deliveryMode = .fastFormat
        options.resizeMode = .fast
        options.version = .current
        options.isNetworkAccessAllowed = allowsNetwork
        return options
    }

    private func cancelRequest(for key: String) {
        guard let requestID = activeRequests.removeValue(forKey: key) else { return }
        imageManager.cancelImageRequest(requestID)
    }

    private func storeRequest(key: String, id: PHImageRequestID?) {
        if let id {
            activeRequests[key] = id
        } else {
            activeRequests.removeValue(forKey: key)
        }
    }
}
#endif