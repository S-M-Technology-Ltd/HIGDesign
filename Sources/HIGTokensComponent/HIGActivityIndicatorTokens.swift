import CoreGraphics
import SwiftUI

public protocol HIGActivityIndicatorTokens: Sendable {
    var smallScale: CGFloat { get }
    var mediumScale: CGFloat { get }
    var largeScale: CGFloat { get }
}

public struct HIGSystemActivityIndicatorTokens: HIGActivityIndicatorTokens, Sendable {
    public let smallScale: CGFloat
    public let mediumScale: CGFloat
    public let largeScale: CGFloat

    public init(
        smallScale: CGFloat = 0.85,
        mediumScale: CGFloat = 1,
        largeScale: CGFloat = 1.25
    ) {
        self.smallScale = smallScale
        self.mediumScale = mediumScale
        self.largeScale = largeScale
    }
}