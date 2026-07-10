import CoreGraphics
import SwiftUI
import HIGTokensRaw

/// Component tokens for ``HIGSteps`` process indicators.
public protocol HIGStepsTokens: Sendable {
    var titleFont: Font { get }
    var detailFont: Font { get }
    var indexFont: Font { get }
    var indicatorSize: CGFloat { get }
    var connectorThickness: CGFloat { get }
    var itemSpacing: CGFloat { get }
    var labelSpacing: CGFloat { get }
    var minTapTarget: CGFloat { get }
}

/// System defaults for process steps.
public struct HIGSystemStepsTokens: HIGStepsTokens, Sendable {
    public let titleFont: Font
    public let detailFont: Font
    public let indexFont: Font
    public let indicatorSize: CGFloat
    public let connectorThickness: CGFloat
    public let itemSpacing: CGFloat
    public let labelSpacing: CGFloat
    public let minTapTarget: CGFloat

    public init(
        titleFont: Font = .subheadline.weight(.semibold),
        detailFont: Font = .caption,
        indexFont: Font = .caption.weight(.bold),
        indicatorSize: CGFloat = HIGSpacing.xxl.rawValue,
        connectorThickness: CGFloat = HIGBorder.hairline.rawValue + HIGSpacing.xxs.rawValue / 2,
        itemSpacing: CGFloat = HIGSpacing.sm.rawValue,
        labelSpacing: CGFloat = HIGSpacing.xs.rawValue,
        minTapTarget: CGFloat = HIGSpacing.massive.rawValue
    ) {
        self.titleFont = titleFont
        self.detailFont = detailFont
        self.indexFont = indexFont
        self.indicatorSize = indicatorSize
        self.connectorThickness = connectorThickness
        self.itemSpacing = itemSpacing
        self.labelSpacing = labelSpacing
        self.minTapTarget = minTapTarget
    }
}
