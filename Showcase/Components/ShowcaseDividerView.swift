import HIGDesign
import SwiftUI

struct ShowcaseDividerView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                ShowcaseMetadataView(component: .divider)

                VStack(alignment: .leading, spacing: 12) {
                    Text("Account")
                        .font(.headline)
                    Text("Manage profile and security settings.")
                        .foregroundStyle(.secondary)
                    HIGDivider()
                    Text("Preferences")
                        .font(.headline)
                    Text("Theme, accessibility, and notification defaults.")
                        .foregroundStyle(.secondary)
                }
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle("Divider")
    }
}

#if DEBUG
#Preview("ShowcaseDividerView") {
    ShowcaseDividerView()
}
#endif