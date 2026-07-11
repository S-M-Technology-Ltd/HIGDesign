import CoreGraphics
import SwiftUI
import HIGTokensRaw

/// Component tokens for ``HIGSelect``, ``HIGAutocomplete``, and ``HIGTagInput``.
public protocol HIGSelectTokens: Sendable {
    var minHeight: CGFloat { get }
    var horizontalPadding: CGFloat { get }
    var cornerRadius: CGFloat { get }
    var borderWidth: CGFloat { get }
    var font: Font { get }
    var chevronPointSize: CGFloat { get }
    var suggestionRowMinHeight: CGFloat { get }
    var maxSuggestionHeight: CGFloat { get }
    var chipSpacing: CGFloat { get }
}

/// System defaults for form select, autocomplete, and tag input chrome.
public struct HIGSystemSelectTokens: HIGSelectTokens, Sendable {
    public let minHeight: CGFloat
    public let horizontalPadding: CGFloat
    public let cornerRadius: CGFloat
    public let borderWidth: CGFloat
    public let font: Font
    public let chevronPointSize: CGFloat
    public let suggestionRowMinHeight: CGFloat
    public let maxSuggestionHeight: CGFloat
    public let chipSpacing: CGFloat

    public init(
        minHeight: CGFloat = 44,
        horizontalPadding: CGFloat = HIGSpacing.md.rawValue,
        cornerRadius: CGFloat = HIGRadius.sm.rawValue,
        borderWidth: CGFloat = HIGBorder.hairline.rawValue,
        font: Font = .body,
        chevronPointSize: CGFloat = 12,
        suggestionRowMinHeight: CGFloat = 44,
        maxSuggestionHeight: CGFloat = 220,
        chipSpacing: CGFloat = HIGSpacing.xs.rawValue
    ) {
        self.minHeight = minHeight
        self.horizontalPadding = horizontalPadding
        self.cornerRadius = cornerRadius
        self.borderWidth = borderWidth
        self.font = font
        self.chevronPointSize = chevronPointSize
        self.suggestionRowMinHeight = suggestionRowMinHeight
        self.maxSuggestionHeight = maxSuggestionHeight
        self.chipSpacing = chipSpacing
    }
}
