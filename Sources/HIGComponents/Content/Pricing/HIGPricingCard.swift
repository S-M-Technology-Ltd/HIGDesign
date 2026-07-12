import HIGThemesContract
import HIGTokensComponent
import HIGTokensRaw
import SwiftUI

/// A themed pricing plan card for admin marketing and plan comparison.
///
/// Shows plan title, price with currency/period, feature list, optional CTA,
/// featured emphasis, and optional corner ribbon. Inspired by Remark Admin
/// pricing tables; chrome resolves from ``HIGTheme/pricingCard``.
public struct HIGPricingCard: View {
    private let title: String
    private let price: String
    private let currency: String
    private let period: String?
    private let features: [String]
    private let isFeatured: Bool
    private let ribbonText: String?
    private let actionTitle: String?
    private let action: (() -> Void)?

    @Environment(\.higTheme) private var theme
    @Environment(\.isEnabled) private var isEnabled

    /// Creates a pricing plan card.
    /// - Parameters:
    ///   - title: Plan name (for example `"Pro"`).
    ///   - price: Numeric or formatted amount (for example `"29"` or `"29.00"`).
    ///   - currency: Leading currency symbol or code (default `"$"`).
    ///   - period: Optional billing period caption (for example `"/mo"`).
    ///   - features: Included feature lines with checkmarks.
    ///   - isFeatured: Emphasizes the card with accent border for recommended plans.
    ///   - ribbonText: Optional corner ribbon (for example `"Popular"`).
    ///   - actionTitle: Optional CTA button title.
    ///   - action: CTA handler; required when `actionTitle` is non-nil.
    public init(
        _ title: String,
        price: String,
        currency: String = "$",
        period: String? = nil,
        features: [String] = [],
        isFeatured: Bool = false,
        ribbonText: String? = nil,
        actionTitle: String? = nil,
        action: (() -> Void)? = nil
    ) {
        self.title = title
        self.price = price
        self.currency = currency
        self.period = period
        self.features = features
        self.isFeatured = isFeatured
        self.ribbonText = ribbonText
        self.actionTitle = actionTitle
        self.action = action
    }

    public var body: some View {
        let tokens = theme.pricingCard
        let shape = RoundedRectangle(cornerRadius: tokens.cornerRadius, style: .continuous)
        let strokeWidth = isFeatured ? tokens.featuredBorderWidth : tokens.borderWidth
        let strokeColor = isFeatured ? theme.colors.accent : theme.colors.separator

        VStack(alignment: .center, spacing: tokens.stackSpacing) {
            header(tokens: tokens)
            featureList(tokens: tokens)
            if let actionTitle, let action {
                HIGButton(
                    actionTitle,
                    role: isFeatured ? .primary : .secondary,
                    action: action
                )
            }
        }
        .padding(tokens.contentPadding)
        .frame(maxWidth: .infinity, alignment: .top)
        .background(theme.colors.backgroundSecondary)
        .clipShape(shape)
        .overlay {
            shape.strokeBorder(strokeColor, lineWidth: strokeWidth)
        }
        .overlay(alignment: .topTrailing) {
            if let ribbonText {
                HIGRibbon(ribbonText, style: .accent, edge: .topTrailing)
                    .padding(theme.ribbon.edgeInset)
                    .allowsHitTesting(false)
            }
        }
        .opacity(isEnabled ? theme.opacity.full : theme.opacity.disabled)
        .accessibilityElement(children: .contain)
        .accessibilityLabel(accessibilityLabelText)
    }

    private func header(tokens: any HIGPricingCardTokens) -> some View {
        VStack(spacing: tokens.headerSpacing) {
            Text(title)
                .font(tokens.titleFont)
                .foregroundStyle(theme.colors.labelPrimary)
                .multilineTextAlignment(.center)
                .accessibilityAddTraits(.isHeader)

            HStack(alignment: .firstTextBaseline, spacing: HIGSpacing.xxs.rawValue) {
                Text(currency)
                    .font(tokens.currencyFont)
                    .foregroundStyle(theme.colors.labelSecondary)
                Text(price)
                    .font(tokens.priceFont)
                    .foregroundStyle(theme.colors.labelPrimary)
                if let period {
                    Text(period)
                        .font(tokens.periodFont)
                        .foregroundStyle(theme.colors.labelSecondary)
                }
            }
            .accessibilityElement(children: .combine)
            .accessibilityLabel(priceAccessibilityLabel)
        }
        .frame(maxWidth: .infinity)
    }

    private func featureList(tokens: any HIGPricingCardTokens) -> some View {
        VStack(alignment: .leading, spacing: tokens.featureSpacing) {
            ForEach(Array(features.enumerated()), id: \.offset) { _, feature in
                HStack(alignment: .top, spacing: theme.spacing.compactItem) {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: tokens.featureIconPointSize, weight: .semibold))
                        .foregroundStyle(theme.colors.accent)
                        .accessibilityHidden(true)
                    Text(feature)
                        .font(tokens.featureFont)
                        .foregroundStyle(theme.colors.labelPrimary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .accessibilityElement(children: .combine)
    }

    private var priceAccessibilityLabel: String {
        if let period {
            return "\(currency)\(price) \(period)"
        }
        return "\(currency)\(price)"
    }

    private var accessibilityLabelText: String {
        var parts = ["Pricing plan \(title)", priceAccessibilityLabel]
        if isFeatured {
            parts.append("Featured")
        }
        if let ribbonText {
            parts.append(ribbonText)
        }
        if !features.isEmpty {
            parts.append("Includes \(features.joined(separator: ", "))")
        }
        if let actionTitle {
            parts.append(actionTitle)
        }
        return parts.joined(separator: ". ")
    }
}

#if DEBUG
#Preview("HIGPricingCard") {
    HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        HStack(alignment: .top, spacing: HIGSpacing.md.rawValue) {
            HIGPricingCard(
                "Basic",
                price: "9",
                period: "/mo",
                features: ["1 project", "Email support"],
                actionTitle: "Choose Basic"
            ) {}

            HIGPricingCard(
                "Pro",
                price: "29",
                period: "/mo",
                features: ["Unlimited projects", "Priority support", "Analytics"],
                isFeatured: true,
                ribbonText: "Popular",
                actionTitle: "Choose Pro"
            ) {}
        }
        .padding()
    }
}
#endif
