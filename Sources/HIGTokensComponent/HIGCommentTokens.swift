import CoreGraphics
import SwiftUI
import HIGTokensRaw

/// Component tokens for ``HIGComment``.
public protocol HIGCommentTokens: Sendable {
    var contentPaddingVertical: CGFloat { get }
    var stackSpacing: CGFloat { get }
    var metaSpacing: CGFloat { get }
    var avatarSpacing: CGFloat { get }
    var separatorWidth: CGFloat { get }
    var authorFont: Font { get }
    var timestampFont: Font { get }
    var bodyFont: Font { get }
    var actionFont: Font { get }
}

/// System defaults for threaded comment rows.
public struct HIGSystemCommentTokens: HIGCommentTokens, Sendable {
    public let contentPaddingVertical: CGFloat
    public let stackSpacing: CGFloat
    public let metaSpacing: CGFloat
    public let avatarSpacing: CGFloat
    public let separatorWidth: CGFloat
    public let authorFont: Font
    public let timestampFont: Font
    public let bodyFont: Font
    public let actionFont: Font

    public init(
        contentPaddingVertical: CGFloat = HIGSpacing.md.rawValue,
        stackSpacing: CGFloat = HIGSpacing.xs.rawValue,
        metaSpacing: CGFloat = HIGSpacing.sm.rawValue,
        avatarSpacing: CGFloat = HIGSpacing.md.rawValue,
        separatorWidth: CGFloat = HIGBorder.hairline.rawValue,
        authorFont: Font = .subheadline.weight(.semibold),
        timestampFont: Font = .caption,
        bodyFont: Font = .body,
        actionFont: Font = .subheadline.weight(.medium)
    ) {
        self.contentPaddingVertical = contentPaddingVertical
        self.stackSpacing = stackSpacing
        self.metaSpacing = metaSpacing
        self.avatarSpacing = avatarSpacing
        self.separatorWidth = separatorWidth
        self.authorFont = authorFont
        self.timestampFont = timestampFont
        self.bodyFont = bodyFont
        self.actionFont = actionFont
    }
}
