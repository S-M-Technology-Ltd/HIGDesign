import CoreGraphics
import HIGTokensRaw

/// Component tokens for ``HIGNetworkProgressBar``.
public protocol HIGNetworkProgressBarTokens: Sendable {
    var height: CGFloat { get }
    var cornerRadius: CGFloat { get }
    /// Width fraction of the indeterminate sweeping band (0...1).
    var indeterminateBandFraction: CGFloat { get }
}

/// System defaults for the thin top network progress bar.
public struct HIGSystemNetworkProgressBarTokens: HIGNetworkProgressBarTokens, Sendable {
    public let height: CGFloat
    public let cornerRadius: CGFloat
    public let indeterminateBandFraction: CGFloat

    public init(
        height: CGFloat = HIGSpacing.xxs.rawValue,
        cornerRadius: CGFloat = HIGRadius.sm.rawValue,
        indeterminateBandFraction: CGFloat = 0.3
    ) {
        self.height = height
        self.cornerRadius = cornerRadius
        self.indeterminateBandFraction = indeterminateBandFraction
    }
}
