import CoreGraphics
import SwiftUI
import HIGTokensRaw

/// Component tokens for ``HIGSocialButton``.
public protocol HIGSocialButtonTokens: Sendable {
    var minHeight: CGFloat { get }
    var horizontalPadding: CGFloat { get }
    var iconPointSize: CGFloat { get }
    var iconTitleSpacing: CGFloat { get }
    var cornerRadius: CGFloat { get }
    var borderWidth: CGFloat { get }
    var iconOnlySize: CGFloat { get }
    var font: Font { get }
}

/// System defaults for social action buttons.
public struct HIGSystemSocialButtonTokens: HIGSocialButtonTokens, Sendable {
    public let minHeight: CGFloat
    public let horizontalPadding: CGFloat
    public let iconPointSize: CGFloat
    public let iconTitleSpacing: CGFloat
    public let cornerRadius: CGFloat
    public let borderWidth: CGFloat
    public let iconOnlySize: CGFloat
    public let font: Font

    public init(
        minHeight: CGFloat = HIGSpacing.massive.rawValue,
        horizontalPadding: CGFloat = HIGSpacing.md.rawValue,
        iconPointSize: CGFloat = 18,
        iconTitleSpacing: CGFloat = HIGSpacing.sm.rawValue,
        cornerRadius: CGFloat = HIGRadius.md.rawValue,
        borderWidth: CGFloat = HIGBorder.hairline.rawValue,
        iconOnlySize: CGFloat = HIGSpacing.massive.rawValue,
        font: Font = .body.weight(.semibold)
    ) {
        self.minHeight = minHeight
        self.horizontalPadding = horizontalPadding
        self.iconPointSize = iconPointSize
        self.iconTitleSpacing = iconTitleSpacing
        self.cornerRadius = cornerRadius
        self.borderWidth = borderWidth
        self.iconOnlySize = iconOnlySize
        self.font = font
    }
}
