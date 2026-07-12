import CoreGraphics
import SwiftUI
import HIGTokensRaw

/// Component tokens for ``HIGListGroup`` and ``HIGListGroupRow``.
public protocol HIGListGroupTokens: Sendable {
    var rowMinHeight: CGFloat { get }
    var horizontalPadding: CGFloat { get }
    var verticalPadding: CGFloat { get }
    var cornerRadius: CGFloat { get }
    var borderWidth: CGFloat { get }
    var headerFont: Font { get }
    var footerFont: Font { get }
    var titleFont: Font { get }
    var subtitleFont: Font { get }
    var headerSpacing: CGFloat { get }
    var iconSpacing: CGFloat { get }
}

/// System defaults for bordered list groups.
public struct HIGSystemListGroupTokens: HIGListGroupTokens, Sendable {
    public let rowMinHeight: CGFloat
    public let horizontalPadding: CGFloat
    public let verticalPadding: CGFloat
    public let cornerRadius: CGFloat
    public let borderWidth: CGFloat
    public let headerFont: Font
    public let footerFont: Font
    public let titleFont: Font
    public let subtitleFont: Font
    public let headerSpacing: CGFloat
    public let iconSpacing: CGFloat

    public init(
        rowMinHeight: CGFloat = 44,
        horizontalPadding: CGFloat = HIGSpacing.md.rawValue,
        verticalPadding: CGFloat = HIGSpacing.sm.rawValue,
        cornerRadius: CGFloat = HIGRadius.sm.rawValue,
        borderWidth: CGFloat = HIGBorder.hairline.rawValue,
        headerFont: Font = .caption.weight(.semibold),
        footerFont: Font = .caption,
        titleFont: Font = .body,
        subtitleFont: Font = .subheadline,
        headerSpacing: CGFloat = HIGSpacing.xs.rawValue,
        iconSpacing: CGFloat = HIGSpacing.sm.rawValue
    ) {
        self.rowMinHeight = rowMinHeight
        self.horizontalPadding = horizontalPadding
        self.verticalPadding = verticalPadding
        self.cornerRadius = cornerRadius
        self.borderWidth = borderWidth
        self.headerFont = headerFont
        self.footerFont = footerFont
        self.titleFont = titleFont
        self.subtitleFont = subtitleFont
        self.headerSpacing = headerSpacing
        self.iconSpacing = iconSpacing
    }
}
