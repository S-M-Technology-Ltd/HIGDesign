#if os(iOS)
import SwiftUI

struct PhotoGridView: View {
    let assets: [HIGPhotoAsset]
    let cellSide: CGFloat
    let configuration: HIGPhotoPickerConfiguration
    @ObservedObject var selection: HIGPhotoPickerSelection
    let imageLoader: ImageLoadingClient
    let onAssetFocused: (HIGPhotoAsset) -> Void

    private var selectionSnapshot: PhotoGridSelectionSnapshot {
        PhotoGridSelectionSnapshot(selection: selection)
    }

    var body: some View {
        #if canImport(UIKit)
        PhotoGridCollectionViewRepresentable(
            assets: assets,
            cellSide: cellSide,
            selectionSnapshot: selectionSnapshot,
            imageLoader: imageLoader,
            onAssetFocused: onAssetFocused,
            onToggleSelection: handleToggleSelection
        )
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(PickerDesign.gridBackground)
        #else
        Text("Photo grid is unavailable on this platform.")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        #endif
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
