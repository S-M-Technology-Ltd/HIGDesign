import CoreGraphics
import SwiftUI
import HIGTokensRaw

public protocol HIGCheckboxTokens: Sendable {
    var minHeight: CGFloat { get }
    var font: Font { get }
}

public struct HIGSystemCheckboxTokens: HIGCheckboxTokens, Sendable {
    public let minHeight: CGFloat
    public let font: Font

    public init(minHeight: CGFloat = 44, font: Font = .body) {
        self.minHeight = minHeight
        self.font = font
    }
}