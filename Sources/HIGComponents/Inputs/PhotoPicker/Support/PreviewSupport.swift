#if os(iOS)
#if DEBUG
import CoreGraphics
import HIGThemesContract
import Photos
import SwiftUI

enum HIGPhotoPreviewData {
    static let configuration = HIGPhotoPickerConfiguration(
        selectionLimit: 10,
        allowsMultipleSelection: true,
        showsSelectionModeToggle: true,
        iCloudNetworkAccessAllowed: true
    )

    static let assets: [HIGPhotoAsset] = (0..<16).map { index in
        HIGPhotoAsset(
            id: "preview-asset-\(index)",
            mediaType: .image,
            pixelWidth: 1200,
            pixelHeight: 1200,
            creationDate: Date().addingTimeInterval(TimeInterval(-index * 3600)),
            isLocallyAvailable: index % 4 != 0
        )
    }

    static let albums: [HIGPhotoAlbum] = [
        HIGPhotoAlbum(id: "preview-album-recents", name: "Recents", assetCount: 128),
        HIGPhotoAlbum(id: "preview-album-favorites", name: "Favorites", assetCount: 24),
        HIGPhotoAlbum(id: "preview-album-screenshots", name: "Screenshots", assetCount: 56),
    ]

    static var selectedAlbum: HIGPhotoAlbum { albums[0] }

    @MainActor
    static func makeSelection(selectedCount: Int = 2) -> HIGPhotoPickerSelection {
        let selection = HIGPhotoPickerSelection(configuration: configuration)
        for asset in assets.prefix(selectedCount) {
            selection.toggle(asset)
        }
        return selection
    }

    static func placeholderCGImage(seed: Int, size: Int = 400) -> CGImage? {
        let width = size
        let height = size
        guard let context = CGContext(
            data: nil,
            width: width,
            height: height,
            bitsPerComponent: 8,
            bytesPerRow: 0,
            space: CGColorSpaceCreateDeviceRGB(),
            bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
        ) else {
            return nil
        }

        let hue = CGFloat(UInt(bitPattern: seed) % 255) / 255.0
        let red = min(max(0.15 + hue * 0.5, 0), 1)
        let green = CGFloat(0.35)
        let blue = CGFloat(0.75)
        context.setFillColor(red: red, green: green, blue: blue, alpha: 1)
        context.fill(CGRect(x: 0, y: 0, width: width, height: height))

        context.setStrokeColor(gray: 1, alpha: 0.35)
        context.setLineWidth(4)
        context.stroke(CGRect(x: 8, y: 8, width: width - 16, height: height - 16))

        return context.makeImage()
    }
}

struct PickerPreviewState {
    var authorizationStatus: HIGPhotoAuthorizationStatus
    var albums: [HIGPhotoAlbum]
    var assets: [HIGPhotoAsset]
    var selectedAlbum: HIGPhotoAlbum?

    static let authorized = PickerPreviewState(
        authorizationStatus: .authorized,
        albums: HIGPhotoPreviewData.albums,
        assets: HIGPhotoPreviewData.assets,
        selectedAlbum: HIGPhotoPreviewData.selectedAlbum
    )

    static let limited = PickerPreviewState(
        authorizationStatus: .limited,
        albums: HIGPhotoPreviewData.albums,
        assets: HIGPhotoPreviewData.assets,
        selectedAlbum: HIGPhotoPreviewData.selectedAlbum
    )

    static let denied = PickerPreviewState(
        authorizationStatus: .denied,
        albums: [],
        assets: [],
        selectedAlbum: nil
    )

    static let notDetermined = PickerPreviewState(
        authorizationStatus: .notDetermined,
        albums: [],
        assets: [],
        selectedAlbum: nil
    )
}

struct PreviewPhotosLibraryClient: PhotosLibraryClientProtocol {
    func fetchAlbums(allowedMediaTypes: Set<PHAssetMediaType>) async -> [HIGPhotoAlbum] {
        HIGPhotoPreviewData.albums
    }

    func fetchAssets(
        in albumID: String,
        allowedMediaTypes: Set<PHAssetMediaType>
    ) async -> [HIGPhotoAsset] {
        HIGPhotoPreviewData.assets
    }

    func fetchAsset(localIdentifier: String) async -> HIGPhotoAsset? {
        HIGPhotoPreviewData.assets.first { $0.id == localIdentifier }
    }
}

@MainActor
enum HIGPhotoPreviewHostFactory {
    private static func previewHost<Content: View>(@ViewBuilder content: () -> Content) -> some View {
        HIGThemeableView(theme: HIGComponentPreviewTheme(), content: content)
    }

    static func photoGrid(selection: HIGPhotoPickerSelection) -> some View {
        previewHost {
            PhotoGridView(
            assets: HIGPhotoPreviewData.assets,
            configuration: HIGPhotoPreviewData.configuration,
            selection: selection,
            imageLoader: ImageLoadingClient.preview,
            onAssetFocused: { _ in }
            )
        }
    }

    static func albumList() -> some View {
        previewHost {
            NavigationStack {
            AlbumListView(
                albums: HIGPhotoPreviewData.albums,
                selectedAlbumID: HIGPhotoPreviewData.selectedAlbum.id,
                localization: HIGPhotoPreviewData.configuration.localizationProvider,
                imageLoader: ImageLoadingClient.preview,
                libraryClient: PreviewPhotosLibraryClient(),
                configuration: HIGPhotoPreviewData.configuration,
                onSelect: { _ in }
            )
            }
        }
    }

    static func photoPreview(asset: HIGPhotoAsset? = HIGPhotoPreviewData.assets.first) -> some View {
        previewHost {
            PhotoPreviewView(
            asset: asset,
            configuration: HIGPhotoPreviewData.configuration,
            imageLoader: ImageLoadingClient.preview,
            onPreviewCropChanged: { _ in }
            )
        }
    }

    static func pickerRoot(state: PickerPreviewState) -> some View {
        previewHost {
            PickerRootView(previewState: state)
        }
    }

    static func limitedAccessBanner(
        isExpanded: Bool = false,
        headerCollapseProgress: CGFloat = 0
    ) -> some View {
        previewHost {
            LimitedAccessBannerView(
            title: HIGPhotoPreviewData.configuration.localizationProvider.photosLimitedAccessTitle(),
            description: HIGPhotoPreviewData.configuration.localizationProvider.photosLimitedAccessModeText(),
            actionTitle: HIGPhotoPreviewData.configuration.localizationProvider.pickerAddingImageAccessButtonText(),
            isExpanded: isExpanded,
            headerCollapseProgress: headerCollapseProgress,
            onToggle: {},
            onManageAccess: {},
            onHeaderCollapseSwipe: { _ in }
            )
        }
    }
}
#endif
#endif
