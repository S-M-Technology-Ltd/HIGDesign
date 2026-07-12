import CoreGraphics
import SwiftUI
import HIGTokensRaw

/// Component tokens for ``HIGMediaRow``.
public protocol HIGMediaRowTokens: Sendable {
    var minHeight: CGFloat { get }
    var horizontalPadding: CGFloat { get }
    var verticalPadding: CGFloat { get }
    var spacing: CGFloat { get }
    var titleFont: Font { get }
    var subtitleFont: Font { get }
    var cornerRadius: CGFloat { get }
    var borderWidth: CGFloat { get }
}

/// System defaults for media object rows.
public struct HIGSystemMediaRowTokens: HIGMediaRowTokens, Sendable {
    public let minHeight: CGFloat
    public let horizontalPadding: CGFloat
    public let verticalPadding: CGFloat
    public let spacing: CGFloat
    public let titleFont: Font
    public let subtitleFont: Font
    public let cornerRadius: CGFloat
    public let borderWidth: CGFloat

    public init(
        minHeight: CGFloat = 56,
        horizontalPadding: CGFloat = HIGSpacing.md.rawValue,
        verticalPadding: CGFloat = HIGSpacing.sm.rawValue,
        spacing: CGFloat = HIGSpacing.md.rawValue,
        titleFont: Font = .body.weight(.semibold),
        subtitleFont: Font = .subheadline,
        cornerRadius: CGFloat = HIGRadius.sm.rawValue,
        borderWidth: CGFloat = HIGBorder.hairline.rawValue
    ) {
        self.minHeight = minHeight
        self.horizontalPadding = horizontalPadding
        self.verticalPadding = verticalPadding
        self.spacing = spacing
        self.titleFont = titleFont
        self.subtitleFont = subtitleFont
        self.cornerRadius = cornerRadius
        self.borderWidth = borderWidth
    }
}
