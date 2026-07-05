#if os(iOS)
import CoreGraphics
import Foundation

/// Aspect ratio presets inspired by ``TOCropViewController``.
public enum HIGPhotoEditorAspectRatio: String, Sendable, Equatable, CaseIterable, Identifiable {
    case original
    case square
    case landscape
    case portrait
    case ratio3x2
    case ratio5x3
    case ratio4x3
    case ratio5x4
    case ratio7x5
    case ratio16x9

    public var id: String { rawValue }

    public var title: String {
        switch self {
        case .original: "Original"
        case .square: "Square"
        case .landscape: "Landscape (16:9)"
        case .portrait: "Portrait (9:16)"
        case .ratio3x2: "3:2"
        case .ratio5x3: "5:3"
        case .ratio4x3: "4:3"
        case .ratio5x4: "5:4"
        case .ratio7x5: "7:5"
        case .ratio16x9: "16:9"
        }
    }

    /// Menu label that reflects the active landscape/portrait orientation.
    public func menuTitle(orientation: HIGPhotoEditorAspectRatioOrientation) -> String {
        switch self {
        case .landscape, .portrait, .square, .original:
            return title
        default:
            let ratioLabel = title
            return "\(ratioLabel) \(orientation.title)"
        }
    }

    /// Width-to-height ratio in landscape orientation. `nil` preserves the source image aspect ratio.
    public var presetAspect: CGFloat? {
        switch self {
        case .original: nil
        case .square: 1
        case .landscape: 16 / 9
        case .portrait: 9 / 16
        case .ratio3x2: 3 / 2
        case .ratio5x3: 5 / 3
        case .ratio4x3: 4 / 3
        case .ratio5x4: 5 / 4
        case .ratio7x5: 7 / 5
        case .ratio16x9: 16 / 9
        }
    }

    public func resolvedAspect(
        for imageSize: CGSize,
        orientation: HIGPhotoEditorAspectRatioOrientation = .landscape
    ) -> CGFloat {
        switch self {
        case .original:
            guard imageSize.width > 0, imageSize.height > 0 else { return 1 }
            let imageAspect = imageSize.width / imageSize.height
            switch orientation {
            case .landscape:
                return max(imageAspect, 1)
            case .portrait:
                return min(imageAspect, 1)
            }
        case .square:
            return 1
        case .landscape:
            return 16 / 9
        case .portrait:
            return 9 / 16
        default:
            guard let base = presetAspect else { return 1 }
            switch orientation {
            case .landscape:
                return base >= 1 ? base : 1 / base
            case .portrait:
                return base <= 1 ? base : 1 / base
            }
        }
    }

    /// Suggested orientation when the user selects this preset.
    public var preferredOrientation: HIGPhotoEditorAspectRatioOrientation? {
        switch self {
        case .landscape: .landscape
        case .portrait: .portrait
        default: nil
        }
    }

    /// Aspect ratio reached when toggling between landscape and portrait presets.
    public var orientationToggledPreset: HIGPhotoEditorAspectRatio {
        switch self {
        case .landscape: .portrait
        case .portrait: .landscape
        default: self
        }
    }

    /// Whether the orientation toggle applies to this preset.
    public var supportsOrientationToggle: Bool {
        switch self {
        case .landscape, .portrait, .square:
            false
        default:
            true
        }
    }
}
#endif