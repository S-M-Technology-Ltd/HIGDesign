import CoreGraphics
import SwiftUI
import HIGTokensRaw

/// Component tokens for ``HIGPieChart``.
public protocol HIGPieChartTokens: Sendable {
    var minHeight: CGFloat { get }
    var contentPadding: CGFloat { get }
    var stackSpacing: CGFloat { get }
    var cornerRadius: CGFloat { get }
    var borderWidth: CGFloat { get }
    var titleFont: Font { get }
    var emptyFont: Font { get }
    /// Angular inset between sectors, in points.
    var sectorInset: CGFloat { get }
    /// Inner hole radius as a fraction of the outer radius for donut style (`0` is a solid pie).
    var donutInnerRadiusRatio: CGFloat { get }
}

/// System defaults for pie charts.
public struct HIGSystemPieChartTokens: HIGPieChartTokens, Sendable {
    public let minHeight: CGFloat
    public let contentPadding: CGFloat
    public let stackSpacing: CGFloat
    public let cornerRadius: CGFloat
    public let borderWidth: CGFloat
    public let titleFont: Font
    public let emptyFont: Font
    public let sectorInset: CGFloat
    public let donutInnerRadiusRatio: CGFloat

    public init(
        minHeight: CGFloat = 220,
        contentPadding: CGFloat = HIGSpacing.md.rawValue,
        stackSpacing: CGFloat = HIGSpacing.sm.rawValue,
        cornerRadius: CGFloat = HIGRadius.md.rawValue,
        borderWidth: CGFloat = HIGBorder.hairline.rawValue,
        titleFont: Font = .headline,
        emptyFont: Font = .body,
        sectorInset: CGFloat = 1.5,
        donutInnerRadiusRatio: CGFloat = 0.55
    ) {
        self.minHeight = minHeight
        self.contentPadding = contentPadding
        self.stackSpacing = stackSpacing
        self.cornerRadius = cornerRadius
        self.borderWidth = borderWidth
        self.titleFont = titleFont
        self.emptyFont = emptyFont
        self.sectorInset = sectorInset
        self.donutInnerRadiusRatio = donutInnerRadiusRatio
    }
}
