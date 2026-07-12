import HIGDesign
import SwiftUI

struct ShowcaseWidgetView: View {
    @Environment(\.higTheme) private var theme

    private let weekly: [HIGChartPoint] = [
        HIGChartPoint(label: "Mon", value: 42),
        HIGChartPoint(label: "Tue", value: 58),
        HIGChartPoint(label: "Wed", value: 35),
        HIGChartPoint(label: "Thu", value: 71),
        HIGChartPoint(label: "Fri", value: 64),
    ]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                ShowcaseMetadataView(component: .widget)

                VStack(spacing: theme.spacing.screenEdge) {
                    ShowcaseSampleView(code: """
                    HIGWidget("Active users", subtitle: "Last 7 days") {
                        HIGCounter(
                            "Users",
                            value: "1,284",
                            trend: .up,
                            trendLabel: "+12%"
                        )
                    }
                    """) {
                        HIGWidget("Active users", subtitle: "Last 7 days") {
                            HIGCounter(
                                "Users",
                                value: "1,284",
                                systemImage: "person.2",
                                trend: .up,
                                trendLabel: "+12%"
                            )
                        }
                    }

                    ShowcaseSampleView(code: """
                    HIGWidget("Weekly traffic") {
                        HIGBarChart(points: weekly)
                    } trailing: {
                        HIGButton("Export", role: .borderless) {}
                    }
                    """) {
                        HIGWidget("Weekly traffic") {
                            HIGBarChart(points: weekly)
                        } trailing: {
                            HIGButton("Export", role: .borderless) {}
                        }
                    }

                    ShowcaseSampleView(code: """
                    HIGWidget {
                        Text("Body-only widget for custom layouts.")
                    }
                    """) {
                        HIGWidget {
                            Text("Body-only widget for custom layouts.")
                                .font(theme.typography.body)
                                .foregroundStyle(theme.colors.labelSecondary)
                        }
                    }
                }
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle("Widget")
    }
}

#if DEBUG
#Preview("ShowcaseWidgetView") {
    ShowcasePreviewContainer {
        ShowcaseWidgetView()
    }
}
#endif
