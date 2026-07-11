import CoreGraphics
import HIGTokensRaw

/// Component tokens for ``HIGButtonGroup``.
public protocol HIGButtonGroupTokens: Sendable {
    var spacing: CGFloat { get }
}

/// System defaults for button groups.
public struct HIGSystemButtonGroupTokens: HIGButtonGroupTokens, Sendable {
    public let spacing: CGFloat

    public init(spacing: CGFloat = HIGSpacing.sm.rawValue) {
        self.spacing = spacing
    }
}
