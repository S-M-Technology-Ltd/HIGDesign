import CoreGraphics
import SwiftUI
import HIGTokensRaw

/// Component tokens for ``HIGEmptyState``.
public protocol HIGEmptyStateTokens: Sendable {
    var iconPointSize: CGFloat { get }
    var titleFont: Font { get }
    var messageFont: Font { get }
    var stackSpacing: CGFloat { get }
    var actionSpacing: CGFloat { get }
    var maxContentWidth: CGFloat { get }
}

/// System defaults for empty-state messaging.
public struct HIGSystemEmptyStateTokens: HIGEmptyStateTokens, Sendable {
    public let iconPointSize: CGFloat
    public let titleFont: Font
    public let messageFont: Font
    public let stackSpacing: CGFloat
    public let actionSpacing: CGFloat
    public let maxContentWidth: CGFloat

    public init(
        iconPointSize: CGFloat = HIGSpacing.massive.rawValue,
        titleFont: Font = .title2.weight(.semibold),
        messageFont: Font = .body,
        stackSpacing: CGFloat = HIGSpacing.md.rawValue,
        actionSpacing: CGFloat = HIGSpacing.sm.rawValue,
        maxContentWidth: CGFloat = 360
    ) {
        self.iconPointSize = iconPointSize
        self.titleFont = titleFont
        self.messageFont = messageFont
        self.stackSpacing = stackSpacing
        self.actionSpacing = actionSpacing
        self.maxContentWidth = maxContentWidth
    }
}
