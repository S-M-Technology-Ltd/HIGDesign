import HIGDesign
import SwiftUI

struct ShowcaseCoverView: View {
    @Environment(\.higTheme) private var theme

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                ShowcaseMetadataView(component: .cover)

                VStack(spacing: theme.spacing.screenEdge) {
                    ShowcaseSampleView(code: """
                    HIGCover(
                        "Product launch",
                        subtitle: "…",
                        style: .accent
                    )
                    """) {
                        HIGCover(
                            "Product launch",
                            subtitle: "Ship admin surfaces that feel native on every Apple platform.",
                            style: .accent
                        )
                    }

                    ShowcaseSampleView(code: """
                    HIGCover(
                        "Team workspace",
                        subtitle: "…",
                        style: .neutral,
                        alignment: .center
                    ) {
                        HIGButton("Invite", role: .secondary) { /* … */ }
                    }
                    """) {
                        HIGCover(
                            "Team workspace",
                            subtitle: "Invite teammates and share dashboards.",
                            style: .neutral,
                            alignment: .center
                        ) {
                            HIGButton("Invite", role: .secondary) {}
                        }
                    }

                    ShowcaseSampleView(code: """
                    HIGCover(
                        "Gallery banner",
                        showsScrim: true,
                        background: { /* media or gradient */ }
                    )
                    """) {
                        HIGCover(
                            "Gallery banner",
                            subtitle: "Custom backgrounds pair with an optional scrim.",
                            showsScrim: true,
                            background: {
                                LinearGradient(
                                    colors: [
                                        theme.colors.accent,
                                        theme.colors.fillPrimary
                                    ],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            }
                        )
                    }
                }
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle("Cover")
    }
}

#if DEBUG
#Preview("ShowcaseCoverView") {
    ShowcasePreviewContainer {
        ShowcaseCoverView()
    }
}
#endif
