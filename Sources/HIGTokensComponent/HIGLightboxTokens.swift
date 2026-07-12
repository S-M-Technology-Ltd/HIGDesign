import CoreGraphics
import SwiftUI
import HIGTokensRaw

/// Component tokens for ``HIGLightbox``.
public protocol HIGLightboxTokens: Sendable {
    var contentPadding: CGFloat { get }
    var stackSpacing: CGFloat { get }
    var chromeSpacing: CGFloat { get }
    var cornerRadius: CGFloat { get }
    var borderWidth: CGFloat { get }
    var minMediaHeight: CGFloat { get }
    var controlSize: CGFloat { get }
    var indicatorSize: CGFloat { get }
    var indicatorSpacing: CGFloat { get }
    var titleFont: Font { get }
    var counterFont: Font { get }
    var emptyFont: Font { get }
}

/// System defaults for lightbox chrome.
public struct HIGSystemLightboxTokens: HIGLightboxTokens, Sendable {
    public let contentPadding: CGFloat
    public let stackSpacing: CGFloat
    public let chromeSpacing: CGFloat
    public let cornerRadius: CGFloat
    public let borderWidth: CGFloat
    public let minMediaHeight: CGFloat
    public let controlSize: CGFloat
    public let indicatorSize: CGFloat
    public let indicatorSpacing: CGFloat
    public let titleFont: Font
    public let counterFont: Font
    public let emptyFont: Font

    public init(
        contentPadding: CGFloat = HIGSpacing.md.rawValue,
        stackSpacing: CGFloat = HIGSpacing.md.rawValue,
        chromeSpacing: CGFloat = HIGSpacing.sm.rawValue,
        cornerRadius: CGFloat = HIGRadius.md.rawValue,
        borderWidth: CGFloat = HIGBorder.hairline.rawValue,
        minMediaHeight: CGFloat = 240,
        controlSize: CGFloat = 44,
        indicatorSize: CGFloat = 8,
        indicatorSpacing: CGFloat = HIGSpacing.sm.rawValue,
        titleFont: Font = .headline,
        counterFont: Font = .subheadline,
        emptyFont: Font = .body
    ) {
        self.contentPadding = contentPadding
        self.stackSpacing = stackSpacing
        self.chromeSpacing = chromeSpacing
        self.cornerRadius = cornerRadius
        self.borderWidth = borderWidth
        self.minMediaHeight = minMediaHeight
        self.controlSize = controlSize
        self.indicatorSize = indicatorSize
        self.indicatorSpacing = indicatorSpacing
        self.titleFont = titleFont
        self.counterFont = counterFont
        self.emptyFont = emptyFont
    }
}
