import CoreGraphics
import SwiftUI
import HIGTokensRaw

/// Component tokens for ``HIGColorSelector``.
public protocol HIGColorSelectorTokens: Sendable {
    var swatchSize: CGFloat { get }
    var swatchSpacing: CGFloat { get }
    var selectionRingWidth: CGFloat { get }
    var selectionRingInset: CGFloat { get }
    var minTapTarget: CGFloat { get }
    var checkmarkPointSize: CGFloat { get }
    var labelFont: Font { get }
    var labelSpacing: CGFloat { get }
}

/// System defaults for color swatch selectors.
public struct HIGSystemColorSelectorTokens: HIGColorSelectorTokens, Sendable {
    public let swatchSize: CGFloat
    public let swatchSpacing: CGFloat
    public let selectionRingWidth: CGFloat
    public let selectionRingInset: CGFloat
    public let minTapTarget: CGFloat
    public let checkmarkPointSize: CGFloat
    public let labelFont: Font
    public let labelSpacing: CGFloat

    public init(
        swatchSize: CGFloat = HIGSpacing.xxl.rawValue,
        swatchSpacing: CGFloat = HIGSpacing.sm.rawValue,
        selectionRingWidth: CGFloat = 2,
        selectionRingInset: CGFloat = HIGSpacing.xxs.rawValue,
        minTapTarget: CGFloat = HIGSpacing.massive.rawValue,
        checkmarkPointSize: CGFloat = 12,
        labelFont: Font = .caption,
        labelSpacing: CGFloat = HIGSpacing.xs.rawValue
    ) {
        self.swatchSize = swatchSize
        self.swatchSpacing = swatchSpacing
        self.selectionRingWidth = selectionRingWidth
        self.selectionRingInset = selectionRingInset
        self.minTapTarget = minTapTarget
        self.checkmarkPointSize = checkmarkPointSize
        self.labelFont = labelFont
        self.labelSpacing = labelSpacing
    }
}
