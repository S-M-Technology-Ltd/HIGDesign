import CoreGraphics
import SwiftUI

public protocol HIGStepperTokens: Sendable {
    var minHeight: CGFloat { get }
    var font: Font { get }
}

public struct HIGSystemStepperTokens: HIGStepperTokens, Sendable {
    public let minHeight: CGFloat
    public let font: Font

    public init(minHeight: CGFloat = 44, font: Font = .body) {
        self.minHeight = minHeight
        self.font = font
    }
}