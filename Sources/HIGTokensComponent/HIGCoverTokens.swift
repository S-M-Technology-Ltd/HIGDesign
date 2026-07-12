import CoreGraphics
import SwiftUI
import HIGTokensRaw

/// Component tokens for ``HIGCover``.
public protocol HIGCoverTokens: Sendable {
    var minHeight: CGFloat { get }
    var contentPadding: CGFloat { get }
    var stackSpacing: CGFloat { get }
    var actionSpacing: CGFloat { get }
    var cornerRadius: CGFloat { get }
    var scrimOpacity: CGFloat { get }
    var titleFont: Font { get }
    var subtitleFont: Font { get }
}

/// System defaults for cover / banner surfaces.
public struct HIGSystemCoverTokens: HIGCoverTokens, Sendable {
    public let minHeight: CGFloat
    public let contentPadding: CGFloat
    public let stackSpacing: CGFloat
    public let actionSpacing: CGFloat
    public let cornerRadius: CGFloat
    public let scrimOpacity: CGFloat
    public let titleFont: Font
    public let subtitleFont: Font

    public init(
        minHeight: CGFloat = 180,
        contentPadding: CGFloat = HIGSpacing.lg.rawValue,
        stackSpacing: CGFloat = HIGSpacing.sm.rawValue,
        actionSpacing: CGFloat = HIGSpacing.sm.rawValue,
        cornerRadius: CGFloat = HIGRadius.lg.rawValue,
        scrimOpacity: CGFloat = HIGOpacity.pressedPrimary.rawValue,
        titleFont: Font = .title2.weight(.bold),
        subtitleFont: Font = .subheadline
    ) {
        self.minHeight = minHeight
        self.contentPadding = contentPadding
        self.stackSpacing = stackSpacing
        self.actionSpacing = actionSpacing
        self.cornerRadius = cornerRadius
        self.scrimOpacity = scrimOpacity
        self.titleFont = titleFont
        self.subtitleFont = subtitleFont
    }
}
