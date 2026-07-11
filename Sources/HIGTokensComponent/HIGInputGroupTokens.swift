import CoreGraphics
import SwiftUI
import HIGTokensRaw

/// Component tokens for ``HIGInputGroup``.
public protocol HIGInputGroupTokens: Sendable {
    var minHeight: CGFloat { get }
    var horizontalPadding: CGFloat { get }
    var cornerRadius: CGFloat { get }
    var borderWidth: CGFloat { get }
    var adornmentSpacing: CGFloat { get }
    var font: Font { get }
}

/// System defaults for input groups with leading/trailing adornments.
public struct HIGSystemInputGroupTokens: HIGInputGroupTokens, Sendable {
    public let minHeight: CGFloat
    public let horizontalPadding: CGFloat
    public let cornerRadius: CGFloat
    public let borderWidth: CGFloat
    public let adornmentSpacing: CGFloat
    public let font: Font

    public init(
        minHeight: CGFloat = 44,
        horizontalPadding: CGFloat = HIGSpacing.md.rawValue,
        cornerRadius: CGFloat = HIGRadius.sm.rawValue,
        borderWidth: CGFloat = HIGBorder.hairline.rawValue,
        adornmentSpacing: CGFloat = HIGSpacing.sm.rawValue,
        font: Font = .body
    ) {
        self.minHeight = minHeight
        self.horizontalPadding = horizontalPadding
        self.cornerRadius = cornerRadius
        self.borderWidth = borderWidth
        self.adornmentSpacing = adornmentSpacing
        self.font = font
    }
}
