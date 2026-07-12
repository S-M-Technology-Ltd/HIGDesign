import Charts
import HIGPlatform
import HIGThemesContract
import HIGTokensComponent
import SwiftUI

/// A themed line chart for admin dashboards and trend series.
///
/// Built on Apple Swift Charts (no third-party chart libraries). Reuses ``HIGChartPoint``
/// for ordered categorical values connected by a line with point markers.
public struct HIGLineChart: View {
    private let title: String?
    private let points: [HIGChartPoint]
    private let emptyMessage: String
    private let showsSymbols: Bool

    @Environment(\.higTheme) private var theme
    @Environment(\.isEnabled) private var isEnabled

    /// Creates a line chart.
    /// - Parameters:
    ///   - title: Optional chart title above the plot.
    ///   - points: Ordered values along the series.
    ///   - emptyMessage: Shown when `points` is empty.
    ///   - showsSymbols: When `true`, draws point markers on each value.
    public init(
        _ title: String? = nil,
        points: [HIGChartPoint],
        emptyMessage: String = "No data",
        showsSymbols: Bool = true
    ) {
        self.title = title
        self.points = points
        self.emptyMessage = emptyMessage
        self.showsSymbols = showsSymbols
    }

    public var body: some View {
        let tokens = theme.lineChart
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

    private func chartPlot(tokens: any HIGLineChartTokens, minHeight: CGFloat) -> some View {
        Chart(points) { point in
            LineMark(
                x: .value("Category", point.label),
                y: .value("Value", point.value)
            )
            .foregroundStyle(theme.colors.accent)
            .lineStyle(StrokeStyle(lineWidth: tokens.lineWidth, lineCap: .round, lineJoin: .round))
            .interpolationMethod(.catmullRom)

            if showsSymbols {
                PointMark(
                    x: .value("Category", point.label),
                    y: .value("Value", point.value)
                )
                .foregroundStyle(theme.colors.accent)
                .symbolSize(tokens.symbolSize)
            }
        }
        .chartXAxis {
            AxisMarks { _ in
                AxisGridLine(stroke: StrokeStyle(lineWidth: tokens.borderWidth))
                    .foregroundStyle(theme.colors.separator)
                AxisValueLabel()
                    .foregroundStyle(theme.colors.labelSecondary)
            }
        }
        .chartYAxis {
            AxisMarks { _ in
                AxisGridLine(stroke: StrokeStyle(lineWidth: tokens.borderWidth))
                    .foregroundStyle(theme.colors.separator)
                AxisValueLabel()
                    .foregroundStyle(theme.colors.labelSecondary)
            }
        }
        .frame(maxWidth: .infinity, minHeight: minHeight)
        .accessibilityHidden(true)
    }

    private var accessibilityLabelText: String {
        title ?? "Line chart"
    }

    private var accessibilityValueText: String {
        guard !points.isEmpty else { return emptyMessage }
        return points
            .map { "\($0.label): \($0.value)" }
            .joined(separator: ", ")
    }
}

#if DEBUG
#Preview("HIGLineChart") {
    HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        HIGLineChart(
            "Weekly signups",
            points: [
                HIGChartPoint(label: "Mon", value: 12),
                HIGChartPoint(label: "Tue", value: 18),
                HIGChartPoint(label: "Wed", value: 15),
                HIGChartPoint(label: "Thu", value: 24),
                HIGChartPoint(label: "Fri", value: 21),
            ]
        )
        .padding()
    }
}
#endif
