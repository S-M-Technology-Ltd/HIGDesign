import HIGDesign
import SwiftUI

struct ShowcaseHeroView: View {
    @Environment(\.higTheme) private var theme

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                ShowcaseMetadataView(component: .hero)

                VStack(spacing: theme.spacing.screenEdge) {
                    ShowcaseSampleView(code: """
                    HIGHero(
                        "Welcome back",
                        subtitle: "Review dashboards and reports.",
                        style: .standard
                    ) {
                        HIGButton("Open dashboard") {}
                    }
                    """) {
                        HIGHero(
                            "Welcome back",
                            subtitle: "Review dashboards, users, and reports from one place.",
                            style: .standard
                        ) {
                            HIGButton("Open dashboard") {}
                        }
                    }

                    ShowcaseSampleView(code: """
                    HIGHero(
                        "Ship faster",
                        subtitle: "HIG-native admin components.",
                        style: .accent,
                        alignment: .center
                    ) {
                        HIGButton("Get started") {}
                    }
                    """) {
                        HIGHero(
                            "Ship faster",
                            subtitle: "HIG-native admin components for every Apple platform.",
                            style: .accent,
                            alignment: .center
                        ) {
                            HIGButtonGroup {
                                HIGButton("Get started") {}
                                HIGButton("Learn more", role: .secondary) {}
                            }
                        }
                    }
                }
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle("Hero")
    }
}

#if DEBUG
#Preview("ShowcaseHeroView") {
    ShowcasePreviewContainer {
        ShowcaseHeroView()
    }
}
#endif
