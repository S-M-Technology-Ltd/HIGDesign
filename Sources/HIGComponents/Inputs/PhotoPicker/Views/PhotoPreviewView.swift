#if os(iOS)
import CoreGraphics
import HIGThemesContract
import HIGTokensComponent
import SwiftUI

struct PhotoPreviewView: View {
    let asset: HIGPhotoAsset?
    var layoutHeight: CGFloat?
    let configuration: HIGPhotoPickerConfiguration
    let imageLoader: ImageLoadingClient
    let onPreviewCropChanged: (HIGPhotoPreviewCrop) -> Void

    @State private var previewImage: CGImage?
    @State private var downloadProgress: Double = 0
    @State private var isDownloading = false
    @State private var loadTask: Task<Void, Never>?
    @State private var zoomScale: CGFloat = 1
    @State private var lastZoomScale: CGFloat = 1
    @State private var contentOffset = CGSize.zero
    @State private var lastContentOffset = CGSize.zero
    @State private var showsCropMask = false
    @State private var previewSide: CGFloat = 0
    @State private var loadedAssetID: String?

    @Environment(\.higTheme) private var theme

    private var tokens: any HIGPhotoPickerTokens { theme.photoPicker }

    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = resolvedLayoutHeight(width: width)
            previewContent(width: width, height: height)
                .frame(width: width, height: height, alignment: .top)
        }
        .frame(maxWidth: .infinity)
        .onDisappear {
            loadTask?.cancel()
            loadTask = nil
        }
    }

    private func resolvedLayoutHeight(width: CGFloat) -> CGFloat {
        if let layoutHeight, layoutHeight > 0 {
            return layoutHeight
        }
        return width
    }

    @ViewBuilder
    private func previewContent(width: CGFloat, height: CGFloat) -> some View {
        let previewSize = CGSize(width: width, height: height)
        let cropSide = min(width, height)

        ZStack {
            tokens.previewBackground

            if let previewImage {
                ZoomableSwiftUIImageView(
                    cgImage: previewImage,
                    previewSize: previewSize,
                    maximumZoomScale: tokens.previewMaximumZoomScale,
                    zoomScale: $zoomScale,
                    lastZoomScale: $lastZoomScale,
                    contentOffset: $contentOffset,
                    lastContentOffset: $lastContentOffset,
                    isInteracting: $showsCropMask,
                    onCropChanged: publishPreviewCrop
                )
            } else {
                ProgressView()
                    .controlSize(.regular)
            }

            if showsCropMask {
                PreviewCompositionGridOverlay()
                    .frame(width: width, height: height)
            }

            if configuration.showsProgress, isDownloading {
                LoadingProgressView(
                    progress: downloadProgress,
                    label: configuration.localizationProvider.iCloudDownloadingText()
                )
            }
        }
        .frame(width: width, height: height, alignment: .top)
        .clipped()
        .transaction { transaction in
            transaction.animation = nil
        }
        .onAppear {
            updatePreviewDimensionsIfNeeded(width: width, height: height, cropSide: cropSide)
        }
        .onChange(of: width) { newWidth in
            updatePreviewDimensionsIfNeeded(
                width: newWidth,
                height: height,
                cropSide: min(newWidth, height)
            )
        }
        .onChange(of: height) { newHeight in
            updatePreviewDimensionsIfNeeded(
                width: width,
                height: newHeight,
                cropSide: min(width, newHeight)
            )
        }
    }

    private func updatePreviewDimensionsIfNeeded(width: CGFloat, height: CGFloat, cropSide: CGFloat) {
        guard width > 0, height > 0, cropSide > 0 else { return }
        guard abs(cropSide - previewSide) > 1 else { return }

        previewSide = cropSide
        publishPreviewCrop()
        reloadImage(using: max(width, height))
    }

    private func publishPreviewCrop() {
        onPreviewCropChanged(
            HIGPhotoPreviewCrop(
                offsetX: contentOffset.width,
                offsetY: contentOffset.height,
                scale: zoomScale,
                previewSide: previewSide
            )
        )
    }

    private func reloadImage(using side: CGFloat?) {
        guard let asset else {
            loadTask?.cancel()
            previewImage = nil
            loadedAssetID = nil
            return
        }

        if loadedAssetID == asset.id, previewImage != nil {
            return
        }

        loadTask?.cancel()
        if loadedAssetID != asset.id {
            previewImage = nil
        }
        downloadProgress = 0
        isDownloading = false
        zoomScale = 1
        lastZoomScale = 1
        contentOffset = .zero
        lastContentOffset = .zero
        publishPreviewCrop()

        let resolvedSide = max(side ?? previewSide, tokens.previewMinimumLoadSide)
        let previewPointSize = CGSize(
            width: resolvedSide * tokens.previewZoomHeadroom,
            height: resolvedSide * tokens.previewZoomHeadroom
        )
        let allowsNetwork = configuration.iCloudNetworkAccessAllowed
        let gridCacheKey = ImageCacheKey.thumbnail(
            assetID: asset.id,
            targetSize: configuration.thumbnailSize
        )

        loadTask = Task {
            var cached = await ImageCache.shared.image(for: gridCacheKey)
            if cached == nil {
                cached = await ImageCache.shared.imageForAssetID(asset.id)
            }
            if let cached {
                guard !Task.isCancelled else { return }
                await applyPreviewImage(cached, assetID: asset.id)
            }

            await imageLoader.ensurePrepared(assetID: asset.id)

            do {
                let result = try await imageLoader.loadPreviewImage(
                    for: asset,
                    targetSize: previewPointSize,
                    allowsNetwork: allowsNetwork
                )

                guard !Task.isCancelled else { return }
                await applyPreviewImage(result.cgImage, assetID: asset.id)

                let cacheKey = ImageCacheKey.thumbnail(assetID: asset.id, targetSize: previewPointSize)
                await ImageCache.shared.insert(result.cgImage, for: cacheKey, assetID: asset.id)

                guard needsFullSizeUpgrade(result: result, asset: asset, allowsNetwork: allowsNetwork) else {
                    await MainActor.run { isDownloading = false }
                    return
                }

                await MainActor.run {
                    isDownloading = result.isInCloud && allowsNetwork
                }

                let fullImage = try await imageLoader.loadFullSizeImage(for: asset) { progress in
                    Task { @MainActor in
                        downloadProgress = progress
                        isDownloading = true
                    }
                }

                guard !Task.isCancelled else { return }
                await applyPreviewImage(fullImage, assetID: asset.id)
                await MainActor.run {
                    isDownloading = false
                    downloadProgress = 0
                }
            } catch {
                await loadFullSizeFallback(for: asset, allowsNetwork: allowsNetwork)
            }
        }
    }

    @MainActor
    private func applyPreviewImage(_ image: CGImage, assetID: String) {
        previewImage = image
        loadedAssetID = assetID
    }

    private func needsFullSizeUpgrade(
        result: ImageLoadResult,
        asset: HIGPhotoAsset,
        allowsNetwork: Bool
    ) -> Bool {
        if result.isInCloud, allowsNetwork {
            return true
        }

        let loadedMaxSide = max(result.cgImage.width, result.cgImage.height)
        let assetMaxSide = max(asset.pixelWidth, asset.pixelHeight)
        return loadedMaxSide < assetMaxSide / 2
    }

    private func loadFullSizeFallback(for asset: HIGPhotoAsset, allowsNetwork: Bool) async {
        guard !Task.isCancelled else { return }

        do {
            await MainActor.run {
                isDownloading = asset.isLocallyAvailable == false && allowsNetwork
            }

            let fullImage = try await imageLoader.loadFullSizeImage(for: asset) { progress in
                Task { @MainActor in
                    downloadProgress = progress
                    isDownloading = true
                }
            }

            guard !Task.isCancelled else { return }
            await applyPreviewImage(fullImage, assetID: asset.id)
            await MainActor.run {
                isDownloading = false
                downloadProgress = 0
            }
        } catch {
            await MainActor.run {
                if previewImage == nil {
                    loadedAssetID = nil
                }
                isDownloading = false
            }
        }
    }
}

