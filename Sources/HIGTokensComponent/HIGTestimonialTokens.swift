import CoreGraphics
import SwiftUI
import HIGTokensRaw

/// Component tokens for ``HIGTestimonial``.
public protocol HIGTestimonialTokens: Sendable {
    var contentPadding: CGFloat { get }
    var stackSpacing: CGFloat { get }
    var authorSpacing: CGFloat { get }
    var cornerRadius: CGFloat { get }
    var borderWidth: CGFloat { get }
    var quoteFont: Font { get }
    var authorFont: Font { get }
    var roleFont: Font { get }
}

/// System defaults for testimonial cards.
public struct HIGSystemTestimonialTokens: HIGTestimonialTokens, Sendable {
    public let contentPadding: CGFloat
    public let stackSpacing: CGFloat
    public let authorSpacing: CGFloat
    public let cornerRadius: CGFloat
    public let borderWidth: CGFloat
    public let quoteFont: Font
    public let authorFont: Font
    public let roleFont: Font

    public init(
        contentPadding: CGFloat = HIGSpacing.md.rawValue,
        stackSpacing: CGFloat = HIGSpacing.sm.rawValue,
        authorSpacing: CGFloat = HIGSpacing.xs.rawValue,
        cornerRadius: CGFloat = HIGRadius.md.rawValue,
        borderWidth: CGFloat = HIGBorder.hairline.rawValue,
        quoteFont: Font = .body,
        authorFont: Font = .subheadline.weight(.semibold),
        roleFont: Font = .caption
    ) {
        self.contentPadding = contentPadding
        self.stackSpacing = stackSpacing
        self.authorSpacing = authorSpacing
        self.cornerRadius = cornerRadius
        self.borderWidth = borderWidth
        self.quoteFont = quoteFont
        self.authorFont = authorFont
        self.roleFont = roleFont
    }
}
