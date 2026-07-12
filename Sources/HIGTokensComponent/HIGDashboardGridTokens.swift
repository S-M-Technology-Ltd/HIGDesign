import CoreGraphics
import SwiftUI
import HIGTokensRaw

/// Component tokens for ``HIGDashboardGrid``.
public protocol HIGDashboardGridTokens: Sendable {
    var minColumnWidth: CGFloat { get }
    var columnSpacing: CGFloat { get }
    var rowSpacing: CGFloat { get }
    var titleSpacing: CGFloat { get }
    var titleFont: Font { get }
}

/// System defaults for adaptive dashboard grids.
public struct HIGSystemDashboardGridTokens: HIGDashboardGridTokens, Sendable {
    public let minColumnWidth: CGFloat
    public let columnSpacing: CGFloat
    public let rowSpacing: CGFloat
    public let titleSpacing: CGFloat
    public let titleFont: Font

    public init(
        minColumnWidth: CGFloat = 160,
        columnSpacing: CGFloat = HIGSpacing.md.rawValue,
        rowSpacing: CGFloat = HIGSpacing.md.rawValue,
        titleSpacing: CGFloat = HIGSpacing.sm.rawValue,
        titleFont: Font = .title3.weight(.semibold)
    ) {
        self.minColumnWidth = minColumnWidth
        self.columnSpacing = columnSpacing
        self.rowSpacing = rowSpacing
        self.titleSpacing = titleSpacing
        self.titleFont = titleFont
    }
}