private struct PreviewCompositionGridOverlay: View {
    @Environment(\.higTheme) private var theme

    private var tokens: any HIGPhotoPickerTokens { theme.photoPicker }

    var body: some View {
        let lineColor = theme.colors.labelPrimary.opacity(tokens.compositionGridLineOpacity)
        let lineWidth = tokens.compositionGridLineWidth

        Canvas { context, size in
            let stroke = StrokeStyle(lineWidth: lineWidth)

            context.stroke(
                Path(CGRect(origin: .zero, size: size)),
                with: .color(lineColor),
                style: stroke
            )

            let thirdWidth = size.width / 3
            let thirdHeight = size.height / 3

            var grid = Path()
            grid.move(to: CGPoint(x: thirdWidth, y: 0))
            grid.addLine(to: CGPoint(x: thirdWidth, y: size.height))
            grid.move(to: CGPoint(x: thirdWidth * 2, y: 0))
            grid.addLine(to: CGPoint(x: thirdWidth * 2, y: size.height))
            grid.move(to: CGPoint(x: 0, y: thirdHeight))
            grid.addLine(to: CGPoint(x: size.width, y: thirdHeight))
            grid.move(to: CGPoint(x: 0, y: thirdHeight * 2))
            grid.addLine(to: CGPoint(x: size.width, y: thirdHeight * 2))

            context.stroke(grid, with: .color(lineColor), style: stroke)
        }
        .allowsHitTesting(false)
    }
}

