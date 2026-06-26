import HIGDesign
import SwiftUI

struct ShowcaseCardView: View {
    @Environment(\.higTheme) private var theme
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                ShowcaseMetadataView(component: .card)

                VStack(spacing: theme.spacing.screenEdge) {
                    ShowcaseSampleView(code: """
                    HIGCard("Notifications") {
                        Text("Choose which alerts appear on your devices.")
                    }
                    """) {
                        HIGCard("Notifications") {
                            Text("Choose which alerts appear on your devices.")
                                .foregroundStyle(theme.colors.labelSecondary)
                        }
                    }

                    ShowcaseSampleView(code: """
                    HIGCard {
                        VStack(alignment: .leading, spacing: theme.spacing.compactItem) {
                            Text("Privacy")
                            Text("Review how data is collected and shared.")
                        }
                    }
                    """) {
                        HIGCard {
                            VStack(alignment: .leading, spacing: theme.spacing.compactItem) {
                                Text("Privacy")
                                    .font(theme.typography.headline)
                                Text("Review how data is collected and shared.")
                                    .foregroundStyle(theme.colors.labelSecondary)
                            }
                        }
                    }
                }
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle("Card")
    }
}

#if DEBUG
#Preview("ShowcaseCardView") {
    ShowcasePreviewContainer {
        ShowcaseCardView()
    }
}
#endif