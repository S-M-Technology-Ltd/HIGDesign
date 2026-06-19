#if os(iOS)
import HIGThemesContract
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
    let configuration: HIGPhotoPickerConfiguration
    @ObservedObject var selection: HIGPhotoPickerSelection
    let imageLoader: ImageLoadingClient
    let onAssetFocused: (HIGPhotoAsset) -> Void

    @Environment(\.higTheme) private var theme

    private var tokens: any HIGPhotoPickerTokens { theme.photoPicker }
    private var layout: PickerLayout { PickerLayout(tokens: tokens) }

    private var selectionSnapshot: PhotoGridSelectionSnapshot {
        PhotoGridSelectionSnapshot(selection: selection)
    }

    var body: some View {
        GeometryReader { geometry in
            let containerWidth = geometry.size.width
            let cellSide = layout.gridCellSideLength(containerWidth: containerWidth)
            let columns = Array(
                repeating: GridItem(.fixed(cellSide), spacing: tokens.gridSpacing),
                count: tokens.gridColumnCount
            )
            let horizontalAlignmentInset = layout.gridHorizontalAlignmentInset(
                containerWidth: containerWidth,
                cellSide: cellSide
            )

            ScrollView {
                LazyVGrid(columns: columns, spacing: tokens.gridSpacing) {
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
                            prefetch(around: index, cellSide: cellSide)
                        }
                    }
                }
                .padding(.horizontal, horizontalAlignmentInset)
            }
        }
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

    private func prefetch(around index: Int, cellSide: CGFloat) {
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