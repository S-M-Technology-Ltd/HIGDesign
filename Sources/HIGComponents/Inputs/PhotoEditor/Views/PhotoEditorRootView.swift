#if os(iOS)
import CoreGraphics
import HIGThemesContract
import HIGTokensComponent
import HIGTokensRaw
import SwiftUI

struct PhotoEditorRootView: View {
    let image: CGImage
    let configuration: HIGPhotoEditorConfiguration
    let onCancel: () -> Void
    let onFinish: (HIGPhotoEditorFinishResult) -> Void

    @State private var selectedAspectRatio: HIGPhotoEditorAspectRatio
    @State private var zoomScale: CGFloat = 1
    @State private var lastZoomScale: CGFloat = 1
    @State private var contentOffset = CGSize.zero
    @State private var lastContentOffset = CGSize.zero
    @State private var rotationAngle = 0
    @State private var cropRegionSize = CGSize.zero
    @State private var isInteracting = false
    @State private var hasUserAdjustedCrop = false

    @Environment(\.higTheme) private var theme

    private var tokens: any HIGPhotoEditorTokens { theme.photoEditor }

    init(
        image: CGImage,
        configuration: HIGPhotoEditorConfiguration,
        onCancel: @escaping () -> Void,
        onFinish: @escaping (HIGPhotoEditorFinishResult) -> Void
    ) {
        self.image = image
        self.configuration = configuration
        self.onCancel = onCancel
        self.onFinish = onFinish
        _selectedAspectRatio = State(initialValue: configuration.effectiveAspectRatio)

        if let initial = configuration.initialCropState {
            _zoomScale = State(initialValue: initial.scale)
            _lastZoomScale = State(initialValue: initial.scale)
            _contentOffset = State(initialValue: CGSize(width: initial.offsetX, height: initial.offsetY))
            _lastContentOffset = State(initialValue: CGSize(width: initial.offsetX, height: initial.offsetY))
            _rotationAngle = State(initialValue: initial.angle)
            _cropRegionSize = State(
                initialValue: CGSize(width: initial.cropRegionWidth, height: initial.cropRegionHeight)
            )
            _hasUserAdjustedCrop = State(initialValue: true)
        }
    }

    var body: some View {
        VStack(spacing: HIGSpacing.none.rawValue) {
            if configuration.toolbarPosition == .top {
                toolbar
            }

            editorCanvas
                .frame(maxWidth: .infinity, maxHeight: .infinity)

            if configuration.toolbarPosition == .bottom {
                toolbar
            }
        }
        .background(tokens.canvasBackground)
        .navigationTitle(configuration.localization.title)
        .navigationBarTitleDisplayMode(.inline)
        .accessibilityElement(children: .contain)
        .accessibilityLabel(configuration.localization.title)
    }

    private var toolbar: some View {
        PhotoEditorToolbarView(
            configuration: configuration,
            canReset: hasUserAdjustedCrop,
            onCancel: onCancel,
            onDone: commitCrop,
            onReset: resetCrop,
            onRotate: rotateImage,
            onAspectRatioSelected: updateAspectRatio
        )
    }

    private var editorCanvas: some View {
        GeometryReader { geometry in
            let canvasSize = geometry.size
            let resolvedCropRegion = resolvedCropRegionSize(for: canvasSize)

            ZStack {
                tokens.canvasBackground

                if resolvedCropRegion.width > 0, resolvedCropRegion.height > 0 {
                    PhotoEditorZoomableImageView(
                        cgImage: image,
                        cropRegionSize: resolvedCropRegion,
                        canvasSize: canvasSize,
                        rotationAngle: rotationAngle,
                        maximumZoomScale: tokens.maximumZoomScale,
                        zoomScale: $zoomScale,
                        lastZoomScale: $lastZoomScale,
                        contentOffset: $contentOffset,
                        lastContentOffset: $lastContentOffset,
                        isInteracting: $isInteracting,
                        onAdjusted: { hasUserAdjustedCrop = true }
                    )

                    PhotoEditorOverlayView(
                        cropRegionSize: resolvedCropRegion,
                        canvasSize: canvasSize,
                        croppingStyle: configuration.croppingStyle,
                        showsCompositionGrid: configuration.showsCompositionGridWhileInteracting && isInteracting
                    )
                }
            }
            .onAppear {
                updateCropRegionIfNeeded(resolvedCropRegion, resetTransforms: cropRegionSize == .zero)
            }
            .onChange(of: canvasSize) { _, newSize in
                updateCropRegionIfNeeded(resolvedCropRegionSize(for: newSize), resetTransforms: false)
            }
            .onChange(of: selectedAspectRatio) { _, _ in
                updateCropRegionIfNeeded(resolvedCropRegionSize(for: canvasSize), resetTransforms: true)
            }
        }
    }

