import CoreGraphics
import SwiftUI
import HIGTokensRaw

public protocol HIGTextEditorTokens: Sendable {
    var minHeight: CGFloat { get }
    var horizontalPadding: CGFloat { get }
    var verticalPadding: CGFloat { get }
    var cornerRadius: CGFloat { get }
    var borderWidth: CGFloat { get }
    var font: Font { get }
}

public struct HIGSystemTextEditorTokens: HIGTextEditorTokens, Sendable {
    public let minHeight: CGFloat
    public let horizontalPadding: CGFloat
    public let verticalPadding: CGFloat
    public let cornerRadius: CGFloat
    public let borderWidth: CGFloat
    public let font: Font

    public init(
        minHeight: CGFloat = 120,
        horizontalPadding: CGFloat = HIGSpacing.md.rawValue,
        verticalPadding: CGFloat = HIGSpacing.sm.rawValue,
        cornerRadius: CGFloat = HIGRadius.sm.rawValue,
        borderWidth: CGFloat = 1,
        font: Font = .body
    ) {
        self.minHeight = minHeight
        self.horizontalPadding = horizontalPadding
        self.verticalPadding = verticalPadding
        self.cornerRadius = cornerRadius
        self.borderWidth = borderWidth
        self.font = font
    }
}