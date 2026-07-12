import HIGThemesContract
import HIGTokensComponent
import SwiftUI

/// A themed metric counter for admin dashboards and KPI tiles.
///
/// Displays a primary value with title, optional caption, SF Symbol, and trend chip.
/// Inspired by Remark Admin counters/widgets; chrome resolves from ``HIGTheme/counter``.
public struct HIGCounter: View {
    private let title: String
    private let value: String
    private let caption: String?
    private let systemImage: String?
    private let trend: HIGCounterTrend?
    private let trendLabel: String?

    @Environment(\.higTheme) private var theme
    @Environment(\.isEnabled) private var isEnabled

    /// Creates a metric counter.
    /// - Parameters:
    ///   - title: Short metric name (for example "Users").
    ///   - value: Formatted primary value (for example "1,284").
    ///   - caption: Optional supporting text under the value.
    ///   - systemImage: Optional leading SF Symbol.
    ///   - trend: Optional directional change.
    ///   - trendLabel: Optional trend text (for example "+12%").
    public init(
        _ title: String,
        value: String,
        caption: String? = nil,
        systemImage: String? = nil,
        trend: HIGCounterTrend? = nil,
        trendLabel: String? = nil
    ) {
        self.title = title
        self.value = value
        self.caption = caption
        self.systemImage = systemImage
        self.trend = trend
        self.trendLabel = trendLabel
    }

    public var body: some View {
        let tokens = theme.counter

        HStack(alignment: .top, spacing: tokens.stackSpacing) {
            if let systemImage {
                Image(systemName: systemImage)
                    .font(.system(size: tokens.iconPointSize, weight: .semibold))
                    .foregroundStyle(theme.colors.accent)
                    .frame(width: tokens.iconPointSize + tokens.stackSpacing, alignment: .center)
                    .accessibilityHidden(true)
            }

            VStack(alignment: .leading, spacing: tokens.stackSpacing) {
                Text(title)
                    .font(tokens.titleFont)
                    .foregroundStyle(theme.colors.labelSecondary)
                    .frame(maxWidth: .infinity, alignment: .leading)

                Text(value)
                    .font(tokens.valueFont)
                    .foregroundStyle(theme.colors.labelPrimary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .minimumScaleFactor(0.7)
                    .lineLimit(1)

                if let caption {
                    Text(caption)
                        .font(tokens.captionFont)
                        .foregroundStyle(theme.colors.labelSecondary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }

                if trend != nil || trendLabel != nil {
                    trendRow(tokens: tokens)
                }
            }
        }
        .padding(tokens.contentPadding)
        .frame(maxWidth: .infinity, minHeight: tokens.minHeight, alignment: .topLeading)
        .background(theme.colors.backgroundSecondary)
        .clipShape(RoundedRectangle(cornerRadius: tokens.cornerRadius, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: tokens.cornerRadius, style: .continuous)
                .strokeBorder(theme.colors.separator, lineWidth: tokens.borderWidth)
        }
        .opacity(isEnabled ? theme.opacity.full : theme.opacity.disabled)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(accessibilityLabelText)
        .accessibilityValue(accessibilityValueText)
    }

    @ViewBuilder
    private func trendRow(tokens: any HIGCounterTokens) -> some View {
        HStack(spacing: tokens.stackSpacing) {
            if let trend {
                Image(systemName: trend.systemImage)
                    .font(tokens.trendFont)
                    .foregroundStyle(trendColor(for: trend))
                    .accessibilityHidden(true)
            }
            if let trendLabel {
                Text(trendLabel)
                    .font(tokens.trendFont)
                    .foregroundStyle(trend.map(trendColor(for:)) ?? theme.colors.labelSecondary)
            }
        }
        .accessibilityHidden(true)
    }

    private func trendColor(for trend: HIGCounterTrend) -> Color {
        switch trend {
        case .up: theme.colors.accent
        case .down: theme.colors.destructive
        case .neutral: theme.colors.labelSecondary
        }
    }

    private var accessibilityLabelText: String {
        title
    }

    private var accessibilityValueText: String {
        var parts = [value]
        if let caption {
            parts.append(caption)
        }
        if let trend {
            parts.append(trend.accessibilityLabel)
        }
        if let trendLabel {
            parts.append(trendLabel)
        }
        return parts.joined(separator: ", ")
    }
}

#if DEBUG
#Preview("HIGCounter") {
    HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        HIGCounter(
            "Active users",
            value: "1,284",
            caption: "Last 7 days",
            systemImage: "person.2",
            trend: .up,
            trendLabel: "+12%"
        )
        .padding()
    }
}
#endif
