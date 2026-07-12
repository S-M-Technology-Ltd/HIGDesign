import CoreGraphics
import SwiftUI
import HIGTokensRaw

/// Component tokens for ``HIGCarousel``.
public protocol HIGCarouselTokens: Sendable {
    var minHeight: CGFloat { get }
    var cornerRadius: CGFloat { get }
    var borderWidth: CGFloat { get }
    var indicatorSize: CGFloat { get }
    var indicatorSpacing: CGFloat { get }
    var contentPadding: CGFloat { get }
    var stackSpacing: CGFloat { get }
}

/// System defaults for paged carousels.
public struct HIGSystemCarouselTokens: HIGCarouselTokens, Sendable {
    public let minHeight: CGFloat
    public let cornerRadius: CGFloat
    public let borderWidth: CGFloat
    public let indicatorSize: CGFloat
    public let indicatorSpacing: CGFloat
    public let contentPadding: CGFloat
    public let stackSpacing: CGFloat

    public init(
        minHeight: CGFloat = 180,
        cornerRadius: CGFloat = HIGRadius.md.rawValue,
        borderWidth: CGFloat = HIGBorder.hairline.rawValue,
        indicatorSize: CGFloat = 8,
        indicatorSpacing: CGFloat = HIGSpacing.sm.rawValue,
        contentPadding: CGFloat = HIGSpacing.lg.rawValue,
        stackSpacing: CGFloat = HIGSpacing.sm.rawValue
    ) {
        self.minHeight = minHeight
        self.cornerRadius = cornerRadius
        self.borderWidth = borderWidth
        self.indicatorSize = indicatorSize
        self.indicatorSpacing = indicatorSpacing
        self.contentPadding = contentPadding
        self.stackSpacing = stackSpacing
    }
}
