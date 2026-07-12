import CoreGraphics
import SwiftUI
import HIGTokensRaw

/// Component tokens for ``HIGCalendar``.
public protocol HIGCalendarTokens: Sendable {
    var contentPadding: CGFloat { get }
    var headerSpacing: CGFloat { get }
    var gridSpacing: CGFloat { get }
    var dayMinSize: CGFloat { get }
    var markSize: CGFloat { get }
    var cornerRadius: CGFloat { get }
    var borderWidth: CGFloat { get }
    var headerFont: Font { get }
    var weekdayFont: Font { get }
    var dayFont: Font { get }
    var chevronPointSize: CGFloat { get }
}

/// System defaults for month calendar grids.
public struct HIGSystemCalendarTokens: HIGCalendarTokens, Sendable {
    public let contentPadding: CGFloat
    public let headerSpacing: CGFloat
    public let gridSpacing: CGFloat
    public let dayMinSize: CGFloat
    public let markSize: CGFloat
    public let cornerRadius: CGFloat
    public let borderWidth: CGFloat
    public let headerFont: Font
    public let weekdayFont: Font
    public let dayFont: Font
    public let chevronPointSize: CGFloat

    public init(
        contentPadding: CGFloat = HIGSpacing.md.rawValue,
        headerSpacing: CGFloat = HIGSpacing.sm.rawValue,
        gridSpacing: CGFloat = HIGSpacing.xxs.rawValue,
        dayMinSize: CGFloat = HIGSpacing.xxl.rawValue + HIGSpacing.xxs.rawValue,
        markSize: CGFloat = 5,
        cornerRadius: CGFloat = HIGRadius.md.rawValue,
        borderWidth: CGFloat = HIGBorder.hairline.rawValue,
        headerFont: Font = .headline,
        weekdayFont: Font = .caption.weight(.semibold),
        dayFont: Font = .body,
        chevronPointSize: CGFloat = 14
    ) {
        self.contentPadding = contentPadding
        self.headerSpacing = headerSpacing
        self.gridSpacing = gridSpacing
        self.dayMinSize = dayMinSize
        self.markSize = markSize
        self.cornerRadius = cornerRadius
        self.borderWidth = borderWidth
        self.headerFont = headerFont
        self.weekdayFont = weekdayFont
        self.dayFont = dayFont
        self.chevronPointSize = chevronPointSize
    }
}