private struct ZoomableSwiftUIImageView: View {
    let cgImage: CGImage
    let previewSize: CGSize
    let maximumZoomScale: CGFloat
    @Binding var zoomScale: CGFloat
    @Binding var lastZoomScale: CGFloat
    @Binding var contentOffset: CGSize
    @Binding var lastContentOffset: CGSize
    @Binding var isInteracting: Bool
    let onCropChanged: () -> Void

    @State private var isDragging = false
    @State private var isZooming = false

    var body: some View {
        Image(decorative: cgImage, scale: 1, orientation: .up)
            .resizable()
            .scaledToFill()
            .frame(width: previewSize.width, height: previewSize.height)
            .scaleEffect(zoomScale)
            .offset(contentOffset)
            .frame(width: previewSize.width, height: previewSize.height)
            .clipped()
            .contentShape(Rectangle())
            .gesture(dragGesture)
            .simultaneousGesture(zoomGesture)
    }

    private var dragGesture: some Gesture {
        DragGesture()
            .onChanged { value in
                isDragging = true
                updateInteractionState()
                contentOffset = CGSize(
                    width: lastContentOffset.width + value.translation.width,
                    height: lastContentOffset.height + value.translation.height
                )
                onCropChanged()
            }
            .onEnded { _ in
                isDragging = false
                updateInteractionState()
                lastContentOffset = contentOffset
                onCropChanged()
            }
    }

    private var zoomGesture: some Gesture {
        MagnificationGesture()
            .onChanged { value in
                isZooming = true
                updateInteractionState()
                zoomScale = min(max(lastZoomScale * value, 1), maximumZoomScale)
                onCropChanged()
            }
            .onEnded { _ in
                isZooming = false
                updateInteractionState()
                lastZoomScale = zoomScale
                onCropChanged()
            }
    }

    private func updateInteractionState() {
        isInteracting = isDragging || isZooming
    }
}

#if DEBUG
#Preview("Focused Asset") {
    HIGPhotoPreviewHostFactory.photoPreview()
}

#Preview("No Asset") {
    HIGPhotoPreviewHostFactory.photoPreview(asset: nil)
}

#Preview("iCloud Download") {
    PhotoPreviewView(
        asset: HIGPhotoPreviewData.assets.first { !$0.isLocallyAvailable },
        configuration: HIGPhotoPreviewData.configuration,
        imageLoader: ImageLoadingClient.preview,
        onPreviewCropChanged: { _ in }
    )
}

#Preview("Composition Grid") {
    let tokens = HIGSystemPhotoPickerTokens()
    ZStack {
        tokens.previewBackground
        PreviewCompositionGridOverlay()
    }
    .frame(width: tokens.fallbackLayoutWidth * 0.75, height: tokens.fallbackLayoutWidth * 0.75)
}
#endif
#endif
