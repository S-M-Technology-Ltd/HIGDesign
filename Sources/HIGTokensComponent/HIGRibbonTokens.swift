import CoreGraphics
import SwiftUI
import HIGTokensRaw

/// Component tokens for ``HIGRibbon``.
public protocol HIGRibbonTokens: Sendable {
    var horizontalPadding: CGFloat { get }
    var verticalPadding: CGFloat { get }
    var font: Font { get }
    var cornerRadius: CGFloat { get }
    var edgeInset: CGFloat { get }
}

/// System defaults for corner ribbon labels.
public struct HIGSystemRibbonTokens: HIGRibbonTokens, Sendable {
    public let horizontalPadding: CGFloat
    public let verticalPadding: CGFloat
    public let font: Font
    public let cornerRadius: CGFloat
    public let edgeInset: CGFloat

    public init(
        horizontalPadding: CGFloat = HIGSpacing.sm.rawValue,
        verticalPadding: CGFloat = HIGSpacing.xxs.rawValue,
        font: Font = .caption2.weight(.bold),
        cornerRadius: CGFloat = HIGRadius.sm.rawValue,
        edgeInset: CGFloat = HIGSpacing.sm.rawValue
    ) {
        self.horizontalPadding = horizontalPadding
        self.verticalPadding = verticalPadding
        self.font = font
        self.cornerRadius = cornerRadius
        self.edgeInset = edgeInset
    }
}
