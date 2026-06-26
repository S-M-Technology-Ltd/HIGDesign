import CoreGraphics

/// Relative size for icon components.
public enum HIGIconSize: Sendable {
    case small
    case medium
    case large
    /// A custom base point size scaled with Dynamic Type like token sizes.
    case fixed(CGFloat)
}