    private func resolvedCropRegionSize(for canvasSize: CGSize) -> CGSize {
        let imageSize = HIGPhotoEditorImageProcessor.orientedImageSize(for: image, angle: rotationAngle)
        let aspect = selectedAspectRatio.resolvedAspect(for: imageSize)
        return HIGPhotoEditorImageProcessor.fittedCropRegionSize(
            aspect: aspect,
            availableSize: canvasSize,
            horizontalInset: tokens.cropRegionHorizontalInset,
            verticalInset: tokens.cropRegionVerticalInset,
            minimumSide: tokens.minimumCropRegionSide
        )
    }

    private func updateCropRegionIfNeeded(_ newSize: CGSize, resetTransforms: Bool) {
        guard newSize.width > 0, newSize.height > 0 else { return }

        let sizeChanged = abs(newSize.width - cropRegionSize.width) > 1
            || abs(newSize.height - cropRegionSize.height) > 1

        guard sizeChanged || resetTransforms else { return }

        cropRegionSize = newSize

        if resetTransforms {
            zoomScale = 1
            lastZoomScale = 1
            contentOffset = .zero
            lastContentOffset = .zero
        }
    }

    private func currentCropState() -> HIGPhotoEditorCropState {
        HIGPhotoEditorCropState(
            offsetX: contentOffset.width,
            offsetY: contentOffset.height,
            scale: zoomScale,
            angle: rotationAngle,
            cropRegionWidth: cropRegionSize.width,
            cropRegionHeight: cropRegionSize.height
        )
    }

    private func commitCrop() {
        guard let result = HIGPhotoEditorImageProcessor.renderResult(
            from: image,
            cropState: currentCropState(),
            croppingStyle: configuration.croppingStyle,
            aspectRatio: selectedAspectRatio
        ) else {
            return
        }
        onFinish(result)
    }

    private func resetCrop() {
        zoomScale = 1
        lastZoomScale = 1
        contentOffset = .zero
        lastContentOffset = .zero
        rotationAngle = 0
        hasUserAdjustedCrop = false
        selectedAspectRatio = configuration.effectiveAspectRatio
    }

    private func rotateImage() {
        rotationAngle = HIGPhotoEditorCropState.normalizedAngle(rotationAngle + 90)
        hasUserAdjustedCrop = true
        zoomScale = 1
        lastZoomScale = 1
        contentOffset = .zero
        lastContentOffset = .zero
    }

    private func updateAspectRatio(_ aspectRatio: HIGPhotoEditorAspectRatio) {
        selectedAspectRatio = aspectRatio
        hasUserAdjustedCrop = true
    }
}

private struct PhotoEditorZoomableImageView: View {
    let cgImage: CGImage
    let cropRegionSize: CGSize
    let canvasSize: CGSize
    let rotationAngle: Int
    let maximumZoomScale: CGFloat
    @Binding var zoomScale: CGFloat
    @Binding var lastZoomScale: CGFloat
    @Binding var contentOffset: CGSize
    @Binding var lastContentOffset: CGSize
    @Binding var isInteracting: Bool
    let onAdjusted: () -> Void

    @State private var isDragging = false
    @State private var isZooming = false

    var body: some View {
        let cropOrigin = CGPoint(
            x: (canvasSize.width - cropRegionSize.width) / 2,
            y: (canvasSize.height - cropRegionSize.height) / 2
        )

        Image(decorative: cgImage, scale: 1, orientation: .up)
            .resizable()
            .scaledToFill()
            .frame(width: cropRegionSize.width, height: cropRegionSize.height)
            .scaleEffect(zoomScale)
            .offset(contentOffset)
            .rotationEffect(.degrees(Double(rotationAngle)))
            .frame(width: cropRegionSize.width, height: cropRegionSize.height)
            .clipped()
            .position(
                x: cropOrigin.x + cropRegionSize.width / 2,
                y: cropOrigin.y + cropRegionSize.height / 2
            )
            .contentShape(Rectangle())
            .gesture(dragGesture)
            .simultaneousGesture(zoomGesture)
            .onChange(of: contentOffset) { _, _ in
                onAdjusted()
            }
            .onChange(of: zoomScale) { _, _ in
                onAdjusted()
            }
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
            }
            .onEnded { _ in
                isDragging = false
                updateInteractionState()
                lastContentOffset = contentOffset
            }
    }

    private var zoomGesture: some Gesture {
        MagnificationGesture()
            .onChanged { value in
                isZooming = true
                updateInteractionState()
                zoomScale = HIGPhotoEditorCropState.clampedScale(
                    lastZoomScale * value,
                    maximum: maximumZoomScale
                )
            }
            .onEnded { _ in
                isZooming = false
                updateInteractionState()
                lastZoomScale = zoomScale
            }
    }

    private func updateInteractionState() {
        isInteracting = isDragging || isZooming
    }
}
#endif