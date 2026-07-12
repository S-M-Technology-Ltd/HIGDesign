import Charts
import HIGPlatform
import HIGThemesContract
import HIGTokensComponent
import SwiftUI

/// A themed area chart for admin dashboards and filled trend series.
///
/// Built on Apple Swift Charts (no third-party chart libraries). Reuses ``HIGChartPoint``
/// for ordered categorical values with a filled area and optional stroke line.
public struct HIGAreaChart: View {
    private let title: String?
    private let points: [HIGChartPoint]
    private let emptyMessage: String
    private let showsLine: Bool

    @Environment(\.higTheme) private var theme
    @Environment(\.isEnabled) private var isEnabled

    /// Creates an area chart.
    /// - Parameters:
    ///   - title: Optional chart title above the plot.
    ///   - points: Ordered values along the series.
    ///   - emptyMessage: Shown when `points` is empty.
    ///   - showsLine: When `true`, draws a stroke line along the area edge.
    public init(
        _ title: String? = nil,
        points: [HIGChartPoint],
        emptyMessage: String = "No data",
        showsLine: Bool = true
    ) {
        self.title = title
        self.points = points
        self.emptyMessage = emptyMessage
        self.showsLine = showsLine
    }

    public var body: some View {
        let tokens = theme.areaChart
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

    private func chartPlot(tokens: any HIGAreaChartTokens, minHeight: CGFloat) -> some View {
        Chart(points) { point in
            AreaMark(
                x: .value("Category", point.label),
                y: .value("Value", point.value)
            )
            .foregroundStyle(theme.colors.accent.opacity(theme.opacity.subtleFill))
            .interpolationMethod(.catmullRom)

            if showsLine {
                LineMark(
                    x: .value("Category", point.label),
                    y: .value("Value", point.value)
                )
                .foregroundStyle(theme.colors.accent)
                .lineStyle(StrokeStyle(lineWidth: tokens.lineWidth, lineCap: .round, lineJoin: .round))
                .interpolationMethod(.catmullRom)
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
        title ?? "Area chart"
    }

    private var accessibilityValueText: String {
        guard !points.isEmpty else { return emptyMessage }
        return points
            .map { "\($0.label): \($0.value)" }
            .joined(separator: ", ")
    }
}

#if DEBUG
#Preview("HIGAreaChart") {
    HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        HIGAreaChart(
            "Weekly traffic",
            points: [
                HIGChartPoint(label: "Mon", value: 42),
                HIGChartPoint(label: "Tue", value: 58),
                HIGChartPoint(label: "Wed", value: 35),
                HIGChartPoint(label: "Thu", value: 71),
                HIGChartPoint(label: "Fri", value: 64),
            ]
        )
        .padding()
    }
}
#endif
