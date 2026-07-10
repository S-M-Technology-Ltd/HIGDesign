import CoreGraphics
import SwiftUI
import HIGTokensRaw

/// Component tokens for content ``HIGTabs`` (not app ``HIGTabBar`` chrome).
public protocol HIGTabsTokens: Sendable {
    var font: Font { get }
    var selectedFont: Font { get }
    var itemSpacing: CGFloat { get }
    var underlineHeight: CGFloat { get }
    var minTapTarget: CGFloat { get }
}

/// System defaults for in-content tabs.
public struct HIGSystemTabsTokens: HIGTabsTokens, Sendable {
    public let font: Font
    public let selectedFont: Font
    public let itemSpacing: CGFloat
    public let underlineHeight: CGFloat
    public let minTapTarget: CGFloat

    public init(
        font: Font = .body,
        selectedFont: Font = .body.weight(.semibold),
        itemSpacing: CGFloat = HIGSpacing.lg.rawValue,
        underlineHeight: CGFloat = HIGBorder.hairline.rawValue + HIGSpacing.xxs.rawValue,
        minTapTarget: CGFloat = HIGSpacing.massive.rawValue
    ) {
        self.font = font
        self.selectedFont = selectedFont
        self.itemSpacing = itemSpacing
        self.underlineHeight = underlineHeight
        self.minTapTarget = minTapTarget
    }
}
