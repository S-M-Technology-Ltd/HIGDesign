import CoreGraphics
import SwiftUI
import HIGTokensRaw

/// Component tokens for ``HIGBreadcrumb`` trails.
public protocol HIGBreadcrumbTokens: Sendable {
    var font: Font { get }
    var currentFont: Font { get }
    var itemSpacing: CGFloat { get }
    var separatorPointSize: CGFloat { get }
    var minTapTarget: CGFloat { get }
}

/// System defaults for breadcrumb trails.
public struct HIGSystemBreadcrumbTokens: HIGBreadcrumbTokens, Sendable {
    public let font: Font
    public let currentFont: Font
    public let itemSpacing: CGFloat
    public let separatorPointSize: CGFloat
    public let minTapTarget: CGFloat

    public init(
        font: Font = .subheadline,
        currentFont: Font = .subheadline.weight(.semibold),
        itemSpacing: CGFloat = HIGSpacing.xs.rawValue,
        separatorPointSize: CGFloat = HIGSpacing.sm.rawValue,
        minTapTarget: CGFloat = HIGSpacing.massive.rawValue
    ) {
        self.font = font
        self.currentFont = currentFont
        self.itemSpacing = itemSpacing
        self.separatorPointSize = separatorPointSize
        self.minTapTarget = minTapTarget
    }
}
