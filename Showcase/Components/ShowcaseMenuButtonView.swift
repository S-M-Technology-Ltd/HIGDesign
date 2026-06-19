import HIGDesign
import SwiftUI

struct ShowcaseMenuButtonView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                ShowcaseMetadataView(component: .menuButton)

                VStack(spacing: 16) {
                    HIGMenuButton("Options", systemImage: "ellipsis.circle") {
                        Button("Rename") {}
                        Button("Duplicate") {}
                        Divider()
                        Button("Delete", role: .destructive) {}
                    }

                    HIGMenuButton("Sort By") {
                        Button("Recently Added") {}
                        Button("Title") {}
                        Button("Date Modified") {}
                    }

                    HIGMenuButton(icon: "ellipsis.circle", accessibilityLabel: "More options") {
                        Button("Share") {}
                        Button("Archive") {}
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
    ShowcaseMenuButtonView()
}
#endif