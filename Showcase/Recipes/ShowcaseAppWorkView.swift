import HIGDesign
import SwiftUI

struct ShowcaseAppWorkView: View {
    @Environment(\.higTheme) private var theme

    private let throughput: [HIGChartPoint] = [
        HIGChartPoint(label: "W1", value: 32),
        HIGChartPoint(label: "W2", value: 40),
        HIGChartPoint(label: "W3", value: 28),
        HIGChartPoint(label: "W4", value: 51),
    ]

    var body: some View {
        ShowcaseRecipeLayoutView(
            component: .appWork,
            code: """
            HIGDashboardGrid("Work") {
                HIGCounter(…)
                HIGWidget("Throughput") { HIGLineChart(…) }
            }
            """
        ) {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                HIGPageHeader(
                    "Work",
                    subtitle: "Team workload dashboard with counters and trend charts."
                )
                HIGDashboardGrid("Work") {
                    HIGCounter(
                        "Open tasks",
                        value: "126",
                        caption: "Across squads",
                        systemImage: "checklist",
                        trend: .down,
                        trendLabel: "-4%"
                    )
                    HIGCounter(
                        "Cycle time",
                        value: "3.2d",
                        systemImage: "timer",
                        trend: .down,
                        trendLabel: "-0.4d"
                    )
                    HIGWidget("Throughput", subtitle: "Stories / week") {
                        HIGLineChart(points: throughput)
                    }
                }
            }
        }
    }
}

#if DEBUG
#Preview("ShowcaseAppWorkView") {
    ShowcasePreviewContainer {
        ShowcaseAppWorkView()
    }
}
#endif
