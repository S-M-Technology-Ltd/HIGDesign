import CoreGraphics
import SwiftUI
import HIGTokensRaw

/// Component tokens for ``HIGPanelGroup``.
public protocol HIGPanelGroupTokens: Sendable {
    var stackSpacing: CGFloat { get }
    var titleSpacing: CGFloat { get }
    var titleFont: Font { get }
}

/// System defaults for stacked panel groups.
public struct HIGSystemPanelGroupTokens: HIGPanelGroupTokens, Sendable {
    public let stackSpacing: CGFloat
    public let titleSpacing: CGFloat
    public let titleFont: Font

    public init(
        stackSpacing: CGFloat = HIGSpacing.md.rawValue,
        titleSpacing: CGFloat = HIGSpacing.sm.rawValue,
        titleFont: Font = .title3.weight(.semibold)
    ) {
        self.stackSpacing = stackSpacing
        self.titleSpacing = titleSpacing
        self.titleFont = titleFont
    }
}
