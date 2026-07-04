#if os(iOS)
import CoreGraphics
import Foundation

/// Aspect ratio presets inspired by ``TOCropViewController`` portrait presets.
public enum HIGPhotoEditorAspectRatio: String, Sendable, Equatable, CaseIterable, Identifiable {
    case original
    case square
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
        case .ratio3x2: "3:2"
        case .ratio5x3: "5:3"
        case .ratio4x3: "4:3"
        case .ratio5x4: "5:4"
        case .ratio7x5: "7:5"
        case .ratio16x9: "16:9"
        }
    }

    /// Width-to-height ratio. `nil` preserves the source image aspect ratio.
    public var presetAspect: CGFloat? {
        switch self {
        case .original: nil
        case .square: 1
        case .ratio3x2: 3 / 2
        case .ratio5x3: 5 / 3
        case .ratio4x3: 4 / 3
        case .ratio5x4: 5 / 4
        case .ratio7x5: 7 / 5
        case .ratio16x9: 16 / 9
        }
    }

    public func resolvedAspect(for imageSize: CGSize) -> CGFloat {
        if let presetAspect {
            return presetAspect
        }
        guard imageSize.width > 0, imageSize.height > 0 else { return 1 }
        return imageSize.width / imageSize.height
    }
}
#endif