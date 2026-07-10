import CoreGraphics
import SwiftUI
import HIGTokensRaw

/// Component tokens for ``HIGPagination``.
public protocol HIGPaginationTokens: Sendable {
    var font: Font { get }
    var itemSpacing: CGFloat { get }
    var pageMinWidth: CGFloat { get }
    var minTapTarget: CGFloat { get }
    var cornerRadius: CGFloat { get }
    var borderWidth: CGFloat { get }
}

/// System defaults for pagination controls.
public struct HIGSystemPaginationTokens: HIGPaginationTokens, Sendable {
    public let font: Font
    public let itemSpacing: CGFloat
    public let pageMinWidth: CGFloat
    public let minTapTarget: CGFloat
    public let cornerRadius: CGFloat
    public let borderWidth: CGFloat

    public init(
        font: Font = .subheadline.weight(.semibold),
        itemSpacing: CGFloat = HIGSpacing.xs.rawValue,
        pageMinWidth: CGFloat = HIGSpacing.massive.rawValue,
        minTapTarget: CGFloat = HIGSpacing.massive.rawValue,
        cornerRadius: CGFloat = HIGRadius.sm.rawValue,
        borderWidth: CGFloat = HIGBorder.hairline.rawValue
    ) {
        self.font = font
        self.itemSpacing = itemSpacing
        self.pageMinWidth = pageMinWidth
        self.minTapTarget = minTapTarget
        self.cornerRadius = cornerRadius
        self.borderWidth = borderWidth
    }
}
