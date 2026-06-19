import CoreGraphics
import SwiftUI

public protocol HIGProgressTokens: Sendable {
    var trackHeight: CGFloat { get }
    var labelFont: Font { get }
}

public struct HIGSystemProgressTokens: HIGProgressTokens, Sendable {
    public let trackHeight: CGFloat
    public let labelFont: Font

    public init(
        trackHeight: CGFloat = 4,
        labelFont: Font = .caption
    ) {
        self.trackHeight = trackHeight
        self.labelFont = labelFont
    }
}