#if os(iOS)
import Foundation

/// Placement of the editor toolbar, matching ``TOCropViewController`` toolbar positions.
public enum HIGPhotoEditorToolbarPosition: String, Sendable, Equatable {
    case bottom
    case top
}
#endif