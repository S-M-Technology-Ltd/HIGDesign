#if !os(iOS)
import SwiftUI

/// Media types supported by ``HIGPhotoPicker``.
public enum HIGPhotoMediaType: Sendable, Hashable, CaseIterable {
    case image
    case video
    case audio
}

/// A lightweight reference to a photo-library asset selected through ``HIGPhotoPicker``.
public struct HIGPhotoAsset: Identifiable, Sendable, Hashable, Equatable {
    public let id: String
    public let mediaType: HIGPhotoMediaType
    public let pixelWidth: Int
    public let pixelHeight: Int
    public let creationDate: Date?
    public let isLocallyAvailable: Bool

    public init(
        id: String,
        mediaType: HIGPhotoMediaType,
        pixelWidth: Int,
        pixelHeight: Int,
        creationDate: Date?,
        isLocallyAvailable: Bool
    ) {
        self.id = id
        self.mediaType = mediaType
        self.pixelWidth = pixelWidth
        self.pixelHeight = pixelHeight
        self.creationDate = creationDate
        self.isLocallyAvailable = isLocallyAvailable
    }
}

/// Configuration for ``HIGPhotoPicker``.
public struct HIGPhotoPickerConfiguration: Sendable {
    public var selectionLimit: Int
    public var allowedMediaTypes: Set<HIGPhotoMediaType>
    public var allowsMultipleSelection: Bool
    public var showsSelectionModeToggle: Bool
    public var thumbnailSize: CGSize
    public var preferredAlbumIdentifier: String?
    public var iCloudNetworkAccessAllowed: Bool
    public var showsProgress: Bool
    public var automaticallyRequestsPhotoAccess: Bool

    public init(
        selectionLimit: Int = 1,
        allowedMediaTypes: Set<HIGPhotoMediaType> = [.image],
        allowsMultipleSelection: Bool = false,
        showsSelectionModeToggle: Bool = true,
        thumbnailSize: CGSize = CGSize(width: 300, height: 300),
        preferredAlbumIdentifier: String? = nil,
        iCloudNetworkAccessAllowed: Bool = true,
        showsProgress: Bool = true,
        automaticallyRequestsPhotoAccess: Bool = false
    ) {
        self.selectionLimit = selectionLimit
        self.allowedMediaTypes = allowedMediaTypes
        self.allowsMultipleSelection = allowsMultipleSelection
        self.showsSelectionModeToggle = showsSelectionModeToggle
        self.thumbnailSize = thumbnailSize
        self.preferredAlbumIdentifier = preferredAlbumIdentifier
        self.iCloudNetworkAccessAllowed = iCloudNetworkAccessAllowed
        self.showsProgress = showsProgress
        self.automaticallyRequestsPhotoAccess = automaticallyRequestsPhotoAccess
    }

    public var effectiveSelectionLimit: Int {
        if allowsMultipleSelection {
            return selectionLimit == 0 ? .max : selectionLimit
        }
        return 1
    }
}

/// Preview crop state returned when ``HIGPhotoPicker`` finishes.
public struct HIGPhotoPreviewCrop: Equatable, Sendable {
    public var offsetX: CGFloat
    public var offsetY: CGFloat
    public var scale: CGFloat
    public var previewSide: CGFloat

    public init(
        offsetX: CGFloat = 0,
        offsetY: CGFloat = 0,
        scale: CGFloat = 1,
        previewSide: CGFloat = 0
    ) {
        self.offsetX = offsetX
        self.offsetY = offsetY
        self.scale = scale
        self.previewSide = previewSide
    }
}

/// Assets and preview crop state returned when ``HIGPhotoPicker`` finishes.
public struct HIGPhotoPickerFinishResult: Equatable, Sendable {
    public let assets: [HIGPhotoAsset]
    public let previewCrop: HIGPhotoPreviewCrop

    public init(assets: [HIGPhotoAsset], previewCrop: HIGPhotoPreviewCrop) {
        self.assets = assets
        self.previewCrop = previewCrop
    }
}

/// Photo library picker with album browsing (iOS only).
public struct HIGPhotoPicker: View {
    @Binding private var selection: [HIGPhotoAsset]
    private let configuration: HIGPhotoPickerConfiguration
    private let onCancel: (() -> Void)?
    private let onFinish: ((HIGPhotoPickerFinishResult) -> Void)?

    public init(
        selection: Binding<[HIGPhotoAsset]>,
        configuration: HIGPhotoPickerConfiguration = .init(),
        onCancel: (() -> Void)? = nil,
        onFinish: ((HIGPhotoPickerFinishResult) -> Void)? = nil
    ) {
        _selection = selection
        self.configuration = configuration
        self.onCancel = onCancel
        self.onFinish = onFinish
    }

    public var body: some View {
        ContentUnavailableView(
            "Photo Picker Unavailable",
            systemImage: "photo.on.rectangle.angled",
            description: Text("HIGPhotoPicker is available on iOS only.")
        )
        .padding()
    }
}
#endif