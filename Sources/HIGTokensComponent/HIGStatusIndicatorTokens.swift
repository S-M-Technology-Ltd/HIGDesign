import CoreGraphics
import HIGTokensRaw

/// Component tokens for ``HIGStatusIndicator``.
public protocol HIGStatusIndicatorTokens: Sendable {
    var diameter: CGFloat { get }
    var borderWidth: CGFloat { get }
    var avatarBadgeDiameter: CGFloat { get }
}

/// System defaults for presence status dots.
public struct HIGSystemStatusIndicatorTokens: HIGStatusIndicatorTokens, Sendable {
    public let diameter: CGFloat
    public let borderWidth: CGFloat
    public let avatarBadgeDiameter: CGFloat

    public init(
        diameter: CGFloat = HIGSpacing.md.rawValue,
        borderWidth: CGFloat = HIGBorder.hairline.rawValue + HIGSpacing.xxs.rawValue / 2,
        avatarBadgeDiameter: CGFloat = HIGSpacing.sm.rawValue + HIGSpacing.xxs.rawValue
    ) {
        self.diameter = diameter
        self.borderWidth = borderWidth
        self.avatarBadgeDiameter = avatarBadgeDiameter
    }
}
