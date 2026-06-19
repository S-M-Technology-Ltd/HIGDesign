import HIGDesign
import SwiftUI

struct ShowcaseToolbarView: View {
    var body: some View {
        NavigationStack {
            HIGToolbar {
                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {
                        ShowcaseMetadataView(component: .toolbar)

                        Text("Use the toolbar actions in the navigation bar above.")
                            .foregroundStyle(.secondary)
                    }
                    .higPadding(.screenEdge)
                }
            } toolbar: {
                ToolbarItem(placement: .cancellationAction) {
                    HIGToolbarTextAction("Close") {}
                }
                ToolbarItem(placement: .primaryAction) {
                    HIGToolbarIconAction("plus", accessibilityLabel: "Add") {}
                }
            }
            .navigationTitle("Documents")
        }
    }
}

#if DEBUG
#Preview("ShowcaseToolbarView") {
    ShowcaseToolbarView()
}
#endif