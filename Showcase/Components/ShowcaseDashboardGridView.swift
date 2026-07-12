import HIGDesign
import SwiftUI

struct ShowcaseDashboardGridView: View {
    @Environment(\.higTheme) private var theme

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                ShowcaseMetadataView(component: .dashboardGrid)

                VStack(spacing: theme.spacing.screenEdge) {
                    ShowcaseSampleView(code: """
                    HIGDashboardGrid("Overview") {
                        HIGCounter(…)
                        HIGCounter(…)
                        HIGWidget(…)
                    }
                    """) {
                        HIGDashboardGrid("Overview") {
                            HIGCounter(
                                "Users",
                                value: "1,284",
                                caption: "Last 7 days",
                                systemImage: "person.2",
                                trend: .up,
                                trendLabel: "+12%"
                            )
                            HIGCounter(
                                "Sessions",
                                value: "8,420",
                                caption: "Last 7 days",
                                systemImage: "chart.line.uptrend.xyaxis",
                                trend: .up,
                                trendLabel: "+6%"
                            )
                            HIGCounter(
                                "Bounce",
                                value: "42%",
                                systemImage: "arrow.uturn.left",
                                trend: .down,
                                trendLabel: "-3%"
                            )
                            HIGWidget("Notes", subtitle: "Ops") {
                                Text("Adaptive columns reflow as width changes.")
                                    .font(theme.typography.caption)
                                    .foregroundStyle(theme.colors.labelSecondary)
                            }
                        }
                    }

                    ShowcaseSampleView(code: """
                    HIGDashboardGrid {
                        HIGPanel("Alpha") { … }
                        HIGPanel("Beta") { … }
                    }
                    """) {
                        HIGDashboardGrid {
                            HIGPanel("Alpha", description: "Primary panel") {
                                Text("Panel body A")
                                    .font(theme.typography.callout)
                                    .foregroundStyle(theme.colors.labelPrimary)
                            }
                            HIGPanel("Beta", description: "Secondary panel") {
                                Text("Panel body B")
                                    .font(theme.typography.callout)
                                    .foregroundStyle(theme.colors.labelPrimary)
                            }
                        }
                    }
                }
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle("Dashboard Grid")
    }
}

#if DEBUG
#Preview("ShowcaseDashboardGridView") {
    ShowcasePreviewContainer {
        ShowcaseDashboardGridView()
    }
}
#endif
