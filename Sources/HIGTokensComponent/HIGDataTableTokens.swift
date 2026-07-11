import CoreGraphics
import SwiftUI
import HIGTokensRaw

/// Component tokens for ``HIGDataTable``.
public protocol HIGDataTableTokens: Sendable {
    var headerFont: Font { get }
    var cellFont: Font { get }
    var horizontalPadding: CGFloat { get }
    var verticalPadding: CGFloat { get }
    var minRowHeight: CGFloat { get }
    var borderWidth: CGFloat { get }
    var cornerRadius: CGFloat { get }
    var columnSpacing: CGFloat { get }
    var minColumnWidth: CGFloat { get }
}

/// System defaults for admin-style data tables.
public struct HIGSystemDataTableTokens: HIGDataTableTokens, Sendable {
    public let headerFont: Font
    public let cellFont: Font
    public let horizontalPadding: CGFloat
    public let verticalPadding: CGFloat
    public let minRowHeight: CGFloat
    public let borderWidth: CGFloat
    public let cornerRadius: CGFloat
    public let columnSpacing: CGFloat
    public let minColumnWidth: CGFloat

    public init(
        headerFont: Font = .subheadline.weight(.semibold),
        cellFont: Font = .body,
        horizontalPadding: CGFloat = HIGSpacing.md.rawValue,
        verticalPadding: CGFloat = HIGSpacing.sm.rawValue,
        minRowHeight: CGFloat = 44,
        borderWidth: CGFloat = HIGBorder.hairline.rawValue,
        cornerRadius: CGFloat = HIGRadius.sm.rawValue,
        columnSpacing: CGFloat = HIGSpacing.lg.rawValue,
        minColumnWidth: CGFloat = 88
    ) {
        self.headerFont = headerFont
        self.cellFont = cellFont
        self.horizontalPadding = horizontalPadding
        self.verticalPadding = verticalPadding
        self.minRowHeight = minRowHeight
        self.borderWidth = borderWidth
        self.cornerRadius = cornerRadius
        self.columnSpacing = columnSpacing
        self.minColumnWidth = minColumnWidth
    }
}
