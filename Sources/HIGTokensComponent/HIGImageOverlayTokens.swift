import CoreGraphics
import SwiftUI
import HIGTokensRaw

/// Component tokens for ``HIGImageOverlay``.
public protocol HIGImageOverlayTokens: Sendable {
    var panelPadding: CGFloat { get }
    var stackSpacing: CGFloat { get }
    var cornerRadius: CGFloat { get }
    var minHeight: CGFloat { get }
    var scrimOpacity: CGFloat { get }
    var titleFont: Font { get }
    var subtitleFont: Font { get }
}

/// System defaults for media image overlays.
public struct HIGSystemImageOverlayTokens: HIGImageOverlayTokens, Sendable {
    public let panelPadding: CGFloat
    public let stackSpacing: CGFloat
    public let cornerRadius: CGFloat
    public let minHeight: CGFloat
    public let scrimOpacity: CGFloat
    public let titleFont: Font
    public let subtitleFont: Font

    public init(
        panelPadding: CGFloat = HIGSpacing.md.rawValue,
        stackSpacing: CGFloat = HIGSpacing.xxs.rawValue,
        cornerRadius: CGFloat = HIGRadius.md.rawValue,
        minHeight: CGFloat = 160,
        scrimOpacity: CGFloat = HIGOpacity.pressedPrimary.rawValue,
        titleFont: Font = .headline,
        subtitleFont: Font = .subheadline
    ) {
        self.panelPadding = panelPadding
        self.stackSpacing = stackSpacing
        self.cornerRadius = cornerRadius
        self.minHeight = minHeight
        self.scrimOpacity = scrimOpacity
        self.titleFont = titleFont
        self.subtitleFont = subtitleFont
    }
}
