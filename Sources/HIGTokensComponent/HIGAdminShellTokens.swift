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
    /// Fixed width for ``HIGAdminShellStyle/iconRail`` leading rail.
    var iconRailWidth: CGFloat { get }
    var iconRailItemSpacing: CGFloat { get }
    var iconRailIconPointSize: CGFloat { get }
    /// Minimum height for ``HIGAdminShellStyle/topBar`` navigation strip.
    var topBarMinHeight: CGFloat { get }
    var topBarItemSpacing: CGFloat { get }
    var topBarIconPointSize: CGFloat { get }
    /// Maximum content width for ``HIGAdminShellStyle/centered`` detail column.
    var centeredMaxWidth: CGFloat { get }
}

/// System defaults for admin application shells.
public struct HIGSystemAdminShellTokens: HIGAdminShellTokens, Sendable {
    public let contentPadding: CGFloat
    public let brandPadding: CGFloat
    public let brandFont: Font
    public let sidebarMinWidth: CGFloat
    public let sidebarIdealWidth: CGFloat
    public let sidebarMaxWidth: CGFloat
    public let iconRailWidth: CGFloat
    public let iconRailItemSpacing: CGFloat
    public let iconRailIconPointSize: CGFloat
    public let topBarMinHeight: CGFloat
    public let topBarItemSpacing: CGFloat
    public let topBarIconPointSize: CGFloat
    public let centeredMaxWidth: CGFloat

    public init(
        contentPadding: CGFloat = HIGSpacing.lg.rawValue,
        brandPadding: CGFloat = HIGSpacing.md.rawValue,
        brandFont: Font = .headline.weight(.semibold),
        sidebarMinWidth: CGFloat = 200,
        sidebarIdealWidth: CGFloat = 240,
        sidebarMaxWidth: CGFloat = 320,
        iconRailWidth: CGFloat = 72,
        iconRailItemSpacing: CGFloat = HIGSpacing.sm.rawValue,
        iconRailIconPointSize: CGFloat = 20,
        topBarMinHeight: CGFloat = 52,
        topBarItemSpacing: CGFloat = HIGSpacing.sm.rawValue,
        topBarIconPointSize: CGFloat = 17,
        centeredMaxWidth: CGFloat = 960
    ) {
        self.contentPadding = contentPadding
        self.brandPadding = brandPadding
        self.brandFont = brandFont
        self.sidebarMinWidth = sidebarMinWidth
        self.sidebarIdealWidth = sidebarIdealWidth
        self.sidebarMaxWidth = sidebarMaxWidth
        self.iconRailWidth = iconRailWidth
        self.iconRailItemSpacing = iconRailItemSpacing
        self.iconRailIconPointSize = iconRailIconPointSize
        self.topBarMinHeight = topBarMinHeight
        self.topBarItemSpacing = topBarItemSpacing
        self.topBarIconPointSize = topBarIconPointSize
        self.centeredMaxWidth = centeredMaxWidth
    }
}
