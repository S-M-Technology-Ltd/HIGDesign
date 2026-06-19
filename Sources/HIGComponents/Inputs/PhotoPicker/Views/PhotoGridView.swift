#if os(iOS)
import SwiftUI

struct PhotoGridSelectionSnapshot: Equatable {
    let selectedOrderByID: [String: Int]
    let showsSelectionOrder: Bool

    init(selectedOrderByID: [String: Int], showsSelectionOrder: Bool) {
        self.selectedOrderByID = selectedOrderByID
        self.showsSelectionOrder = showsSelectionOrder
    }

    @MainActor
    init(selection: HIGPhotoPickerSelection) {
        showsSelectionOrder = selection.allowsMultipleSelection
        var order: [String: Int] = [:]
        for (index, asset) in selection.assets.enumerated() {
            order[asset.id] = index
        }
        selectedOrderByID = order
    }

    func selectionIndex(for assetID: String) -> Int? {
        selectedOrderByID[assetID]
    }
}

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

    private var columns: [GridItem] {
        Array(
            repeating: GridItem(.flexible(), spacing: PickerDesign.gridSpacing),
            count: PickerDesign.gridColumnCount
        )
    }

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: PickerDesign.gridSpacing) {
                ForEach(Array(assets.enumerated()), id: \.element.id) { index, asset in
                    PhotoGridCellView(
                        asset: asset,
                        cellSide: cellSide,
                        selectionIndex: selectionSnapshot.selectionIndex(for: asset.id),
                        showsSelectionOrder: selectionSnapshot.showsSelectionOrder,
                        imageLoader: imageLoader,
                        onTap: {
                            handleToggleSelection(asset)
                            onAssetFocused(asset)
                        }
                    )
                    .onAppear {
                        prefetch(around: index)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(PickerDesign.gridBackground)
    }

    private func handleToggleSelection(_ asset: HIGPhotoAsset) {
        if selection.allowsMultipleSelection {
            selection.toggle(asset)
        } else {
            selection.focus(asset)
        }
    }

    private func prefetch(around index: Int) {
        guard cellSide > 0, !assets.isEmpty else { return }

        let start = max(0, index - 6)
        let end = min(assets.count, index + 12)
        let ids = assets[start..<end].map(\.id)
        imageLoader.prepareAssets(ids: ids)
        imageLoader.startCaching(
            assetIDs: ids,
            targetSize: CGSize(width: cellSide, height: cellSide)
        )
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