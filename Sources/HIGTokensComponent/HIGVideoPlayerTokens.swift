import CoreGraphics
import SwiftUI
import HIGTokensRaw

/// Component tokens for ``HIGVideoPlayer``.
public protocol HIGVideoPlayerTokens: Sendable {
    var minHeight: CGFloat { get }
    var contentPadding: CGFloat { get }
    var stackSpacing: CGFloat { get }
    var cornerRadius: CGFloat { get }
    var borderWidth: CGFloat { get }
    var titleFont: Font { get }
    var captionFont: Font { get }
    var placeholderIconPointSize: CGFloat { get }
}

/// System defaults for themed video players.
public struct HIGSystemVideoPlayerTokens: HIGVideoPlayerTokens, Sendable {
    public let minHeight: CGFloat
    public let contentPadding: CGFloat
    public let stackSpacing: CGFloat
    public let cornerRadius: CGFloat
    public let borderWidth: CGFloat
    public let titleFont: Font
    public let captionFont: Font
    public let placeholderIconPointSize: CGFloat

    public init(
        minHeight: CGFloat = 200,
        contentPadding: CGFloat = HIGSpacing.md.rawValue,
        stackSpacing: CGFloat = HIGSpacing.sm.rawValue,
        cornerRadius: CGFloat = HIGRadius.md.rawValue,
        borderWidth: CGFloat = HIGBorder.hairline.rawValue,
        titleFont: Font = .headline,
        captionFont: Font = .caption,
        placeholderIconPointSize: CGFloat = 36
    ) {
        self.minHeight = minHeight
        self.contentPadding = contentPadding
        self.stackSpacing = stackSpacing
        self.cornerRadius = cornerRadius
        self.borderWidth = borderWidth
        self.titleFont = titleFont
        self.captionFont = captionFont
        self.placeholderIconPointSize = placeholderIconPointSize
    }
}
