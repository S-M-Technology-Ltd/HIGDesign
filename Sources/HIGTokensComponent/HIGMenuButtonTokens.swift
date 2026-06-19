import CoreGraphics
import SwiftUI
import HIGTokensRaw

public protocol HIGMenuButtonTokens: Sendable {
    var minHeight: CGFloat { get }
    var horizontalPadding: CGFloat { get }
    var cornerRadius: CGFloat { get }
    var font: Font { get }
}

public struct HIGSystemMenuButtonTokens: HIGMenuButtonTokens, Sendable {
    public let minHeight: CGFloat
    public let horizontalPadding: CGFloat
    public let cornerRadius: CGFloat
    public let font: Font

    public init(
        minHeight: CGFloat = 44,
        horizontalPadding: CGFloat = HIGSpacing.md.rawValue,
        cornerRadius: CGFloat = HIGRadius.md.rawValue,
        font: Font = .body.weight(.semibold)
    ) {
        self.minHeight = minHeight
        self.horizontalPadding = horizontalPadding
        self.cornerRadius = cornerRadius
        self.font = font
    }
}