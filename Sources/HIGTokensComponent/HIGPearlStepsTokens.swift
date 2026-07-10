import CoreGraphics
import HIGTokensRaw

/// Component tokens for ``HIGPearlSteps`` dot indicators.
public protocol HIGPearlStepsTokens: Sendable {
    var pearlSize: CGFloat { get }
    var currentPearlSize: CGFloat { get }
    var connectorThickness: CGFloat { get }
    var itemSpacing: CGFloat { get }
    var minTapTarget: CGFloat { get }
}

/// System defaults for pearl/dot step indicators.
public struct HIGSystemPearlStepsTokens: HIGPearlStepsTokens, Sendable {
    public let pearlSize: CGFloat
    public let currentPearlSize: CGFloat
    public let connectorThickness: CGFloat
    public let itemSpacing: CGFloat
    public let minTapTarget: CGFloat

    public init(
        pearlSize: CGFloat = HIGSpacing.md.rawValue,
        currentPearlSize: CGFloat = HIGSpacing.lg.rawValue,
        connectorThickness: CGFloat = HIGBorder.hairline.rawValue + HIGSpacing.xxs.rawValue / 2,
        itemSpacing: CGFloat = HIGSpacing.sm.rawValue,
        minTapTarget: CGFloat = HIGSpacing.massive.rawValue
    ) {
        self.pearlSize = pearlSize
        self.currentPearlSize = currentPearlSize
        self.connectorThickness = connectorThickness
        self.itemSpacing = itemSpacing
        self.minTapTarget = minTapTarget
    }
}
