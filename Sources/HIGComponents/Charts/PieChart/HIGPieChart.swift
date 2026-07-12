import Charts
import HIGPlatform
import HIGThemesContract
import HIGTokensComponent
import SwiftUI

/// Visual style for ``HIGPieChart``.
public enum HIGPieChartStyle: String, Sendable, CaseIterable, Equatable {
    /// Solid pie with no center hole.
    case pie
    /// Donut with an inner hole sized from ``HIGPieChartTokens/donutInnerRadiusRatio``.
    case donut
}

/// A themed pie or donut chart for admin dashboards and part-to-whole metrics.
///
/// Built on Apple Swift Charts (no third-party chart libraries). Reuses ``HIGChartPoint``
/// for categorical slices with automatic series coloring and a chart legend.
public struct HIGPieChart: View {
    private let title: String?
    private let points: [HIGChartPoint]
    private let emptyMessage: String
    private let style: HIGPieChartStyle

    @Environment(\.higTheme) private var theme
    @Environment(\.isEnabled) private var isEnabled

    /// Creates a pie or donut chart.
    /// - Parameters:
    ///   - title: Optional chart title above the plot.
    ///   - points: Slice values (non-negative magnitudes).
    ///   - emptyMessage: Shown when `points` is empty.
    ///   - style: Solid pie or donut.
    public init(
        _ title: String? = nil,
        points: [HIGChartPoint],
        emptyMessage: String = "No data",
        style: HIGPieChartStyle = .pie
    ) {
        self.title = title
        self.points = points
        self.emptyMessage = emptyMessage
        self.style = style
    }

    public var body: some View {
        let tokens = theme.pieChart
        let capabilities = HIGPlatformCapabilities.current
        let minHeight = max(tokens.minHeight, capabilities.minimumTouchTarget * 3)

        VStack(alignment: .leading, spacing: tokens.stackSpacing) {
            if let title {
                Text(title)
                    .font(tokens.titleFont)
                    .foregroundStyle(theme.colors.labelPrimary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .accessibilityAddTraits(.isHeader)
            }

            Group {
                if points.isEmpty {
                    Text(emptyMessage)
                        .font(tokens.emptyFont)
                        .foregroundStyle(theme.colors.labelSecondary)
                        .frame(maxWidth: .infinity, minHeight: minHeight, alignment: .center)
                        .accessibilityLabel(emptyMessage)
                } else {
                    chartPlot(tokens: tokens, minHeight: minHeight)
                }
            }
        }
        .padding(tokens.contentPadding)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(theme.colors.backgroundSecondary)
        .clipShape(RoundedRectangle(cornerRadius: tokens.cornerRadius, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: tokens.cornerRadius, style: .continuous)
                .strokeBorder(theme.colors.separator, lineWidth: tokens.borderWidth)
        }
        .opacity(isEnabled ? theme.opacity.full : theme.opacity.disabled)
        .accessibilityElement(children: .contain)
        .accessibilityLabel(accessibilityLabelText)
        .accessibilityValue(accessibilityValueText)
    }

    private func chartPlot(tokens: any HIGPieChartTokens, minHeight: CGFloat) -> some View {
        let innerRatio = style == .donut ? tokens.donutInnerRadiusRatio : 0

        return Chart(points) { point in
            SectorMark(
                angle: .value("Value", max(point.value, 0)),
                innerRadius: .ratio(innerRatio),
                angularInset: tokens.sectorInset
            )
            .foregroundStyle(by: .value("Category", point.label))
            .cornerRadius(tokens.sectorInset)
        }
        .chartLegend(position: .bottom, alignment: .center)
        .frame(maxWidth: .infinity, minHeight: minHeight)
        .accessibilityHidden(true)
    }

    private var accessibilityLabelText: String {
        let styleName = style == .donut ? "Donut chart" : "Pie chart"
        if let title {
            return "\(title), \(styleName)"
        }
        return styleName
    }

    private var accessibilityValueText: String {
        guard !points.isEmpty else { return emptyMessage }
        return points
            .map { "\($0.label): \($0.value)" }
            .joined(separator: ", ")
    }
}

#if DEBUG
#Preview("HIGPieChart") {
    HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        HIGPieChart(
            "Plan mix",
            points: [
                HIGChartPoint(label: "Pro", value: 120),
                HIGChartPoint(label: "Team", value: 86),
                HIGChartPoint(label: "Free", value: 210),
            ],
            style: .donut
        )
        .padding()
    }
}
#endif
