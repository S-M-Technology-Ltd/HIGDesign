import CoreGraphics
import SwiftUI
import HIGTokensRaw

public protocol HIGBadgeTokens: Sendable {
    var horizontalPadding: CGFloat { get }
    var verticalPadding: CGFloat { get }
    var cornerRadius: CGFloat { get }
    var font: Font { get }
}

public struct HIGSystemBadgeTokens: HIGBadgeTokens, Sendable {
    public let horizontalPadding: CGFloat
    public let verticalPadding: CGFloat
    public let cornerRadius: CGFloat
    public let font: Font

    public init(
        horizontalPadding: CGFloat = HIGSpacing.sm.rawValue,
        verticalPadding: CGFloat = HIGSpacing.xs.rawValue,
        cornerRadius: CGFloat = HIGRadius.sm.rawValue,
        font: Font = .caption.weight(.semibold)
    ) {
        self.horizontalPadding = horizontalPadding
        self.verticalPadding = verticalPadding
        self.cornerRadius = cornerRadius
        self.font = font
    }
}