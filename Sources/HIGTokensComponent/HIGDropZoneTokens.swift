import CoreGraphics
import SwiftUI
import HIGTokensRaw

/// Component tokens for ``HIGDropZone``.
public protocol HIGDropZoneTokens: Sendable {
    var minHeight: CGFloat { get }
    var cornerRadius: CGFloat { get }
    var borderWidth: CGFloat { get }
    var dashLength: CGFloat { get }
    var dashGap: CGFloat { get }
    var contentPadding: CGFloat { get }
    var stackSpacing: CGFloat { get }
    var iconPointSize: CGFloat { get }
    var titleFont: Font { get }
    var messageFont: Font { get }
    var fileRowMinHeight: CGFloat { get }
}

/// System defaults for file drop and browse surfaces.
public struct HIGSystemDropZoneTokens: HIGDropZoneTokens, Sendable {
    public let minHeight: CGFloat
    public let cornerRadius: CGFloat
    public let borderWidth: CGFloat
    public let dashLength: CGFloat
    public let dashGap: CGFloat
    public let contentPadding: CGFloat
    public let stackSpacing: CGFloat
    public let iconPointSize: CGFloat
    public let titleFont: Font
    public let messageFont: Font
    public let fileRowMinHeight: CGFloat

    public init(
        minHeight: CGFloat = 160,
        cornerRadius: CGFloat = HIGRadius.md.rawValue,
        borderWidth: CGFloat = HIGBorder.hairline.rawValue,
        dashLength: CGFloat = HIGSpacing.sm.rawValue,
        dashGap: CGFloat = HIGSpacing.xs.rawValue,
        contentPadding: CGFloat = HIGSpacing.lg.rawValue,
        stackSpacing: CGFloat = HIGSpacing.sm.rawValue,
        iconPointSize: CGFloat = HIGSpacing.xxxl.rawValue,
        titleFont: Font = .headline,
        messageFont: Font = .subheadline,
        fileRowMinHeight: CGFloat = 44
    ) {
        self.minHeight = minHeight
        self.cornerRadius = cornerRadius
        self.borderWidth = borderWidth
        self.dashLength = dashLength
        self.dashGap = dashGap
        self.contentPadding = contentPadding
        self.stackSpacing = stackSpacing
        self.iconPointSize = iconPointSize
        self.titleFont = titleFont
        self.messageFont = messageFont
        self.fileRowMinHeight = fileRowMinHeight
    }
}
