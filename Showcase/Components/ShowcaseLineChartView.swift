import HIGDesign
import SwiftUI

struct ShowcaseLineChartView: View {
    @Environment(\.higTheme) private var theme

    private let weekly: [HIGChartPoint] = [
        HIGChartPoint(label: "Mon", value: 12),
        HIGChartPoint(label: "Tue", value: 18),
        HIGChartPoint(label: "Wed", value: 15),
        HIGChartPoint(label: "Thu", value: 24),
        HIGChartPoint(label: "Fri", value: 21),
        HIGChartPoint(label: "Sat", value: 9),
        HIGChartPoint(label: "Sun", value: 11),
    ]

    private let revenue: [HIGChartPoint] = [
        HIGChartPoint(label: "Jan", value: 40),
        HIGChartPoint(label: "Feb", value: 52),
        HIGChartPoint(label: "Mar", value: 48),
        HIGChartPoint(label: "Apr", value: 61),
        HIGChartPoint(label: "May", value: 55),
    ]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                ShowcaseMetadataView(component: .lineChart)

                VStack(spacing: theme.spacing.screenEdge) {
                    ShowcaseSampleView(code: """
                    HIGLineChart(
                        "Weekly signups",
                        points: weekly
                    )
                    """) {
                        HIGLineChart("Weekly signups", points: weekly)
                    }

                    ShowcaseSampleView(code: """
                    HIGLineChart(
                        "Revenue",
                        points: revenue,
                        showsSymbols: false
                    )
                    """) {
                        HIGLineChart("Revenue", points: revenue, showsSymbols: false)
                    }

                    ShowcaseSampleView(code: """
                    HIGLineChart(points: [], emptyMessage: "No metrics yet")
                    """) {
                        HIGLineChart(points: [], emptyMessage: "No metrics yet")
                    }
                }
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle("Line Chart")
    }
}

#if DEBUG
#Preview("ShowcaseLineChartView") {
    ShowcasePreviewContainer {
        ShowcaseLineChartView()
    }
}
#endif
