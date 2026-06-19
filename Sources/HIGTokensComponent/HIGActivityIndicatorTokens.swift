import CoreGraphics
import SwiftUI

public protocol HIGActivityIndicatorTokens: Sendable {
    var smallScale: CGFloat { get }
    var mediumScale: CGFloat { get }
    var largeScale: CGFloat { get }
    var customDiameter: CGFloat { get }
    var orbitalLineWidth: CGFloat { get }
    var pulsingSegmentCount: Int { get }
    var pulsingDimmedOpacity: CGFloat { get }
}

public struct HIGSystemActivityIndicatorTokens: HIGActivityIndicatorTokens, Sendable {
    public let smallScale: CGFloat
    public let mediumScale: CGFloat
    public let largeScale: CGFloat
    public let customDiameter: CGFloat
    public let orbitalLineWidth: CGFloat
    public let pulsingSegmentCount: Int
    public let pulsingDimmedOpacity: CGFloat

    public init(
        smallScale: CGFloat = 0.85,
        mediumScale: CGFloat = 1,
        largeScale: CGFloat = 1.25,
        customDiameter: CGFloat = 36,
        orbitalLineWidth: CGFloat = 3,
        pulsingSegmentCount: Int = 8,
        pulsingDimmedOpacity: CGFloat = 0.3
    ) {
        self.smallScale = smallScale
        self.mediumScale = mediumScale
        self.largeScale = largeScale
        self.customDiameter = customDiameter
        self.orbitalLineWidth = orbitalLineWidth
        self.pulsingSegmentCount = pulsingSegmentCount
        self.pulsingDimmedOpacity = pulsingDimmedOpacity
    }
}