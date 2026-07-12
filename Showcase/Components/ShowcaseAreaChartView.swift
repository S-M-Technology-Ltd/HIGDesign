import HIGDesign
import SwiftUI

struct ShowcaseAreaChartView: View {
    @Environment(\.higTheme) private var theme

    private let weekly: [HIGChartPoint] = [
        HIGChartPoint(label: "Mon", value: 42),
        HIGChartPoint(label: "Tue", value: 58),
        HIGChartPoint(label: "Wed", value: 35),
        HIGChartPoint(label: "Thu", value: 71),
        HIGChartPoint(label: "Fri", value: 64),
        HIGChartPoint(label: "Sat", value: 28),
        HIGChartPoint(label: "Sun", value: 22),
    ]

    private let sessions: [HIGChartPoint] = [
        HIGChartPoint(label: "00", value: 12),
        HIGChartPoint(label: "04", value: 8),
        HIGChartPoint(label: "08", value: 34),
        HIGChartPoint(label: "12", value: 56),
        HIGChartPoint(label: "16", value: 48),
        HIGChartPoint(label: "20", value: 29),
    ]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                ShowcaseMetadataView(component: .areaChart)

                VStack(spacing: theme.spacing.screenEdge) {
                    ShowcaseSampleView(code: """
                    HIGAreaChart(
                        "Weekly traffic",
                        points: weekly
                    )
                    """) {
                        HIGAreaChart("Weekly traffic", points: weekly)
                    }

                    ShowcaseSampleView(code: """
                    HIGAreaChart(
                        "Sessions",
                        points: sessions,
                        showsLine: false
                    )
                    """) {
                        HIGAreaChart("Sessions", points: sessions, showsLine: false)
                    }

                    ShowcaseSampleView(code: """
                    HIGAreaChart(points: [], emptyMessage: "No metrics yet")
                    """) {
                        HIGAreaChart(points: [], emptyMessage: "No metrics yet")
                    }
                }
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle("Area Chart")
    }
}

#if DEBUG
#Preview("ShowcaseAreaChartView") {
    ShowcasePreviewContainer {
        ShowcaseAreaChartView()
    }
}
#endif
