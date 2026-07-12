import HIGDesign
import SwiftUI

struct ShowcaseAppTravelView: View {
    @Environment(\.higTheme) private var theme

    private let bookings: [HIGChartPoint] = [
        HIGChartPoint(label: "Mon", value: 12),
        HIGChartPoint(label: "Tue", value: 18),
        HIGChartPoint(label: "Wed", value: 9),
        HIGChartPoint(label: "Thu", value: 22),
        HIGChartPoint(label: "Fri", value: 16),
    ]

    var body: some View {
        ShowcaseRecipeLayoutView(
            component: .appTravel,
            code: """
            HIGDashboardGrid("Travel ops") {
                HIGCounter(…)
                HIGWidget("Bookings") { HIGBarChart(…) }
            }
            """
        ) {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                HIGPageHeader(
                    "Travel",
                    subtitle: "Ops dashboard for trips and bookings using widgets and charts."
                )
                HIGDashboardGrid("Travel ops") {
                    HIGCounter(
                        "Trips",
                        value: "48",
                        caption: "This week",
                        systemImage: "airplane",
                        trend: .up,
                        trendLabel: "+8%"
                    )
                    HIGCounter(
                        "On time",
                        value: "94%",
                        systemImage: "clock",
                        trend: .up,
                        trendLabel: "+2%"
                    )
                    HIGWidget("Bookings", subtitle: "Last 5 days") {
                        HIGBarChart(points: bookings)
                    }
                }
            }
        }
    }
}

#if DEBUG
#Preview("ShowcaseAppTravelView") {
    ShowcasePreviewContainer {
        ShowcaseAppTravelView()
    }
}
#endif
