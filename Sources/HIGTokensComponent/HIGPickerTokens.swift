import CoreGraphics
import SwiftUI
import HIGTokensRaw

public protocol HIGPickerTokens: Sendable {
    var minHeight: CGFloat { get }
    var font: Font { get }
}

public struct HIGSystemPickerTokens: HIGPickerTokens, Sendable {
    public let minHeight: CGFloat
    public let font: Font

    public init(minHeight: CGFloat = 44, font: Font = .body) {
        self.minHeight = minHeight
        self.font = font
    }
}