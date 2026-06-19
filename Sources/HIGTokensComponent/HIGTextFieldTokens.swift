import CoreGraphics
import SwiftUI
import HIGTokensRaw

public protocol HIGTextFieldTokens: Sendable {
    var minHeight: CGFloat { get }
    var horizontalPadding: CGFloat { get }
    var cornerRadius: CGFloat { get }
    var borderWidth: CGFloat { get }
    var font: Font { get }
}

public struct HIGSystemTextFieldTokens: HIGTextFieldTokens, Sendable {
    public let minHeight: CGFloat
    public let horizontalPadding: CGFloat
    public let cornerRadius: CGFloat
    public let borderWidth: CGFloat
    public let font: Font

    public init(
        minHeight: CGFloat = 44,
        horizontalPadding: CGFloat = HIGSpacing.md.rawValue,
        cornerRadius: CGFloat = HIGRadius.sm.rawValue,
        borderWidth: CGFloat = 1,
        font: Font = .body
    ) {
        self.minHeight = minHeight
        self.horizontalPadding = horizontalPadding
        self.cornerRadius = cornerRadius
        self.borderWidth = borderWidth
        self.font = font
    }
}