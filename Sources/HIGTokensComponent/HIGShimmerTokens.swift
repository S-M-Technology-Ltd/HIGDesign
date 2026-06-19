import CoreGraphics
import Foundation

public protocol HIGShimmerTokens: Sendable {
    var bandSize: CGFloat { get }
    var highlightOpacity: CGFloat { get }
    var baseOpacity: CGFloat { get }
    var animationDuration: TimeInterval { get }
    var animationDelay: TimeInterval { get }
}

public struct HIGSystemShimmerTokens: HIGShimmerTokens, Sendable {
    public let bandSize: CGFloat
    public let highlightOpacity: CGFloat
    public let baseOpacity: CGFloat
    public let animationDuration: TimeInterval
    public let animationDelay: TimeInterval

    public init(
        bandSize: CGFloat = 0.3,
        highlightOpacity: CGFloat = 1,
        baseOpacity: CGFloat = 0.3,
        animationDuration: TimeInterval = 1.5,
        animationDelay: TimeInterval = 0.25
    ) {
        self.bandSize = bandSize
        self.highlightOpacity = highlightOpacity
        self.baseOpacity = baseOpacity
        self.animationDuration = animationDuration
        self.animationDelay = animationDelay
    }
}