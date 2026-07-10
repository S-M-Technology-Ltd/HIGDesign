import CoreGraphics
import SwiftUI
import HIGTokensRaw

/// Component tokens for ``HIGPopoverContainer`` and ``View/higPopover(isPresented:attachmentAnchor:arrowEdge:content:)``.
public protocol HIGPopoverTokens: Sendable {
    var contentPadding: CGFloat { get }
    var cornerRadius: CGFloat { get }
    var borderWidth: CGFloat { get }
    var maxWidth: CGFloat { get }
}

/// System defaults for popover chrome.
public struct HIGSystemPopoverTokens: HIGPopoverTokens, Sendable {
    public let contentPadding: CGFloat
    public let cornerRadius: CGFloat
    public let borderWidth: CGFloat
    public let maxWidth: CGFloat

    public init(
        contentPadding: CGFloat = HIGSpacing.md.rawValue,
        cornerRadius: CGFloat = HIGRadius.md.rawValue,
        borderWidth: CGFloat = HIGBorder.hairline.rawValue,
        maxWidth: CGFloat = 320
    ) {
        self.contentPadding = contentPadding
        self.cornerRadius = cornerRadius
        self.borderWidth = borderWidth
        self.maxWidth = maxWidth
    }
}
