import HIGDesign
import SwiftUI

struct ShowcaseToolbarView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                ShowcaseMetadataView(component: .toolbar)

                Text("Use the toolbar actions in the navigation bar above.")
                    .foregroundStyle(.secondary)
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle("Documents")
        .higToolbar {
            ToolbarItem(placement: .cancellationAction) {
                HIGToolbarTextAction("Close") {}
            }
            ToolbarItem(placement: .primaryAction) {
                HIGToolbarIconAction("plus", accessibilityLabel: "Add") {}
            }
        }
    }
}

#if DEBUG
#Preview("ShowcaseToolbarView") {
    NavigationStack {
        ShowcaseToolbarView()
    }
}
#endif