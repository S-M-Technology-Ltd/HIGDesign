import CoreGraphics

public enum HIGButtonSize: Sendable, CaseIterable {
    case small
    case medium
    case large

    var scale: CGFloat {
        switch self {
        case .small: 0.85
        case .medium: 1
        case .large: 1.15
        }
    }
}