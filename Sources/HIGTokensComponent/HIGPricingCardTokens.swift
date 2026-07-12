import CoreGraphics
import SwiftUI
import HIGTokensRaw

/// Component tokens for ``HIGPricingCard``.
public protocol HIGPricingCardTokens: Sendable {
    var contentPadding: CGFloat { get }
    var stackSpacing: CGFloat { get }
    var featureSpacing: CGFloat { get }
    var headerSpacing: CGFloat { get }
    var cornerRadius: CGFloat { get }
    var borderWidth: CGFloat { get }
    var featuredBorderWidth: CGFloat { get }
    var titleFont: Font { get }
    var priceFont: Font { get }
    var currencyFont: Font { get }
    var periodFont: Font { get }
    var featureFont: Font { get }
    var featureIconPointSize: CGFloat { get }
}

/// System defaults for pricing plan cards.
public struct HIGSystemPricingCardTokens: HIGPricingCardTokens, Sendable {
    public let contentPadding: CGFloat
    public let stackSpacing: CGFloat
    public let featureSpacing: CGFloat
    public let headerSpacing: CGFloat
    public let cornerRadius: CGFloat
    public let borderWidth: CGFloat
    public let featuredBorderWidth: CGFloat
    public let titleFont: Font
    public let priceFont: Font
    public let currencyFont: Font
    public let periodFont: Font
    public let featureFont: Font
    public let featureIconPointSize: CGFloat

    public init(
        contentPadding: CGFloat = HIGSpacing.lg.rawValue,
        stackSpacing: CGFloat = HIGSpacing.md.rawValue,
        featureSpacing: CGFloat = HIGSpacing.sm.rawValue,
        headerSpacing: CGFloat = HIGSpacing.xs.rawValue,
        cornerRadius: CGFloat = HIGRadius.md.rawValue,
        borderWidth: CGFloat = HIGBorder.hairline.rawValue,
        featuredBorderWidth: CGFloat = 2,
        titleFont: Font = .headline,
        priceFont: Font = .largeTitle.weight(.bold),
        currencyFont: Font = .title3.weight(.semibold),
        periodFont: Font = .subheadline,
        featureFont: Font = .body,
        featureIconPointSize: CGFloat = 14
    ) {
        self.contentPadding = contentPadding
        self.stackSpacing = stackSpacing
        self.featureSpacing = featureSpacing
        self.headerSpacing = headerSpacing
        self.cornerRadius = cornerRadius
        self.borderWidth = borderWidth
        self.featuredBorderWidth = featuredBorderWidth
        self.titleFont = titleFont
        self.priceFont = priceFont
        self.currencyFont = currencyFont
        self.periodFont = periodFont
        self.featureFont = featureFont
        self.featureIconPointSize = featureIconPointSize
    }
}
