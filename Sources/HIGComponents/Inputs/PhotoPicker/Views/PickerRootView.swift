#if os(iOS)
import HIGThemesContract
import HIGTokensComponent
import Photos
import SwiftUI
import UIKit

struct PickerRootView: View {
    @Binding var selection: [HIGPhotoAsset]
    let configuration: HIGPhotoPickerConfiguration
    let onCancel: () -> Void
    let onFinish: (HIGPhotoPickerFinishResult) -> Void

    @StateObject private var pickerSelection: HIGPhotoPickerSelection
    @State private var authorizationStatus: HIGPhotoAuthorizationStatus
    @State private var albums: [HIGPhotoAlbum] = []
    @State private var assets: [HIGPhotoAsset] = []
    @State private var selectedAlbum: HIGPhotoAlbum?
    @State private var showsAlbumList = false
    @State private var libraryChangeObserver: PhotoLibraryChangeObserver?
    @State private var libraryReloadTask: Task<Void, Never>?
    @Environment(\.higTheme) private var theme
    @Environment(\.openURL) private var openURL
    @State private var containerWidth: CGFloat = 0

    private var tokens: any HIGPhotoPickerTokens { theme.photoPicker }
    private var layout: PickerLayout { PickerLayout(tokens: tokens) }

    private let authorizationClient = PhotosAuthorizationClient()
    private let libraryClient: any PhotosLibraryClientProtocol
    private let imageLoader: ImageLoadingClient
    private let skipsBootstrap: Bool


    @State private var headerCollapseProgress: CGFloat = 0
    @State private var isLimitedBannerExpanded = false

    init(
        selection: Binding<[HIGPhotoAsset]>,
        configuration: HIGPhotoPickerConfiguration,
        onCancel: @escaping () -> Void,
        onFinish: @escaping (HIGPhotoPickerFinishResult) -> Void
    ) {
        _selection = selection
        self.configuration = configuration
        self.onCancel = onCancel
        self.onFinish = onFinish
        libraryClient = PhotosLibraryClient()
        imageLoader = ImageLoadingClient()
        skipsBootstrap = false
        _authorizationStatus = State(initialValue: PhotosAuthorizationClient().currentStatus())
        _pickerSelection = StateObject(
            wrappedValue: HIGPhotoPickerSelection(
                assets: selection.wrappedValue,
                configuration: configuration
            )
        )
    }

    #if DEBUG
    init(
        previewState: PickerPreviewState,
        selection: Binding<[HIGPhotoAsset]> = .constant([]),
        configuration: HIGPhotoPickerConfiguration = HIGPhotoPreviewData.configuration,
        onCancel: @escaping () -> Void = {},
        onFinish: @escaping (HIGPhotoPickerFinishResult) -> Void = { _ in }
    ) {
        _selection = selection
        self.configuration = configuration
        self.onCancel = onCancel
        self.onFinish = onFinish
        libraryClient = PreviewPhotosLibraryClient()
        imageLoader = ImageLoadingClient.preview
        skipsBootstrap = true

        let pickerSelection = HIGPhotoPickerSelection(
            assets: selection.wrappedValue,
            configuration: configuration
        )
        if let first = previewState.assets.first {
            pickerSelection.focus(first)
        }
        _pickerSelection = StateObject(wrappedValue: pickerSelection)
        _authorizationStatus = State(initialValue: previewState.authorizationStatus)
        _albums = State(initialValue: previewState.albums)
        _assets = State(initialValue: previewState.assets)
        _selectedAlbum = State(initialValue: previewState.selectedAlbum)
    }
    #endif

