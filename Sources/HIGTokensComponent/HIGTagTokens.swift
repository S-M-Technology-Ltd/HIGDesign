import CoreGraphics
import SwiftUI
import HIGTokensRaw

public protocol HIGTagTokens: Sendable {
    var horizontalPadding: CGFloat { get }
    var verticalPadding: CGFloat { get }
    var cornerRadius: CGFloat { get }
    var font: Font { get }
}

public struct HIGSystemTagTokens: HIGTagTokens, Sendable {
    public let horizontalPadding: CGFloat
    public let verticalPadding: CGFloat
    public let cornerRadius: CGFloat
    public let font: Font

    public init(
        horizontalPadding: CGFloat = HIGSpacing.md.rawValue,
        verticalPadding: CGFloat = HIGSpacing.xs.rawValue,
        cornerRadius: CGFloat = HIGRadius.continuous.rawValue,
        font: Font = .caption.weight(.medium)
    ) {
        self.horizontalPadding = horizontalPadding
        self.verticalPadding = verticalPadding
        self.cornerRadius = cornerRadius
        self.font = font
    }
}