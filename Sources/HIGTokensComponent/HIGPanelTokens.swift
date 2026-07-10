import CoreGraphics
import SwiftUI
import HIGTokensRaw

/// Component tokens for ``HIGPanel`` dashboard surfaces.
public protocol HIGPanelTokens: Sendable {
    var cornerRadius: CGFloat { get }
    var contentPadding: CGFloat { get }
    var headerSpacing: CGFloat { get }
    var borderWidth: CGFloat { get }
    var actionIconPointSize: CGFloat { get }
    var minActionTarget: CGFloat { get }
    var titleFont: Font { get }
    var descriptionFont: Font { get }
}

/// System defaults for panel surfaces (HIG-friendly card-like chrome).
public struct HIGSystemPanelTokens: HIGPanelTokens, Sendable {
    public let cornerRadius: CGFloat
    public let contentPadding: CGFloat
    public let headerSpacing: CGFloat
    public let borderWidth: CGFloat
    public let actionIconPointSize: CGFloat
    public let minActionTarget: CGFloat
    public let titleFont: Font
    public let descriptionFont: Font

    public init(
        cornerRadius: CGFloat = HIGRadius.lg.rawValue,
        contentPadding: CGFloat = HIGSpacing.lg.rawValue,
        headerSpacing: CGFloat = HIGSpacing.sm.rawValue,
        borderWidth: CGFloat = HIGBorder.hairline.rawValue,
        actionIconPointSize: CGFloat = HIGSpacing.lg.rawValue,
        minActionTarget: CGFloat = HIGSpacing.massive.rawValue,
        titleFont: Font = .headline,
        descriptionFont: Font = .subheadline
    ) {
        self.cornerRadius = cornerRadius
        self.contentPadding = contentPadding
        self.headerSpacing = headerSpacing
        self.borderWidth = borderWidth
        self.actionIconPointSize = actionIconPointSize
        self.minActionTarget = minActionTarget
        self.titleFont = titleFont
        self.descriptionFont = descriptionFont
    }
}
