import CoreGraphics
import SwiftUI
import HIGTokensRaw

public protocol HIGToggleTokens: Sendable {
    var minHeight: CGFloat { get }
    var labelSpacing: CGFloat { get }
    var font: Font { get }
}

public struct HIGSystemToggleTokens: HIGToggleTokens, Sendable {
    public let minHeight: CGFloat
    public let labelSpacing: CGFloat
    public let font: Font

    public init(
        minHeight: CGFloat = 44,
        labelSpacing: CGFloat = HIGSpacing.sm.rawValue,
        font: Font = .body
    ) {
        self.minHeight = minHeight
        self.labelSpacing = labelSpacing
        self.font = font
    }
}