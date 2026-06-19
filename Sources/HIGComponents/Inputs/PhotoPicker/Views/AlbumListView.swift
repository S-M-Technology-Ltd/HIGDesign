#if os(iOS)
import CoreGraphics
import HIGThemesContract
import SwiftUI

struct AlbumListView: View {
    let albums: [HIGPhotoAlbum]
    let selectedAlbumID: String?
    let localization: any HIGPhotoLocalizationProviding
    let imageLoader: ImageLoadingClient
    let libraryClient: any PhotosLibraryClientProtocol
    let configuration: HIGPhotoPickerConfiguration
    let onSelect: (HIGPhotoAlbum) -> Void

    @Environment(\.higTheme) private var theme

    private var tokens: any HIGPhotoPickerTokens { theme.photoPicker }

    var body: some View {
        Group {
            if albums.isEmpty {
                emptyState
            } else {
                albumList
            }
        }
        .background(tokens.chromeBackground)
        .navigationTitle(localization.albumNavigationTitle())
        .navigationBarTitleDisplayMode(.large)
        .toolbarBackground(.visible, for: .navigationBar)
    }

    private var albumList: some View {
        List {
            ForEach(albums) { album in
                AlbumListRowButtonView(
                    album: album,
                    isSelected: album.id == selectedAlbumID,
                    localization: localization,
                    configuration: configuration,
                    libraryClient: libraryClient,
                    imageLoader: imageLoader,
                    onSelect: onSelect
                )
            }
        }
        .listStyle(.insetGrouped)
        .scrollContentBackground(.hidden)
    }

    @ViewBuilder
    private var emptyState: some View {
        if #available(iOS 17.0, *) {
            ContentUnavailableView {
                Label {
                    Text(localization.albumEmptyTitle())
                } icon: {
                    Image(systemName: "photo.on.rectangle.angled")
                }
            } description: {
                Text(localization.albumEmptyMessage())
            }
        } else {
            VStack(spacing: tokens.albumListRowSpacing) {
                Image(systemName: "photo.on.rectangle.angled")
                    .font(.system(size: tokens.albumListEmptyIconSize, weight: .light))
                    .symbolRenderingMode(.hierarchical)
                    .foregroundStyle(theme.colors.labelSecondary)
                    .accessibilityHidden(true)

                Text(localization.albumEmptyTitle())
                    .font(.title3.weight(.semibold))

                Text(localization.albumEmptyMessage())
                    .font(.body)
                    .foregroundStyle(theme.colors.labelSecondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, tokens.albumListEmptyStatePadding)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }

}

private struct AlbumListRowButtonView: View {
    let album: HIGPhotoAlbum
    let isSelected: Bool
    let localization: any HIGPhotoLocalizationProviding
    let configuration: HIGPhotoPickerConfiguration
    let libraryClient: any PhotosLibraryClientProtocol
    let imageLoader: ImageLoadingClient
    let onSelect: (HIGPhotoAlbum) -> Void

    @Environment(\.higTheme) private var theme

    private var tokens: any HIGPhotoPickerTokens { theme.photoPicker }

    var body: some View {
        Button {
            onSelect(album)
        } label: {
            AlbumListRowView(
                album: album,
                isSelected: isSelected,
                localization: localization,
                configuration: configuration,
                libraryClient: libraryClient,
                imageLoader: imageLoader
            )
        }
        .buttonStyle(.plain)
        .listRowInsets(
            EdgeInsets(
                top: tokens.albumListRowInsetVertical,
                leading: tokens.albumListRowInsetHorizontal,
                bottom: tokens.albumListRowInsetVertical,
                trailing: tokens.albumListRowInsetHorizontal
            )
        )
        .accessibilityLabel("\(album.name), \(localization.albumPhotoCountText(album.assetCount))")
        .accessibilityAddTraits(isSelected ? .isSelected : AccessibilityTraits())
    }
}

private struct AlbumListRowView: View {
    let album: HIGPhotoAlbum
    let isSelected: Bool
    let localization: any HIGPhotoLocalizationProviding
    let configuration: HIGPhotoPickerConfiguration
    let libraryClient: any PhotosLibraryClientProtocol
    let imageLoader: ImageLoadingClient

    @Environment(\.higTheme) private var theme

    private var tokens: any HIGPhotoPickerTokens { theme.photoPicker }

    var body: some View {
        HStack(spacing: tokens.albumListRowSpacing) {
            AlbumThumbnailView(
                album: album,
                configuration: configuration,
                libraryClient: libraryClient,
                imageLoader: imageLoader
            )
            .frame(
                width: tokens.albumThumbnailSize,
                height: tokens.albumThumbnailSize
            )
            .clipShape(
                RoundedRectangle(
                    cornerRadius: tokens.albumThumbnailCornerRadius,
                    style: .continuous
                )
            )

            VStack(alignment: .leading, spacing: tokens.albumListSubtitleSpacing) {
                Text(album.name)
                    .font(.body)
                    .foregroundStyle(theme.colors.labelPrimary)
                    .lineLimit(1)

                Text(localization.albumPhotoCountText(album.assetCount))
                    .font(.subheadline)
                    .foregroundStyle(theme.colors.labelSecondary)
                    .monospacedDigit()
            }

            Spacer(minLength: 0)

            if isSelected {
                Image(systemName: "checkmark")
                    .font(.body.weight(.semibold))
                    .foregroundStyle(theme.colors.accent)
                    .accessibilityHidden(true)
            }
        }
        .frame(minHeight: tokens.albumListRowMinHeight)
        .contentShape(Rectangle())
    }
}

private struct AlbumThumbnailView: View {
    let album: HIGPhotoAlbum
    let configuration: HIGPhotoPickerConfiguration
    let libraryClient: any PhotosLibraryClientProtocol
    let imageLoader: ImageLoadingClient

    @Environment(\.higTheme) private var theme

    private var tokens: any HIGPhotoPickerTokens { theme.photoPicker }

    @State private var thumbnail: CGImage?

    var body: some View {
        ZStack {
            tokens.placeholderFill

            if let thumbnail {
                Image(decorative: thumbnail, scale: 1, orientation: .up)
                    .resizable()
                    .scaledToFill()
            } else {
                Image(systemName: "photo")
                    .font(.title3.weight(.light))
                    .symbolRenderingMode(.hierarchical)
                    .foregroundStyle(.tertiary)
                    .accessibilityHidden(true)
            }
        }
        .task(id: album.id) {
            let assets = await libraryClient.fetchAssets(
                in: album.id,
                allowedMediaTypes: configuration.allowedMediaTypes
            )
            guard let first = assets.first else {
                thumbnail = nil
                return
            }

            let thumbnailSize = CGSize(
                width: tokens.albumThumbnailSize * 2,
                height: tokens.albumThumbnailSize * 2
            )
            if let result = try? await imageLoader.loadThumbnail(for: first, targetSize: thumbnailSize) {
                thumbnail = result.cgImage
            }
        }
    }
}

#if DEBUG
#Preview("Album List") {
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

#Preview("Empty") {
    NavigationStack {
        AlbumListView(
            albums: [],
            selectedAlbumID: nil,
            localization: HIGPhotoPreviewData.configuration.localizationProvider,
            imageLoader: ImageLoadingClient.preview,
            libraryClient: PreviewPhotosLibraryClient(),
            configuration: HIGPhotoPreviewData.configuration,
            onSelect: { _ in }
        )
    }
}
#endif
#endif
