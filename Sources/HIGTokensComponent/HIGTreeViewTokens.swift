import CoreGraphics
import SwiftUI
import HIGTokensRaw

/// Component tokens for ``HIGTreeView``.
public protocol HIGTreeViewTokens: Sendable {
    var rowMinHeight: CGFloat { get }
    var indentWidth: CGFloat { get }
    var horizontalPadding: CGFloat { get }
    var iconSpacing: CGFloat { get }
    var chevronPointSize: CGFloat { get }
    var rowIconPointSize: CGFloat { get }
    var titleFont: Font { get }
    var cornerRadius: CGFloat { get }
    var borderWidth: CGFloat { get }
}

/// System defaults for hierarchical tree navigation.
public struct HIGSystemTreeViewTokens: HIGTreeViewTokens, Sendable {
    public let rowMinHeight: CGFloat
    public let indentWidth: CGFloat
    public let horizontalPadding: CGFloat
    public let iconSpacing: CGFloat
    public let chevronPointSize: CGFloat
    public let rowIconPointSize: CGFloat
    public let titleFont: Font
    public let cornerRadius: CGFloat
    public let borderWidth: CGFloat

    public init(
        rowMinHeight: CGFloat = HIGSpacing.massive.rawValue,
        indentWidth: CGFloat = HIGSpacing.lg.rawValue,
        horizontalPadding: CGFloat = HIGSpacing.sm.rawValue,
        iconSpacing: CGFloat = HIGSpacing.xs.rawValue,
        chevronPointSize: CGFloat = 12,
        rowIconPointSize: CGFloat = 16,
        titleFont: Font = .body,
        cornerRadius: CGFloat = HIGRadius.sm.rawValue,
        borderWidth: CGFloat = HIGBorder.hairline.rawValue
    ) {
        self.rowMinHeight = rowMinHeight
        self.indentWidth = indentWidth
        self.horizontalPadding = horizontalPadding
        self.iconSpacing = iconSpacing
        self.chevronPointSize = chevronPointSize
        self.rowIconPointSize = rowIconPointSize
        self.titleFont = titleFont
        self.cornerRadius = cornerRadius
        self.borderWidth = borderWidth
    }
}
