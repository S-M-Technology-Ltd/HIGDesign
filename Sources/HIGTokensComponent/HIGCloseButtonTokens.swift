import CoreGraphics
import SwiftUI
import HIGTokensRaw

/// Component tokens for ``HIGCloseButton``.
public protocol HIGCloseButtonTokens: Sendable {
    var minTapTarget: CGFloat { get }
    var iconPointSize: CGFloat { get }
    var font: Font { get }
}

/// System defaults for dismiss/close controls.
public struct HIGSystemCloseButtonTokens: HIGCloseButtonTokens, Sendable {
    public let minTapTarget: CGFloat
    public let iconPointSize: CGFloat
    public let font: Font

    public init(
        minTapTarget: CGFloat = HIGSpacing.massive.rawValue,
        iconPointSize: CGFloat = HIGSpacing.lg.rawValue,
        font: Font = .body.weight(.semibold)
    ) {
        self.minTapTarget = minTapTarget
        self.iconPointSize = iconPointSize
        self.font = font
    }
}
