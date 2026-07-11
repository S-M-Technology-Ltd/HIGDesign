import CoreGraphics
import SwiftUI
import HIGTokensRaw

/// Component tokens for ``HIGFieldMessage``.
public protocol HIGFieldMessageTokens: Sendable {
    var font: Font { get }
    var iconPointSize: CGFloat { get }
    var spacing: CGFloat { get }
}

/// System defaults for field helper and validation messages.
public struct HIGSystemFieldMessageTokens: HIGFieldMessageTokens, Sendable {
    public let font: Font
    public let iconPointSize: CGFloat
    public let spacing: CGFloat

    public init(
        font: Font = .caption,
        iconPointSize: CGFloat = HIGSpacing.md.rawValue,
        spacing: CGFloat = HIGSpacing.xs.rawValue
    ) {
        self.font = font
        self.iconPointSize = iconPointSize
        self.spacing = spacing
    }
}
