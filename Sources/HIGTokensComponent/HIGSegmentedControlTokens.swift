import CoreGraphics
import SwiftUI
import HIGTokensRaw

public protocol HIGSegmentedControlTokens: Sendable {
    var minHeight: CGFloat { get }
    var cornerRadius: CGFloat { get }
    var font: Font { get }
}

public struct HIGSystemSegmentedControlTokens: HIGSegmentedControlTokens, Sendable {
    public let minHeight: CGFloat
    public let cornerRadius: CGFloat
    public let font: Font

    public init(
        minHeight: CGFloat = 44,
        cornerRadius: CGFloat = HIGRadius.sm.rawValue,
        font: Font = .body
    ) {
        self.minHeight = minHeight
        self.cornerRadius = cornerRadius
        self.font = font
    }
}