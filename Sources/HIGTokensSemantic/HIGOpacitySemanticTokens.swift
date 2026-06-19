import CoreGraphics
import HIGTokensRaw

public protocol HIGOpacitySemanticTokens: Sendable {
    var hidden: CGFloat { get }
    var subtleFill: CGFloat { get }
    var bannerBorder: CGFloat { get }
    var disabled: CGFloat { get }
    var pressedPrimary: CGFloat { get }
    var pressedSecondary: CGFloat { get }
    var labelOnAccentSecondary: CGFloat { get }
    var full: CGFloat { get }
}

public struct HIGSystemOpacitySemanticTokens: HIGOpacitySemanticTokens, Sendable {
    public let hidden: CGFloat
    public let subtleFill: CGFloat
    public let bannerBorder: CGFloat
    public let disabled: CGFloat
    public let pressedPrimary: CGFloat
    public let pressedSecondary: CGFloat
    public let labelOnAccentSecondary: CGFloat
    public let full: CGFloat

    public init(
        hidden: CGFloat = HIGOpacity.hidden.rawValue,
        subtleFill: CGFloat = HIGOpacity.subtleFill.rawValue,
        bannerBorder: CGFloat = HIGOpacity.bannerBorder.rawValue,
        disabled: CGFloat = HIGOpacity.disabled.rawValue,
        pressedPrimary: CGFloat = HIGOpacity.pressedPrimary.rawValue,
        pressedSecondary: CGFloat = HIGOpacity.pressedSecondary.rawValue,
        labelOnAccentSecondary: CGFloat = HIGOpacity.pressedSecondary.rawValue,
        full: CGFloat = HIGOpacity.full.rawValue
    ) {
        self.hidden = hidden
        self.subtleFill = subtleFill
        self.bannerBorder = bannerBorder
        self.disabled = disabled
        self.pressedPrimary = pressedPrimary
        self.pressedSecondary = pressedSecondary
        self.labelOnAccentSecondary = labelOnAccentSecondary
        self.full = full
    }
}