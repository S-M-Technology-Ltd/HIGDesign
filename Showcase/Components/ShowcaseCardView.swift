import HIGDesign
import SwiftUI

struct ShowcaseCardView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                ShowcaseMetadataView(component: .card)

                VStack(spacing: 16) {
                    HIGCard("Notifications") {
                        Text("Choose which alerts appear on your devices.")
                            .foregroundStyle(.secondary)
                    }

                    HIGCard {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Privacy")
                                .font(.headline)
                            Text("Review how data is collected and shared.")
                                .foregroundStyle(.secondary)
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
    ShowcaseCardView()
}
#endif