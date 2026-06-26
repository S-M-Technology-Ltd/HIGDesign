import CoreGraphics
import SwiftUI

public protocol HIGIconTokens: Sendable {
    /// Base small icon size before Dynamic Type scaling.
    var smallSize: CGFloat { get }
    /// Base medium icon size before Dynamic Type scaling.
    var mediumSize: CGFloat { get }
    /// Base large icon size before Dynamic Type scaling.
    var largeSize: CGFloat { get }
}

public struct HIGSystemIconTokens: HIGIconTokens, Sendable {
    public let smallSize: CGFloat
    public let mediumSize: CGFloat
    public let largeSize: CGFloat

    public init(smallSize: CGFloat = 16, mediumSize: CGFloat = 20, largeSize: CGFloat = 28) {
        self.smallSize = smallSize
        self.mediumSize = mediumSize
        self.largeSize = largeSize
    }
}