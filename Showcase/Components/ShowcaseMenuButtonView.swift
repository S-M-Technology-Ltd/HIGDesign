import HIGDesign
import SwiftUI

struct ShowcaseMenuButtonView: View {
    @Environment(\.higTheme) private var theme
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                ShowcaseMetadataView(component: .menuButton)

                VStack(spacing: theme.spacing.screenEdge) {
                    ShowcaseSampleView(code: """
                    HIGMenuButton("Options", systemImage: "ellipsis.circle") {
                        Button("Rename") {}
                        Button("Duplicate") {}
                        Divider()
                        Button("Delete", role: .destructive) {}
                    }
                    """) {
                        HIGMenuButton("Options", systemImage: "ellipsis.circle") {
                            Button("Rename") {}
                            Button("Duplicate") {}
                            Divider()
                            Button("Delete", role: .destructive) {}
                        }
                    }

                    ShowcaseSampleView(code: """
                    HIGMenuButton("Sort By") {
                        Button("Recently Added") {}
                        Button("Title") {}
                        Button("Date Modified") {}
                    }
                    """) {
                        HIGMenuButton("Sort By") {
                            Button("Recently Added") {}
                            Button("Title") {}
                            Button("Date Modified") {}
                        }
                    }

                    ShowcaseSampleView(code: """
                    HIGMenuButton(icon: "ellipsis.circle", accessibilityLabel: "More options") {
                        Button("Share") {}
                        Button("Archive") {}
                    }
                    """) {
                        HIGMenuButton(icon: "ellipsis.circle", accessibilityLabel: "More options") {
                            Button("Share") {}
                            Button("Archive") {}
                        }
                    }
                }
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle("Menu Button")
    }
}

#if DEBUG
#Preview("ShowcaseMenuButtonView") {
    ShowcasePreviewContainer {
        ShowcaseMenuButtonView()
    }
}
#endif