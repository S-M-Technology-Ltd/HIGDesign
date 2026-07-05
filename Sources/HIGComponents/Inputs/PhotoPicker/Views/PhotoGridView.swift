#if os(iOS)
import HIGThemesContract
import HIGTokensComponent
import SwiftUI

struct PhotoGridView: View {
    let assets: [HIGPhotoAsset]
    let cellSide: CGFloat
    let configuration: HIGPhotoPickerConfiguration
    @ObservedObject var selection: HIGPhotoPickerSelection
    let imageLoader: ImageLoadingClient
    let onAssetFocused: (HIGPhotoAsset) -> Void

    @Environment(\.higTheme) private var theme

    private var tokens: any HIGPhotoPickerTokens { theme.photoPicker }

    private var selectionSnapshot: PhotoGridSelectionSnapshot {
        PhotoGridSelectionSnapshot(selection: selection)
    }

    var body: some View {
        PhotoGridCollectionViewRepresentable(
            assets: assets,
            cellSide: cellSide,
            appearance: PhotoGridUIKitAppearance(tokens: tokens),
            selectionSnapshot: selectionSnapshot,
            imageLoader: imageLoader,
            onAssetFocused: onAssetFocused,
            onToggleSelection: handleToggleSelection
        )
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(tokens.gridBackground)
    }

    private func handleToggleSelection(_ asset: HIGPhotoAsset) {
        if selection.allowsMultipleSelection {
            selection.toggle(asset)
        } else {
            selection.focus(asset)
        }
    }
}

#if DEBUG
#Preview("Empty Selection") {
    HIGPhotoPreviewHostFactory.photoGrid(
        selection: HIGPhotoPickerSelection(configuration: HIGPhotoPreviewData.configuration)
    )
}

#Preview("With Selection") {
    HIGPhotoPreviewHostFactory.photoGrid(
        selection: HIGPhotoPreviewData.makeSelection(selectedCount: 3)
    )
}
#endif
#endif