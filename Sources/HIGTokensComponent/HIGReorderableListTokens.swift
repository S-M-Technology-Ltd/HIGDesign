import CoreGraphics
import SwiftUI
import HIGTokensRaw

/// Component tokens for ``HIGReorderableList``.
public protocol HIGReorderableListTokens: Sendable {
    var rowMinHeight: CGFloat { get }
    var horizontalPadding: CGFloat { get }
    var iconSpacing: CGFloat { get }
    var rowIconPointSize: CGFloat { get }
    var titleFont: Font { get }
    var captionFont: Font { get }
    var captionSpacing: CGFloat { get }
    var cornerRadius: CGFloat { get }
    var borderWidth: CGFloat { get }
}

/// System defaults for reorderable admin lists.
public struct HIGSystemReorderableListTokens: HIGReorderableListTokens, Sendable {
    public let rowMinHeight: CGFloat
    public let horizontalPadding: CGFloat
    public let iconSpacing: CGFloat
    public let rowIconPointSize: CGFloat
    public let titleFont: Font
    public let captionFont: Font
    public let captionSpacing: CGFloat
    public let cornerRadius: CGFloat
    public let borderWidth: CGFloat

    public init(
        rowMinHeight: CGFloat = HIGSpacing.massive.rawValue,
        horizontalPadding: CGFloat = HIGSpacing.md.rawValue,
        iconSpacing: CGFloat = HIGSpacing.sm.rawValue,
        rowIconPointSize: CGFloat = 17,
        titleFont: Font = .body,
        captionFont: Font = .caption,
        captionSpacing: CGFloat = HIGSpacing.xs.rawValue,
        cornerRadius: CGFloat = HIGRadius.sm.rawValue,
        borderWidth: CGFloat = HIGBorder.hairline.rawValue
    ) {
        self.rowMinHeight = rowMinHeight
        self.horizontalPadding = horizontalPadding
        self.iconSpacing = iconSpacing
        self.rowIconPointSize = rowIconPointSize
        self.titleFont = titleFont
        self.captionFont = captionFont
        self.captionSpacing = captionSpacing
        self.cornerRadius = cornerRadius
        self.borderWidth = borderWidth
    }
}
