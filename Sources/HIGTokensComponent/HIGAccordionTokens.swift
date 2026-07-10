import CoreGraphics
import SwiftUI
import HIGTokensRaw

/// Component tokens for ``HIGAccordion`` / ``HIGAccordionSection``.
public protocol HIGAccordionTokens: Sendable {
    var titleFont: Font { get }
    var contentFont: Font { get }
    var headerMinHeight: CGFloat { get }
    var contentPadding: CGFloat { get }
    var sectionSpacing: CGFloat { get }
    var cornerRadius: CGFloat { get }
    var borderWidth: CGFloat { get }
    var chevronPointSize: CGFloat { get }
}

/// System defaults for accordion sections.
public struct HIGSystemAccordionTokens: HIGAccordionTokens, Sendable {
    public let titleFont: Font
    public let contentFont: Font
    public let headerMinHeight: CGFloat
    public let contentPadding: CGFloat
    public let sectionSpacing: CGFloat
    public let cornerRadius: CGFloat
    public let borderWidth: CGFloat
    public let chevronPointSize: CGFloat

    public init(
        titleFont: Font = .headline,
        contentFont: Font = .body,
        headerMinHeight: CGFloat = HIGSpacing.massive.rawValue,
        contentPadding: CGFloat = HIGSpacing.md.rawValue,
        sectionSpacing: CGFloat = HIGSpacing.sm.rawValue,
        cornerRadius: CGFloat = HIGRadius.md.rawValue,
        borderWidth: CGFloat = HIGBorder.hairline.rawValue,
        chevronPointSize: CGFloat = HIGSpacing.sm.rawValue
    ) {
        self.titleFont = titleFont
        self.contentFont = contentFont
        self.headerMinHeight = headerMinHeight
        self.contentPadding = contentPadding
        self.sectionSpacing = sectionSpacing
        self.cornerRadius = cornerRadius
        self.borderWidth = borderWidth
        self.chevronPointSize = chevronPointSize
    }
}
