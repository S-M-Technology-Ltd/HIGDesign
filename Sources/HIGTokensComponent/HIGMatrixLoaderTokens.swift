import CoreGraphics
import Foundation

/// Component tokens for ``HIGMatrixLoader`` dot-grid loading indicators.
public protocol HIGMatrixLoaderTokens: Sendable {
    /// Number of rows and columns in the square grid.
    var gridCount: Int { get }
    /// Outer diameter for ``HIGMatrixLoaderSize/small``.
    var smallDiameter: CGFloat { get }
    /// Outer diameter for ``HIGMatrixLoaderSize/medium``.
    var mediumDiameter: CGFloat { get }
    /// Outer diameter for ``HIGMatrixLoaderSize/large``.
    var largeDiameter: CGFloat { get }
    /// Gap between adjacent dots, as a fraction of cell size (`0…1`).
    var gapFraction: CGFloat { get }
    /// Idle / dimmed cell opacity.
    var baseOpacity: Double { get }
    /// Peak lit cell opacity.
    var peakOpacity: Double { get }
    /// Multiplier applied to theme motion duration for one animation cycle.
    var cycleDurationMultiplier: Double { get }
}

/// System defaults for matrix loader metrics.
public struct HIGSystemMatrixLoaderTokens: HIGMatrixLoaderTokens, Sendable {
    public let gridCount: Int
    public let smallDiameter: CGFloat
    public let mediumDiameter: CGFloat
    public let largeDiameter: CGFloat
    public let gapFraction: CGFloat
    public let baseOpacity: Double
    public let peakOpacity: Double
    public let cycleDurationMultiplier: Double

    public init(
        gridCount: Int = 5,
        smallDiameter: CGFloat = 20,
        mediumDiameter: CGFloat = 28,
        largeDiameter: CGFloat = 36,
        gapFraction: CGFloat = 0.28,
        baseOpacity: Double = 0.18,
        peakOpacity: Double = 1,
        cycleDurationMultiplier: Double = 1.4
    ) {
        self.gridCount = max(3, gridCount)
        self.smallDiameter = smallDiameter
        self.mediumDiameter = mediumDiameter
        self.largeDiameter = largeDiameter
        self.gapFraction = min(max(gapFraction, 0.05), 0.6)
        self.baseOpacity = min(max(baseOpacity, 0), 1)
        self.peakOpacity = min(max(peakOpacity, 0), 1)
        self.cycleDurationMultiplier = max(cycleDurationMultiplier, 0.25)
    }
}
