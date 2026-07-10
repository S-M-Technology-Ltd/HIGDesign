import CoreGraphics
import SwiftUI
import HIGTokensRaw

/// Component tokens for ``HIGModal`` surfaces.
public protocol HIGModalTokens: Sendable {
    var cornerRadius: CGFloat { get }
    var contentPadding: CGFloat { get }
    var headerSpacing: CGFloat { get }
    var borderWidth: CGFloat { get }
    var maxWidth: CGFloat { get }
    var titleFont: Font { get }
    var messageFont: Font { get }
}

/// System defaults for modal chrome.
public struct HIGSystemModalTokens: HIGModalTokens, Sendable {
    public let cornerRadius: CGFloat
    public let contentPadding: CGFloat
    public let headerSpacing: CGFloat
    public let borderWidth: CGFloat
    public let maxWidth: CGFloat
    public let titleFont: Font
    public let messageFont: Font

    public init(
        cornerRadius: CGFloat = HIGRadius.lg.rawValue,
        contentPadding: CGFloat = HIGSpacing.lg.rawValue,
        headerSpacing: CGFloat = HIGSpacing.sm.rawValue,
        borderWidth: CGFloat = HIGBorder.hairline.rawValue,
        maxWidth: CGFloat = 420,
        titleFont: Font = .title3.weight(.semibold),
        messageFont: Font = .body
    ) {
        self.cornerRadius = cornerRadius
        self.contentPadding = contentPadding
        self.headerSpacing = headerSpacing
        self.borderWidth = borderWidth
        self.maxWidth = maxWidth
        self.titleFont = titleFont
        self.messageFont = messageFont
    }
}
