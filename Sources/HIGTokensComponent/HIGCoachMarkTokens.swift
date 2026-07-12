import CoreGraphics
import SwiftUI
import HIGTokensRaw

/// Component tokens for ``HIGCoachMark``.
public protocol HIGCoachMarkTokens: Sendable {
    var contentPadding: CGFloat { get }
    var stackSpacing: CGFloat { get }
    var actionSpacing: CGFloat { get }
    var cornerRadius: CGFloat { get }
    var borderWidth: CGFloat { get }
    var maxWidth: CGFloat { get }
    var scrimOpacity: CGFloat { get }
    var titleFont: Font { get }
    var messageFont: Font { get }
    var stepFont: Font { get }
}

/// System defaults for onboarding coach marks.
public struct HIGSystemCoachMarkTokens: HIGCoachMarkTokens, Sendable {
    public let contentPadding: CGFloat
    public let stackSpacing: CGFloat
    public let actionSpacing: CGFloat
    public let cornerRadius: CGFloat
    public let borderWidth: CGFloat
    public let maxWidth: CGFloat
    public let scrimOpacity: CGFloat
    public let titleFont: Font
    public let messageFont: Font
    public let stepFont: Font

    public init(
        contentPadding: CGFloat = HIGSpacing.md.rawValue,
        stackSpacing: CGFloat = HIGSpacing.sm.rawValue,
        actionSpacing: CGFloat = HIGSpacing.sm.rawValue,
        cornerRadius: CGFloat = HIGRadius.md.rawValue,
        borderWidth: CGFloat = HIGBorder.hairline.rawValue,
        maxWidth: CGFloat = 320,
        scrimOpacity: CGFloat = HIGOpacity.pressedPrimary.rawValue,
        titleFont: Font = .headline,
        messageFont: Font = .subheadline,
        stepFont: Font = .caption.weight(.semibold)
    ) {
        self.contentPadding = contentPadding
        self.stackSpacing = stackSpacing
        self.actionSpacing = actionSpacing
        self.cornerRadius = cornerRadius
        self.borderWidth = borderWidth
        self.maxWidth = maxWidth
        self.scrimOpacity = scrimOpacity
        self.titleFont = titleFont
        self.messageFont = messageFont
        self.stepFont = stepFont
    }
}