    var body: some View {
        NavigationStack {
            Group {
                if authorizationStatus.canBrowseLibrary {
                    pickerContent
                } else {
                    PermissionView(
                        status: authorizationStatus,
                        localization: configuration.localizationProvider,
                        onRequestAccess: requestAuthorization,
                        onManageLimitedAccess: manageLimitedLibraryAccess,
                        onOpenSettings: openApplicationSettings
                    )
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(tokens.chromeBackground)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(
                        configuration.localizationProvider.pickerNavigationCancelButtonText(),
                        role: .cancel
                    ) {
                        onCancel()
                    }
                }

                ToolbarItem(placement: .principal) {
                    albumTitleButton
                }

                if authorizationStatus.canBrowseLibrary {
                    ToolbarItemGroup(placement: .topBarTrailing) {
                        if pickerSelection.allowsMultipleSelection, headerCollapseProgress > 0.5 {
                            showPreviewButton
                        }
                        if configuration.showsSelectionModeToggle {
                            selectionModeButton
                        }
                    }
                }

                ToolbarItem(placement: .confirmationAction) {
                    Button(configuration.localizationProvider.pickerNavigationNextButtonText()) {
                        selection = pickerSelection.assets
                        onFinish(
                            HIGPhotoPickerFinishResult(
                                assets: pickerSelection.assets,
                                previewCrop: pickerSelection.previewCrop
                            )
                        )
                    }
                    .fontWeight(.semibold)
                    .disabled(pickerSelection.isEmpty)
                }
            }
            .toolbarBackground(.visible, for: .navigationBar)
            .tint(.primary)
            .navigationDestination(isPresented: $showsAlbumList) {
                AlbumListView(
                    albums: albums,
                    selectedAlbumID: selectedAlbum?.id,
                    localization: configuration.localizationProvider,
                    imageLoader: imageLoader,
                    libraryClient: libraryClient,
                    configuration: configuration,
                    onSelect: { album in
                        selectedAlbum = album
                        Task {
                            await selectAlbum(album)
                            showsAlbumList = false
                        }
                    }
                )
            }
        }
        .task {
            guard !skipsBootstrap else { return }
            await bootstrap()
        }
        .onDisappear {
            libraryReloadTask?.cancel()
            libraryReloadTask = nil
            libraryChangeObserver?.unregister()
            libraryChangeObserver = nil
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
            refreshAuthorizationStatus()
        }
        .onChange(of: pickerSelection.assets) { _, newValue in
            selection = newValue
        }
    }

