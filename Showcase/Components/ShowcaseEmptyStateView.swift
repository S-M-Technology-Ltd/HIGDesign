import HIGDesign
import SwiftUI

struct ShowcaseEmptyStateView: View {
    @Environment(\.higTheme) private var theme

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                ShowcaseMetadataView(component: .emptyState)

                VStack(spacing: theme.spacing.screenEdge) {
                    ShowcaseSampleView(code: """
                    HIGEmptyState(
                        "No messages",
                        message: "When you receive mail, it will show up here.",
                        systemImage: "envelope"
                    ) {
                        HIGButton("Compose", role: .primary) {}
                    }
                    """) {
                        HIGEmptyState(
                            "No messages",
                            message: "When you receive mail, it will show up here.",
                            systemImage: "envelope"
                        ) {
                            HIGButton("Compose", role: .primary) {}
                        }
                        .background(theme.colors.backgroundSecondary)
                        .clipShape(RoundedRectangle(cornerRadius: theme.card.cornerRadius, style: .continuous))
                    }

                    ShowcaseSampleView(code: """
                    HIGEmptyState("Nothing here yet")
                    """) {
                        HIGEmptyState("Nothing here yet")
                            .background(theme.colors.backgroundSecondary)
                            .clipShape(RoundedRectangle(cornerRadius: theme.card.cornerRadius, style: .continuous))
                    }
                }
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle("Empty State")
    }
}

#if DEBUG
#Preview("ShowcaseEmptyStateView") {
    ShowcasePreviewContainer {
        ShowcaseEmptyStateView()
    }
}
#endif
