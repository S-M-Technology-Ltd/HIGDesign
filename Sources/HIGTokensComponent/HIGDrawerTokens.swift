import CoreGraphics
import SwiftUI
import HIGTokensRaw

/// Component tokens for ``HIGDrawer`` slide panels.
public protocol HIGDrawerTokens: Sendable {
    var width: CGFloat { get }
    var contentPadding: CGFloat { get }
    var headerSpacing: CGFloat { get }
    var borderWidth: CGFloat { get }
    var cornerRadius: CGFloat { get }
    var scrimOpacity: CGFloat { get }
    var titleFont: Font { get }
}

/// System defaults for drawer panels.
public struct HIGSystemDrawerTokens: HIGDrawerTokens, Sendable {
    public let width: CGFloat
    public let contentPadding: CGFloat
    public let headerSpacing: CGFloat
    public let borderWidth: CGFloat
    public let cornerRadius: CGFloat
    public let scrimOpacity: CGFloat
    public let titleFont: Font

    public init(
        width: CGFloat = 320,
        contentPadding: CGFloat = HIGSpacing.lg.rawValue,
        headerSpacing: CGFloat = HIGSpacing.sm.rawValue,
        borderWidth: CGFloat = HIGBorder.hairline.rawValue,
        cornerRadius: CGFloat = HIGRadius.md.rawValue,
        scrimOpacity: CGFloat = HIGOpacity.bannerBorder.rawValue,
        titleFont: Font = .headline
    ) {
        self.width = width
        self.contentPadding = contentPadding
        self.headerSpacing = headerSpacing
        self.borderWidth = borderWidth
        self.cornerRadius = cornerRadius
        self.scrimOpacity = scrimOpacity
        self.titleFont = titleFont
    }
}
