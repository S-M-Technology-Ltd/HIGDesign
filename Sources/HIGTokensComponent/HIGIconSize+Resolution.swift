import CoreGraphics

extension HIGIconSize {
    /// Resolves the base point size before Dynamic Type scaling.
    public func basePointSize(tokens: any HIGIconTokens) -> CGFloat {
        switch self {
        case .small:
            tokens.smallSize
        case .medium:
            tokens.mediumSize
        case .large:
            tokens.largeSize
        case .fixed(let pointSize):
            pointSize
        }
    }
}