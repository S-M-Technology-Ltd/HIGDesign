#if os(iOS)
import InstagramPhotos
import Photos
import SwiftUI

enum HIGInstagramPhotosMapping {
    static func higAsset(from asset: InstagramPhotosAsset) -> HIGInstagramPhotosAsset {
        HIGInstagramPhotosAsset(
            id: asset.id,
            mediaType: higMediaType(from: asset.mediaType),
            pixelWidth: asset.pixelWidth,
            pixelHeight: asset.pixelHeight,
            creationDate: asset.creationDate,
            isLocallyAvailable: asset.isLocallyAvailable
        )
    }

    static func instagramAsset(from asset: HIGInstagramPhotosAsset) -> InstagramPhotosAsset {
        InstagramPhotosAsset(
            id: asset.id,
            mediaType: instagramMediaType(from: asset.mediaType),
            pixelWidth: asset.pixelWidth,
            pixelHeight: asset.pixelHeight,
            creationDate: asset.creationDate,
            isLocallyAvailable: asset.isLocallyAvailable
        )
    }

    static func higFinishResult(from result: InstagramPhotosPickerFinishResult) -> HIGInstagramPhotosPickerFinishResult {
        HIGInstagramPhotosPickerFinishResult(
            assets: result.assets.map(higAsset(from:)),
            previewCrop: HIGInstagramPhotosPreviewCrop(
                offsetX: result.previewCrop.offsetX,
                offsetY: result.previewCrop.offsetY,
                scale: result.previewCrop.scale,
                previewSide: result.previewCrop.previewSide
            )
        )
    }

    static func higMediaType(from mediaType: PHAssetMediaType) -> HIGInstagramPhotosMediaType {
        switch mediaType {
        case .image:
            .image
        case .video:
            .video
        case .audio:
            .audio
        default:
            .image
        }
    }

    static func instagramMediaType(from mediaType: HIGInstagramPhotosMediaType) -> PHAssetMediaType {
        switch mediaType {
        case .image:
            .image
        case .video:
            .video
        case .audio:
            .audio
        }
    }
}

extension HIGInstagramPhotosPickerConfiguration {
    var instagramConfiguration: InstagramPhotosPickerConfiguration {
        InstagramPhotosPickerConfiguration(
            selectionLimit: selectionLimit,
            allowedMediaTypes: Set(allowedMediaTypes.map(HIGInstagramPhotosMapping.instagramMediaType)),
            allowsMultipleSelection: allowsMultipleSelection,
            showsSelectionModeToggle: showsSelectionModeToggle,
            thumbnailSize: thumbnailSize,
            preferredAlbumIdentifier: preferredAlbumIdentifier,
            iCloudNetworkAccessAllowed: iCloudNetworkAccessAllowed,
            showsProgress: showsProgress,
            automaticallyRequestsPhotoAccess: automaticallyRequestsPhotoAccess
        )
    }
}

struct InstagramPhotosPickerBridge: View {
    @Binding var selection: [HIGInstagramPhotosAsset]
    let configuration: InstagramPhotosPickerConfiguration
    let onCancel: () -> Void
    let onFinish: (HIGInstagramPhotosPickerFinishResult) -> Void

    var body: some View {
        InstagramPhotosPicker(
            selection: instagramSelection,
            configuration: configuration,
            onCancel: onCancel,
            onFinish: { result in
                onFinish(HIGInstagramPhotosMapping.higFinishResult(from: result))
            }
        )
    }

    private var instagramSelection: Binding<[InstagramPhotosAsset]> {
        Binding(
            get: { selection.map(HIGInstagramPhotosMapping.instagramAsset) },
            set: { selection = $0.map(HIGInstagramPhotosMapping.higAsset) }
        )
    }
}
#endif