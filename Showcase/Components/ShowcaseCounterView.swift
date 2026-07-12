import HIGDesign
import SwiftUI

struct ShowcaseCounterView: View {
    @Environment(\.higTheme) private var theme

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                ShowcaseMetadataView(component: .counter)

                VStack(spacing: theme.spacing.screenEdge) {
                    ShowcaseSampleView(code: """
                    HIGCounter(
                        "Active users",
                        value: "1,284",
                        caption: "Last 7 days",
                        systemImage: "person.2",
                        trend: .up,
                        trendLabel: "+12%"
                    )
                    """) {
                        HIGCounter(
                            "Active users",
                            value: "1,284",
                            caption: "Last 7 days",
                            systemImage: "person.2",
                            trend: .up,
                            trendLabel: "+12%"
                        )
                    }

                    ShowcaseSampleView(code: """
                    HIGCounter(
                        "Bounce rate",
                        value: "42%",
                        trend: .down,
                        trendLabel: "-3.1%"
                    )
                    """) {
                        HIGCounter(
                            "Bounce rate",
                            value: "42%",
                            trend: .down,
                            trendLabel: "-3.1%"
                        )
                    }

                    ShowcaseSampleView(code: """
                    HIGCounter(
                        "Open tickets",
                        value: "18",
                        systemImage: "ticket",
                        trend: .neutral,
                        trendLabel: "0%"
                    )
                    """) {
                        HIGCounter(
                            "Open tickets",
                            value: "18",
                            systemImage: "ticket",
                            trend: .neutral,
                            trendLabel: "0%"
                        )
                    }
                }
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle("Counter")
    }
}

#if DEBUG
#Preview("ShowcaseCounterView") {
    ShowcasePreviewContainer {
        ShowcaseCounterView()
    }
}
#endif
