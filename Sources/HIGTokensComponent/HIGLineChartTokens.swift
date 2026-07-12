import CoreGraphics
import SwiftUI
import HIGTokensRaw

/// Component tokens for ``HIGLineChart``.
public protocol HIGLineChartTokens: Sendable {
    var minHeight: CGFloat { get }
    var contentPadding: CGFloat { get }
    var stackSpacing: CGFloat { get }
    var cornerRadius: CGFloat { get }
    var borderWidth: CGFloat { get }
    var titleFont: Font { get }
    var emptyFont: Font { get }
    var lineWidth: CGFloat { get }
    var symbolSize: CGFloat { get }
}

/// System defaults for line charts.
public struct HIGSystemLineChartTokens: HIGLineChartTokens, Sendable {
    public let minHeight: CGFloat
    public let contentPadding: CGFloat
    public let stackSpacing: CGFloat
    public let cornerRadius: CGFloat
    public let borderWidth: CGFloat
    public let titleFont: Font
    public let emptyFont: Font
    public let lineWidth: CGFloat
    public let symbolSize: CGFloat

    public init(
        minHeight: CGFloat = 200,
        contentPadding: CGFloat = HIGSpacing.md.rawValue,
        stackSpacing: CGFloat = HIGSpacing.sm.rawValue,
        cornerRadius: CGFloat = HIGRadius.md.rawValue,
        borderWidth: CGFloat = HIGBorder.hairline.rawValue,
        titleFont: Font = .headline,
        emptyFont: Font = .body,
        lineWidth: CGFloat = 2,
        symbolSize: CGFloat = 40
    ) {
        self.minHeight = minHeight
        self.contentPadding = contentPadding
        self.stackSpacing = stackSpacing
        self.cornerRadius = cornerRadius
        self.borderWidth = borderWidth
        self.titleFont = titleFont
        self.emptyFont = emptyFont
        self.lineWidth = lineWidth
        self.symbolSize = symbolSize
    }
}
