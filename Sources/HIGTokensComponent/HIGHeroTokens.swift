import CoreGraphics
import SwiftUI
import HIGTokensRaw

/// Component tokens for ``HIGHero``.
public protocol HIGHeroTokens: Sendable {
    var minHeight: CGFloat { get }
    var contentPadding: CGFloat { get }
    var stackSpacing: CGFloat { get }
    var actionSpacing: CGFloat { get }
    var cornerRadius: CGFloat { get }
    var borderWidth: CGFloat { get }
    var titleFont: Font { get }
    var subtitleFont: Font { get }
}

/// System defaults for hero / jumbotron surfaces.
public struct HIGSystemHeroTokens: HIGHeroTokens, Sendable {
    public let minHeight: CGFloat
    public let contentPadding: CGFloat
    public let stackSpacing: CGFloat
    public let actionSpacing: CGFloat
    public let cornerRadius: CGFloat
    public let borderWidth: CGFloat
    public let titleFont: Font
    public let subtitleFont: Font

    public init(
        minHeight: CGFloat = 160,
        contentPadding: CGFloat = HIGSpacing.xxl.rawValue,
        stackSpacing: CGFloat = HIGSpacing.md.rawValue,
        actionSpacing: CGFloat = HIGSpacing.sm.rawValue,
        cornerRadius: CGFloat = HIGRadius.lg.rawValue,
        borderWidth: CGFloat = HIGBorder.hairline.rawValue,
        titleFont: Font = .largeTitle.weight(.bold),
        subtitleFont: Font = .title3
    ) {
        self.minHeight = minHeight
        self.contentPadding = contentPadding
        self.stackSpacing = stackSpacing
        self.actionSpacing = actionSpacing
        self.cornerRadius = cornerRadius
        self.borderWidth = borderWidth
        self.titleFont = titleFont
        self.subtitleFont = subtitleFont
    }
}