    @ViewBuilder
    private var pickerContent: some View {
        let layoutWidth = resolvedContainerWidth
        let gridCellSide = layout.gridCellSideLength(containerWidth: layoutWidth)
        let headerHeight = layout.collapsibleHeaderHeight(
            containerWidth: layoutWidth,
            showsBanner: authorizationStatus == .limited,
            isBannerExpanded: isLimitedBannerExpanded,
            collapseProgress: headerCollapseProgress
        )

        VStack(spacing: tokens.stackSpacingNone) {
            pickerHeader(layoutWidth: layoutWidth)
                .frame(height: headerHeight, alignment: .top)
                .clipped()

            PhotoGridView(
                assets: assets,
                cellSide: gridCellSide,
                configuration: configuration,
                selection: pickerSelection,
                imageLoader: imageLoader,
                onAssetFocused: handleAssetFocused
            )
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(tokens.gridBackground)
        .onContainerWidthChange($containerWidth)
        .animation(nil, value: containerWidth)
    }

    private var resolvedContainerWidth: CGFloat {
        containerWidth > 0 ? containerWidth : tokens.fallbackLayoutWidth
    }

    private func pickerHeader(layoutWidth: CGFloat) -> some View {
        PickerCollapsibleHeader(
            containerWidth: layoutWidth,
            showsBanner: authorizationStatus == .limited,
            isBannerExpanded: isLimitedBannerExpanded,
            collapseProgress: headerCollapseProgress,
            localization: configuration.localizationProvider,
            onCollapseSwipe: handleHeaderSwipe
        ) { previewHeight in
            PhotoPreviewContainerView(
                asset: pickerSelection.focusedAsset,
                layoutHeight: previewHeight,
                configuration: configuration,
                imageLoader: imageLoader,
                onPreviewCropChanged: { crop in
                    pickerSelection.updatePreviewCrop(
                        offsetX: crop.offsetX,
                        offsetY: crop.offsetY,
                        scale: crop.scale,
                        previewSide: crop.previewSide
                    )
                }
            )
            .id(pickerSelection.focusedAsset?.id ?? "preview-empty")
            .frame(maxWidth: .infinity)
            .frame(height: previewHeight)
            .clipped()
        } banner: {
            limitedAccessBanner
        }
    }

    private var showPreviewButton: some View {
        PickerChromeIconButtonView(
            systemImage: "chevron.down",
            accessibilityLabel: configuration.localizationProvider.pickerShowPreviewButtonText(),
            action: expandPickerHeader
        )
    }

    private func handleAssetFocused(_ asset: HIGPhotoAsset) {
        pickerSelection.focus(asset)
        pickerSelection.resetPreviewCrop()

        if !pickerSelection.allowsMultipleSelection {
            expandPickerHeader()
        }
    }

    private func handleHeaderSwipe(_ direction: PickerHeaderSwipeDirection) {
        withAnimation(.spring(response: 0.35, dampingFraction: 0.86)) {
            switch direction {
            case .up:
                headerCollapseProgress = 1
                collapseLimitedBannerIfNeeded()
            case .down:
                headerCollapseProgress = 0
            }
        }
    }

    private func expandPickerHeader() {
        withAnimation(.spring(response: 0.35, dampingFraction: 0.86)) {
            headerCollapseProgress = 0
        }
    }

    private func toggleLimitedBanner() {
        withAnimation(.easeInOut(duration: theme.motion.quick)) {
            isLimitedBannerExpanded.toggle()
        }
    }

    private func collapseLimitedBannerIfNeeded() {
        guard isLimitedBannerExpanded else { return }
        withAnimation(.easeInOut(duration: theme.motion.quick)) {
            isLimitedBannerExpanded = false
        }
    }

    private var selectionModeButton: some View {
        PickerChromeIconButtonView(
            systemImage: pickerSelection.allowsMultipleSelection
                ? "checkmark.circle.badge.plus"
                : "checkmark.circle",
            accessibilityLabel: pickerSelection.allowsMultipleSelection
                ? configuration.localizationProvider.pickerMultipleSelectionModeText()
                : configuration.localizationProvider.pickerSingleSelectionModeText(),
            accessibilityHint: pickerSelection.allowsMultipleSelection
                ? "Switch to single photo selection"
                : "Switch to multiple photo selection",
            action: {
                pickerSelection.setAllowsMultipleSelection(!pickerSelection.allowsMultipleSelection)
            }
        )
    }

    private var canSwitchAlbums: Bool {
        authorizationStatus == .authorized && !albums.isEmpty
    }

    private var principalNavigationTitle: String {
        if authorizationStatus == .limited {
            return configuration.localizationProvider.pickerNavigationTitle()
        }
        return selectedAlbum?.name ?? configuration.localizationProvider.pickerDefaultAlbumName()
    }

    private var albumTitleButton: some View {
        Button {
            showsAlbumList = true
        } label: {
            HStack(spacing: tokens.navigationTitleSpacing) {
                Text(principalNavigationTitle)
                    .font(.headline)
                    .foregroundStyle(canSwitchAlbums ? .primary : .secondary)
                    .lineLimit(1)

                if canSwitchAlbums {
                    Image(systemName: "chevron.down")
                        .font(.caption2.weight(.bold))
                        .foregroundStyle(.secondary)
                }
            }
            .frame(minHeight: 44)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .disabled(!canSwitchAlbums)
        .accessibilityLabel(
            canSwitchAlbums
                ? "Album, \(principalNavigationTitle)"
                : principalNavigationTitle
        )
        .accessibilityHint(canSwitchAlbums ? "Shows album list" : "")
    }

    private var limitedAccessBanner: some View {
        LimitedAccessBannerView(
            title: configuration.localizationProvider.photosLimitedAccessTitle(),
            description: configuration.localizationProvider.photosLimitedAccessModeText(),
            actionTitle: configuration.localizationProvider.pickerAddingImageAccessButtonText(),
            isExpanded: isLimitedBannerExpanded,
            headerCollapseProgress: headerCollapseProgress,
            onToggle: toggleLimitedBanner,
            onManageAccess: manageLimitedLibraryAccess,
            onHeaderCollapseSwipe: handleHeaderSwipe
        )
    }

    private func manageLimitedLibraryAccess() {
        LimitedLibraryPickerPresenter.present {
            reloadLibrary()
        }
    }

    private func bootstrap() async {
        refreshAuthorizationStatus()

        if authorizationStatus == .notDetermined, configuration.automaticallyRequestsPhotoAccess {
            authorizationStatus = await authorizationClient.requestAuthorization()
            refreshAuthorizationStatus()
        }

        PhotoLibraryHostRequirements.logMissingRequirementsIfNeeded(for: authorizationStatus)
        #if DEBUG
        print("HIGPhotoPicker using \(HIGPhotoPickerRuntime.imagePipelineIdentifier)")
        #endif

        guard authorizationStatus.canBrowseLibrary else { return }
        reloadLibrary()
        registerLibraryObserver()
    }

    private func refreshAuthorizationStatus() {
        authorizationStatus = authorizationClient.currentStatus()
    }

    private func requestAuthorization() {
        Task {
            authorizationStatus = await authorizationClient.requestAuthorization()
            if authorizationStatus.canBrowseLibrary {
                reloadLibrary()
                registerLibraryObserver()
            }
        }
    }

    private func reloadLibrary() {
        libraryReloadTask?.cancel()
        libraryReloadTask = Task {
            // Coalesce rapid PhotoKit change notifications triggered by caching and image loads.
            try? await Task.sleep(nanoseconds: 250_000_000)
            guard !Task.isCancelled else { return }
            await performLibraryReload()
        }
    }

    @MainActor
    private func performLibraryReload() async {
        let currentAlbumID = selectedAlbum?.id
        let fetchedAlbums = await libraryClient.fetchAlbums(
            allowedMediaTypes: configuration.allowedMediaTypes
        )

        albums = fetchedAlbums

        guard let albumToSelect = albumToSelect(
            currentAlbumID: currentAlbumID,
            in: fetchedAlbums
        ) else {
            return
        }

        await selectAlbum(albumToSelect)
    }

    private func albumToSelect(
        currentAlbumID: String?,
        in fetchedAlbums: [HIGPhotoAlbum]
    ) -> HIGPhotoAlbum? {
        if let currentAlbumID,
           let preserved = fetchedAlbums.first(where: { $0.id == currentAlbumID }) {
            return preserved
        }

        if let preferredID = configuration.preferredAlbumIdentifier,
           let preferred = fetchedAlbums.first(where: { $0.id == preferredID }) {
            return preferred
        }

        return fetchedAlbums.first
    }

    @MainActor
    private func selectAlbum(_ album: HIGPhotoAlbum) async {
        let fetchedAssets = await libraryClient.fetchAssets(
            in: album.id,
            allowedMediaTypes: configuration.allowedMediaTypes
        )

        let isSameAlbum = selectedAlbum?.id == album.id
        let assetIDsChanged = assets.map(\.id) != fetchedAssets.map(\.id)

        selectedAlbum = album

        guard !isSameAlbum || assetIDsChanged else {
            return
        }

        assets = fetchedAssets

        if let first = fetchedAssets.first {
            if let focused = pickerSelection.focusedAsset, fetchedAssets.contains(focused) {
                pickerSelection.focus(focused)
            } else {
                pickerSelection.focus(first)
            }
        } else {
            pickerSelection.clear()
        }

        let cacheIDs = Array(fetchedAssets.prefix(40).map(\.id))
        imageLoader.prepareAssets(ids: cacheIDs)
        imageLoader.startCaching(
            assetIDs: cacheIDs,
            targetSize: PhotoKitImageSizing.gridCellPointSize()
        )
    }

    private func openApplicationSettings() {
        openURL(SettingsURL.applicationSettings)
    }

    private func registerLibraryObserver() {
        guard HIGPhotoPickerRuntime.shouldAccessPhotoKit else { return }
        guard libraryChangeObserver == nil else { return }

        let observer = PhotoLibraryChangeObserver {
            reloadLibrary()
        }
        observer.register()
        libraryChangeObserver = observer
    }
}

private struct PhotoPreviewContainerView: View {
    let asset: HIGPhotoAsset?
    let layoutHeight: CGFloat
    let configuration: HIGPhotoPickerConfiguration
    let imageLoader: ImageLoadingClient
    let onPreviewCropChanged: (HIGPhotoPreviewCrop) -> Void

    var body: some View {
        PhotoPreviewView(
            asset: asset,
            layoutHeight: layoutHeight,
            configuration: configuration,
            imageLoader: imageLoader,
            onPreviewCropChanged: onPreviewCropChanged
        )
    }
}

@MainActor
private final class PhotoLibraryChangeObserver: NSObject, PHPhotoLibraryChangeObserver {
    private let onChange: () -> Void

    init(onChange: @escaping () -> Void) {
        self.onChange = onChange
    }

    func register() {
        PHPhotoLibrary.shared().register(self)
    }

    func unregister() {
        PHPhotoLibrary.shared().unregisterChangeObserver(self)
    }

    nonisolated func photoLibraryDidChange(_ changeInstance: PHChange) {
        Task { @MainActor in
            onChange()
        }
    }
}

#if DEBUG
#Preview("Authorized") {
    HIGPhotoPreviewHostFactory.pickerRoot(state: .authorized)
}

#Preview("Limited") {
    HIGPhotoPreviewHostFactory.pickerRoot(state: .limited)
}

#Preview("Denied") {
    HIGPhotoPreviewHostFactory.pickerRoot(state: .denied)
}

#Preview("Not Determined") {
    HIGPhotoPreviewHostFactory.pickerRoot(state: .notDetermined)
}
#endif
#endif
