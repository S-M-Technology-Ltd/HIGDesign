import CoreGraphics
import SwiftUI
import HIGTokensRaw

/// Component tokens for ``HIGWidget``.
public protocol HIGWidgetTokens: Sendable {
    var contentPadding: CGFloat { get }
    var headerSpacing: CGFloat { get }
    var stackSpacing: CGFloat { get }
    var cornerRadius: CGFloat { get }
    var borderWidth: CGFloat { get }
    var minHeight: CGFloat { get }
    var titleFont: Font { get }
    var subtitleFont: Font { get }
}

/// System defaults for dashboard widgets.
public struct HIGSystemWidgetTokens: HIGWidgetTokens, Sendable {
    public let contentPadding: CGFloat
    public let headerSpacing: CGFloat
    public let stackSpacing: CGFloat
    public let cornerRadius: CGFloat
    public let borderWidth: CGFloat
    public let minHeight: CGFloat
    public let titleFont: Font
    public let subtitleFont: Font

    public init(
        contentPadding: CGFloat = HIGSpacing.md.rawValue,
        headerSpacing: CGFloat = HIGSpacing.xxs.rawValue,
        stackSpacing: CGFloat = HIGSpacing.sm.rawValue,
        cornerRadius: CGFloat = HIGRadius.md.rawValue,
        borderWidth: CGFloat = HIGBorder.hairline.rawValue,
        minHeight: CGFloat = 120,
        titleFont: Font = .headline,
        subtitleFont: Font = .subheadline
    ) {
        self.contentPadding = contentPadding
        self.headerSpacing = headerSpacing
        self.stackSpacing = stackSpacing
        self.cornerRadius = cornerRadius
        self.borderWidth = borderWidth
        self.minHeight = minHeight
        self.titleFont = titleFont
        self.subtitleFont = subtitleFont
    }
}
