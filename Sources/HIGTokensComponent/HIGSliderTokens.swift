import CoreGraphics
import SwiftUI
import HIGTokensRaw

public protocol HIGSliderTokens: Sendable {
    var minHeight: CGFloat { get }
    var trackHeight: CGFloat { get }
    var font: Font { get }
}

public struct HIGSystemSliderTokens: HIGSliderTokens, Sendable {
    public let minHeight: CGFloat
    public let trackHeight: CGFloat
    public let font: Font

    public init(
        minHeight: CGFloat = 44,
        trackHeight: CGFloat = 4,
        font: Font = .body
    ) {
        self.minHeight = minHeight
        self.trackHeight = trackHeight
        self.font = font
    }
}