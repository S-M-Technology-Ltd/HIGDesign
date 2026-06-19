import CoreGraphics
import SwiftUI
import HIGTokensRaw

public protocol HIGToastTokens: Sendable {
    var cornerRadius: CGFloat { get }
    var horizontalPadding: CGFloat { get }
    var verticalPadding: CGFloat { get }
    var font: Font { get }
    var dismissButtonSize: CGFloat { get }
}

public struct HIGSystemToastTokens: HIGToastTokens, Sendable {
    public let cornerRadius: CGFloat
    public let horizontalPadding: CGFloat
    public let verticalPadding: CGFloat
    public let font: Font
    public let dismissButtonSize: CGFloat

    public init(
        cornerRadius: CGFloat = HIGRadius.lg.rawValue,
        horizontalPadding: CGFloat = HIGSpacing.lg.rawValue,
        verticalPadding: CGFloat = HIGSpacing.md.rawValue,
        font: Font = .callout,
        dismissButtonSize: CGFloat = 24
    ) {
        self.cornerRadius = cornerRadius
        self.horizontalPadding = horizontalPadding
        self.verticalPadding = verticalPadding
        self.font = font
        self.dismissButtonSize = dismissButtonSize
    }
}