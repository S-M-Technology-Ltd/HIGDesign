import CoreGraphics
import SwiftUI
import HIGTokensRaw

public protocol HIGRadioTokens: Sendable {
    var minHeight: CGFloat { get }
    var optionSpacing: CGFloat { get }
    var font: Font { get }
}

public struct HIGSystemRadioTokens: HIGRadioTokens, Sendable {
    public let minHeight: CGFloat
    public let optionSpacing: CGFloat
    public let font: Font

    public init(
        minHeight: CGFloat = 44,
        optionSpacing: CGFloat = HIGSpacing.sm.rawValue,
        font: Font = .body
    ) {
        self.minHeight = minHeight
        self.optionSpacing = optionSpacing
        self.font = font
    }
}