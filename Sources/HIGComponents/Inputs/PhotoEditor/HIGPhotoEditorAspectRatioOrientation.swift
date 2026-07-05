#if os(iOS)
import Foundation

/// Crop-frame orientation for ``HIGPhotoEditor`` aspect ratio presets.
public enum HIGPhotoEditorAspectRatioOrientation: String, Sendable, Equatable, CaseIterable, Identifiable {
    case landscape
    case portrait

    public var id: String { rawValue }

    public var title: String {
        switch self {
        case .landscape: "Landscape"
        case .portrait: "Portrait"
        }
    }

    public var toggled: Self {
        switch self {
        case .landscape: .portrait
        case .portrait: .landscape
        }
    }
}
#endif