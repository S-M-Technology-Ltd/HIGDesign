import CoreGraphics
import SwiftUI
import HIGTokensRaw

/// Component tokens for ``HIGRating``.
public protocol HIGRatingTokens: Sendable {
    var starPointSize: CGFloat { get }
    var starSpacing: CGFloat { get }
    var minTapTarget: CGFloat { get }
    var labelFont: Font { get }
    var labelSpacing: CGFloat { get }
}

/// System defaults for star ratings.
public struct HIGSystemRatingTokens: HIGRatingTokens, Sendable {
    public let starPointSize: CGFloat
    public let starSpacing: CGFloat
    public let minTapTarget: CGFloat
    public let labelFont: Font
    public let labelSpacing: CGFloat

    public init(
        starPointSize: CGFloat = 22,
        starSpacing: CGFloat = HIGSpacing.xs.rawValue,
        minTapTarget: CGFloat = HIGSpacing.massive.rawValue,
        labelFont: Font = .subheadline,
        labelSpacing: CGFloat = HIGSpacing.sm.rawValue
    ) {
        self.starPointSize = starPointSize
        self.starSpacing = starSpacing
        self.minTapTarget = minTapTarget
        self.labelFont = labelFont
        self.labelSpacing = labelSpacing
    }
}
