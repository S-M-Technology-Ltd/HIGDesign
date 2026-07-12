import CoreGraphics
import SwiftUI
import HIGTokensRaw

/// Component tokens for ``HIGCounter``.
public protocol HIGCounterTokens: Sendable {
    var contentPadding: CGFloat { get }
    var stackSpacing: CGFloat { get }
    var cornerRadius: CGFloat { get }
    var borderWidth: CGFloat { get }
    var minHeight: CGFloat { get }
    var iconPointSize: CGFloat { get }
    var titleFont: Font { get }
    var valueFont: Font { get }
    var captionFont: Font { get }
    var trendFont: Font { get }
}

/// System defaults for metric counters.
public struct HIGSystemCounterTokens: HIGCounterTokens, Sendable {
    public let contentPadding: CGFloat
    public let stackSpacing: CGFloat
    public let cornerRadius: CGFloat
    public let borderWidth: CGFloat
    public let minHeight: CGFloat
    public let iconPointSize: CGFloat
    public let titleFont: Font
    public let valueFont: Font
    public let captionFont: Font
    public let trendFont: Font

    public init(
        contentPadding: CGFloat = HIGSpacing.md.rawValue,
        stackSpacing: CGFloat = HIGSpacing.xs.rawValue,
        cornerRadius: CGFloat = HIGRadius.md.rawValue,
        borderWidth: CGFloat = HIGBorder.hairline.rawValue,
        minHeight: CGFloat = 96,
        iconPointSize: CGFloat = 20,
        titleFont: Font = .subheadline,
        valueFont: Font = .largeTitle.weight(.semibold),
        captionFont: Font = .caption,
        trendFont: Font = .caption.weight(.semibold)
    ) {
        self.contentPadding = contentPadding
        self.stackSpacing = stackSpacing
        self.cornerRadius = cornerRadius
        self.borderWidth = borderWidth
        self.minHeight = minHeight
        self.iconPointSize = iconPointSize
        self.titleFont = titleFont
        self.valueFont = valueFont
        self.captionFont = captionFont
        self.trendFont = trendFont
    }
}
