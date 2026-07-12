import CoreGraphics
import SwiftUI
import HIGTokensRaw

/// Component tokens for ``HIGCodeBlock``.
public protocol HIGCodeBlockTokens: Sendable {
    var font: Font { get }
    var languageFont: Font { get }
    var horizontalPadding: CGFloat { get }
    var verticalPadding: CGFloat { get }
    var cornerRadius: CGFloat { get }
    var borderWidth: CGFloat { get }
    var headerSpacing: CGFloat { get }
    var maxHeight: CGFloat { get }
    var minHeight: CGFloat { get }
}

/// System defaults for monospaced code surfaces.
public struct HIGSystemCodeBlockTokens: HIGCodeBlockTokens, Sendable {
    public let font: Font
    public let languageFont: Font
    public let horizontalPadding: CGFloat
    public let verticalPadding: CGFloat
    public let cornerRadius: CGFloat
    public let borderWidth: CGFloat
    public let headerSpacing: CGFloat
    public let maxHeight: CGFloat
    public let minHeight: CGFloat

    public init(
        font: Font = .system(.body, design: .monospaced),
        languageFont: Font = .caption.weight(.semibold),
        horizontalPadding: CGFloat = HIGSpacing.md.rawValue,
        verticalPadding: CGFloat = HIGSpacing.sm.rawValue,
        cornerRadius: CGFloat = HIGRadius.sm.rawValue,
        borderWidth: CGFloat = HIGBorder.hairline.rawValue,
        headerSpacing: CGFloat = HIGSpacing.sm.rawValue,
        maxHeight: CGFloat = 280,
        minHeight: CGFloat = 44
    ) {
        self.font = font
        self.languageFont = languageFont
        self.horizontalPadding = horizontalPadding
        self.verticalPadding = verticalPadding
        self.cornerRadius = cornerRadius
        self.borderWidth = borderWidth
        self.headerSpacing = headerSpacing
        self.maxHeight = maxHeight
        self.minHeight = minHeight
    }
}
