import CoreGraphics
import HIGTokensRaw

/// Component tokens for ``HIGMenuToggle``.
public protocol HIGMenuToggleTokens: Sendable {
    var minTapTarget: CGFloat { get }
    var lineWidth: CGFloat { get }
    var lineThickness: CGFloat { get }
    var lineSpacing: CGFloat { get }
}

/// System defaults for menu toggle (hamburger) controls.
public struct HIGSystemMenuToggleTokens: HIGMenuToggleTokens, Sendable {
    public let minTapTarget: CGFloat
    public let lineWidth: CGFloat
    public let lineThickness: CGFloat
    public let lineSpacing: CGFloat

    public init(
        minTapTarget: CGFloat = HIGSpacing.massive.rawValue,
        lineWidth: CGFloat = HIGSpacing.xl.rawValue,
        lineThickness: CGFloat = HIGBorder.hairline.rawValue + HIGSpacing.xxs.rawValue / 2,
        lineSpacing: CGFloat = HIGSpacing.xs.rawValue
    ) {
        self.minTapTarget = minTapTarget
        self.lineWidth = lineWidth
        self.lineThickness = lineThickness
        self.lineSpacing = lineSpacing
    }
}
