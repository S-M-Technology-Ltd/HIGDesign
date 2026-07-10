import CoreGraphics
import SwiftUI
import HIGTokensRaw

/// Component tokens for ``HIGTooltipLabel`` and ``View/higTooltip(_:)``.
public protocol HIGTooltipTokens: Sendable {
    var font: Font { get }
    var horizontalPadding: CGFloat { get }
    var verticalPadding: CGFloat { get }
    var cornerRadius: CGFloat { get }
    var maxWidth: CGFloat { get }
}

/// System defaults for tooltip labels.
public struct HIGSystemTooltipTokens: HIGTooltipTokens, Sendable {
    public let font: Font
    public let horizontalPadding: CGFloat
    public let verticalPadding: CGFloat
    public let cornerRadius: CGFloat
    public let maxWidth: CGFloat

    public init(
        font: Font = .caption,
        horizontalPadding: CGFloat = HIGSpacing.sm.rawValue,
        verticalPadding: CGFloat = HIGSpacing.xs.rawValue,
        cornerRadius: CGFloat = HIGRadius.sm.rawValue,
        maxWidth: CGFloat = 240
    ) {
        self.font = font
        self.horizontalPadding = horizontalPadding
        self.verticalPadding = verticalPadding
        self.cornerRadius = cornerRadius
        self.maxWidth = maxWidth
    }
}
