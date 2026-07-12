import HIGDesign
import SwiftUI

struct ShowcasePieChartView: View {
    @Environment(\.higTheme) private var theme

    private let plans: [HIGChartPoint] = [
        HIGChartPoint(label: "Pro", value: 120),
        HIGChartPoint(label: "Team", value: 86),
        HIGChartPoint(label: "Free", value: 210),
    ]

    private let regions: [HIGChartPoint] = [
        HIGChartPoint(label: "Americas", value: 42),
        HIGChartPoint(label: "EMEA", value: 31),
        HIGChartPoint(label: "APAC", value: 27),
    ]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                ShowcaseMetadataView(component: .pieChart)

                VStack(spacing: theme.spacing.screenEdge) {
                    ShowcaseSampleView(code: """
                    HIGPieChart(
                        "Plan mix",
                        points: plans
                    )
                    """) {
                        HIGPieChart("Plan mix", points: plans)
                    }

                    ShowcaseSampleView(code: """
                    HIGPieChart(
                        "Revenue by region",
                        points: regions,
                        style: .donut
                    )
                    """) {
                        HIGPieChart("Revenue by region", points: regions, style: .donut)
                    }

                    ShowcaseSampleView(code: """
                    HIGPieChart(points: [], emptyMessage: "No metrics yet")
                    """) {
                        HIGPieChart(points: [], emptyMessage: "No metrics yet")
                    }
                }
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle("Pie Chart")
    }
}

#if DEBUG
#Preview("ShowcasePieChartView") {
    ShowcasePreviewContainer {
        ShowcasePieChartView()
    }
}
#endif
