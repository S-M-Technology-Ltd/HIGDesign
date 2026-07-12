import CoreGraphics
import SwiftUI
import HIGTokensRaw

/// Component tokens for ``HIGAdminShell``.
public protocol HIGAdminShellTokens: Sendable {
    var contentPadding: CGFloat { get }
    var brandPadding: CGFloat { get }
    var brandFont: Font { get }
    var sidebarMinWidth: CGFloat { get }
    var sidebarIdealWidth: CGFloat { get }
    var sidebarMaxWidth: CGFloat { get }
}

/// System defaults for admin application shells.
public struct HIGSystemAdminShellTokens: HIGAdminShellTokens, Sendable {
    public let contentPadding: CGFloat
    public let brandPadding: CGFloat
    public let brandFont: Font
    public let sidebarMinWidth: CGFloat
    public let sidebarIdealWidth: CGFloat
    public let sidebarMaxWidth: CGFloat

    public init(
        contentPadding: CGFloat = HIGSpacing.lg.rawValue,
        brandPadding: CGFloat = HIGSpacing.md.rawValue,
        brandFont: Font = .headline.weight(.semibold),
        sidebarMinWidth: CGFloat = 200,
        sidebarIdealWidth: CGFloat = 240,
        sidebarMaxWidth: CGFloat = 320
    ) {
        self.contentPadding = contentPadding
        self.brandPadding = brandPadding
        self.brandFont = brandFont
        self.sidebarMinWidth = sidebarMinWidth
        self.sidebarIdealWidth = sidebarIdealWidth
        self.sidebarMaxWidth = sidebarMaxWidth
    }
}
