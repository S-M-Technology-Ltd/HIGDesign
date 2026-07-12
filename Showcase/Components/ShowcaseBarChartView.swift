import HIGDesign
import SwiftUI

struct ShowcaseBarChartView: View {
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

    private let products: [HIGChartPoint] = [
        HIGChartPoint(label: "Pro", value: 120),
        HIGChartPoint(label: "Team", value: 86),
        HIGChartPoint(label: "Free", value: 210),
    ]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                ShowcaseMetadataView(component: .barChart)

                VStack(spacing: theme.spacing.screenEdge) {
                    ShowcaseSampleView(code: """
                    HIGBarChart(
                        "Weekly traffic",
                        points: weekly
                    )
                    """) {
                        HIGBarChart("Weekly traffic", points: weekly)
                    }

                    ShowcaseSampleView(code: """
                    HIGBarChart("Plan mix", points: products)
                    """) {
                        HIGBarChart("Plan mix", points: products)
                    }

                    ShowcaseSampleView(code: """
                    HIGBarChart(points: [], emptyMessage: "No metrics yet")
                    """) {
                        HIGBarChart(points: [], emptyMessage: "No metrics yet")
                    }
                }
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle("Bar Chart")
    }
}

#if DEBUG
#Preview("ShowcaseBarChartView") {
    ShowcasePreviewContainer {
        ShowcaseBarChartView()
    }
}
#endif
