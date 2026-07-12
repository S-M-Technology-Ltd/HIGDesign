import CoreGraphics
import SwiftUI
import HIGTokensRaw

/// Component tokens for ``HIGChatBubble``.
public protocol HIGChatBubbleTokens: Sendable {
    var contentPaddingHorizontal: CGFloat { get }
    var contentPaddingVertical: CGFloat { get }
    var stackSpacing: CGFloat { get }
    var metaSpacing: CGFloat { get }
    var cornerRadius: CGFloat { get }
    var sideGutter: CGFloat { get }
    var messageFont: Font { get }
    var authorFont: Font { get }
    var timestampFont: Font { get }
}

/// System defaults for chat message bubbles.
public struct HIGSystemChatBubbleTokens: HIGChatBubbleTokens, Sendable {
    public let contentPaddingHorizontal: CGFloat
    public let contentPaddingVertical: CGFloat
    public let stackSpacing: CGFloat
    public let metaSpacing: CGFloat
    public let cornerRadius: CGFloat
    public let sideGutter: CGFloat
    public let messageFont: Font
    public let authorFont: Font
    public let timestampFont: Font

    public init(
        contentPaddingHorizontal: CGFloat = HIGSpacing.md.rawValue,
        contentPaddingVertical: CGFloat = HIGSpacing.sm.rawValue,
        stackSpacing: CGFloat = HIGSpacing.sm.rawValue,
        metaSpacing: CGFloat = HIGSpacing.xxs.rawValue,
        cornerRadius: CGFloat = HIGRadius.lg.rawValue,
        sideGutter: CGFloat = HIGSpacing.massive.rawValue * 2,
        messageFont: Font = .body,
        authorFont: Font = .caption.weight(.semibold),
        timestampFont: Font = .caption2
    ) {
        self.contentPaddingHorizontal = contentPaddingHorizontal
        self.contentPaddingVertical = contentPaddingVertical
        self.stackSpacing = stackSpacing
        self.metaSpacing = metaSpacing
        self.cornerRadius = cornerRadius
        self.sideGutter = sideGutter
        self.messageFont = messageFont
        self.authorFont = authorFont
        self.timestampFont = timestampFont
    }
}
