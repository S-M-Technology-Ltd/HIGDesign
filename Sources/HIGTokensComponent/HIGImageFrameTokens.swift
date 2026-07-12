import CoreGraphics
import SwiftUI
import HIGTokensRaw

/// Component tokens for ``HIGImageFrame``.
public protocol HIGImageFrameTokens: Sendable {
    var cornerRadius: CGFloat { get }
    var borderWidth: CGFloat { get }
    var minHeight: CGFloat { get }
    var placeholderIconPointSize: CGFloat { get }
}

/// System defaults for framed image surfaces.
public struct HIGSystemImageFrameTokens: HIGImageFrameTokens, Sendable {
    public let cornerRadius: CGFloat
    public let borderWidth: CGFloat
    public let minHeight: CGFloat
    public let placeholderIconPointSize: CGFloat

    public init(
        cornerRadius: CGFloat = HIGRadius.md.rawValue,
        borderWidth: CGFloat = HIGBorder.hairline.rawValue,
        minHeight: CGFloat = 120,
        placeholderIconPointSize: CGFloat = 28
    ) {
        self.cornerRadius = cornerRadius
        self.borderWidth = borderWidth
        self.minHeight = minHeight
        self.placeholderIconPointSize = placeholderIconPointSize
    }
}
