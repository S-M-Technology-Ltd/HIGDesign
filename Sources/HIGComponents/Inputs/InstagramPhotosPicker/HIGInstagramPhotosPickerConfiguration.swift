import CoreGraphics

/// Configuration for ``HIGInstagramPhotosPicker``.
public struct HIGInstagramPhotosPickerConfiguration: Sendable {
    /// Maximum number of assets that can be selected. `0` means no limit.
    public var selectionLimit: Int

    /// Media types shown in the picker.
    public var allowedMediaTypes: Set<HIGInstagramPhotosMediaType>

    /// Whether the user can select more than one asset.
    public var allowsMultipleSelection: Bool

    /// Shows a toolbar control for switching between single and multiple selection.
    public var showsSelectionModeToggle: Bool

    /// Target size for grid thumbnails.
    public var thumbnailSize: CGSize

    /// Album local identifier to open first. `nil` uses the first available album.
    public var preferredAlbumIdentifier: String?

    /// Whether PhotoKit may download iCloud-backed assets over the network.
    public var iCloudNetworkAccessAllowed: Bool

    /// Whether download progress UI is shown for iCloud assets.
    public var showsProgress: Bool

    /// Requests the system photo permission dialog automatically when the picker opens.
    public var automaticallyRequestsPhotoAccess: Bool

    public init(
        selectionLimit: Int = 1,
        allowedMediaTypes: Set<HIGInstagramPhotosMediaType> = [.image],
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

    /// Effective selection limit accounting for single-selection mode.
    public var effectiveSelectionLimit: Int {
        if allowsMultipleSelection {
            return selectionLimit == 0 ? .max : selectionLimit
        }
        return 1
    }
}