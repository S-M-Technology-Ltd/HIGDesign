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
    var arcsCount: Int { get }
    var arcsSweepDegrees: CGFloat { get }
    var arcsRotationSpeed: Double { get }
    var rotatingDotsCount: Int { get }
    var flickeringDotsCount: Int { get }
    var scalingDotsCount: Int { get }
    var scalingDotsInset: CGFloat { get }
    var scalingDotsMinScale: CGFloat { get }
    var opacityDotsCount: Int { get }
    var opacityDotsInset: CGFloat { get }
    var opacityDotsMinScale: CGFloat { get }
    var opacityDotsMinOpacity: CGFloat { get }
    var equalizerBarCount: Int { get }
    var equalizerBarCornerRadius: CGFloat { get }
    var equalizerMinScale: CGFloat { get }
    var growingCircleFadeOpacity: CGFloat { get }
    var gradientTrimLeading: CGFloat { get }
    var gradientTrimTrailing: CGFloat { get }
}

public struct HIGSystemActivityIndicatorTokens: HIGActivityIndicatorTokens, Sendable {
    public let smallScale: CGFloat
    public let mediumScale: CGFloat
    public let largeScale: CGFloat
    public let customDiameter: CGFloat
    public let orbitalLineWidth: CGFloat
    public let pulsingSegmentCount: Int
    public let pulsingDimmedOpacity: CGFloat
    public let arcsCount: Int
    public let arcsSweepDegrees: CGFloat
    public let arcsRotationSpeed: Double
    public let rotatingDotsCount: Int
    public let flickeringDotsCount: Int
    public let scalingDotsCount: Int
    public let scalingDotsInset: CGFloat
    public let scalingDotsMinScale: CGFloat
    public let opacityDotsCount: Int
    public let opacityDotsInset: CGFloat
    public let opacityDotsMinScale: CGFloat
    public let opacityDotsMinOpacity: CGFloat
    public let equalizerBarCount: Int
    public let equalizerBarCornerRadius: CGFloat
    public let equalizerMinScale: CGFloat
    public let growingCircleFadeOpacity: CGFloat
    public let gradientTrimLeading: CGFloat
    public let gradientTrimTrailing: CGFloat

    public init(
        smallScale: CGFloat = 0.85,
        mediumScale: CGFloat = 1,
        largeScale: CGFloat = 1.25,
        customDiameter: CGFloat = 36,
        orbitalLineWidth: CGFloat = 3,
        pulsingSegmentCount: Int = 8,
        pulsingDimmedOpacity: CGFloat = 0.3,
        arcsCount: Int = 3,
        arcsSweepDegrees: CGFloat = 180,
        arcsRotationSpeed: Double = 0.35,
        rotatingDotsCount: Int = 5,
        flickeringDotsCount: Int = 8,
        scalingDotsCount: Int = 3,
        scalingDotsInset: CGFloat = 2,
        scalingDotsMinScale: CGFloat = 0.3,
        opacityDotsCount: Int = 3,
        opacityDotsInset: CGFloat = 4,
        opacityDotsMinScale: CGFloat = 0.9,
        opacityDotsMinOpacity: CGFloat = 0.3,
        equalizerBarCount: Int = 5,
        equalizerBarCornerRadius: CGFloat = 3,
        equalizerMinScale: CGFloat = 0.4,
        growingCircleFadeOpacity: CGFloat = 0,
        gradientTrimLeading: CGFloat = 0.006,
        gradientTrimTrailing: CGFloat = 0.01
    ) {
        self.smallScale = smallScale
        self.mediumScale = mediumScale
        self.largeScale = largeScale
        self.customDiameter = customDiameter
        self.orbitalLineWidth = orbitalLineWidth
        self.pulsingSegmentCount = pulsingSegmentCount
        self.pulsingDimmedOpacity = pulsingDimmedOpacity
        self.arcsCount = arcsCount
        self.arcsSweepDegrees = arcsSweepDegrees
        self.arcsRotationSpeed = arcsRotationSpeed
        self.rotatingDotsCount = rotatingDotsCount
        self.flickeringDotsCount = flickeringDotsCount
        self.scalingDotsCount = scalingDotsCount
        self.scalingDotsInset = scalingDotsInset
        self.scalingDotsMinScale = scalingDotsMinScale
        self.opacityDotsCount = opacityDotsCount
        self.opacityDotsInset = opacityDotsInset
        self.opacityDotsMinScale = opacityDotsMinScale
        self.opacityDotsMinOpacity = opacityDotsMinOpacity
        self.equalizerBarCount = equalizerBarCount
        self.equalizerBarCornerRadius = equalizerBarCornerRadius
        self.equalizerMinScale = equalizerMinScale
        self.growingCircleFadeOpacity = growingCircleFadeOpacity
        self.gradientTrimLeading = gradientTrimLeading
        self.gradientTrimTrailing = gradientTrimTrailing
    }
}