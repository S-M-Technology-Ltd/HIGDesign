import HIGDesign
import SwiftUI

struct ShowcaseLabelView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                ShowcaseMetadataView(component: .label)

                VStack(alignment: .leading, spacing: 16) {
                    HIGLabel("Notifications", subtitle: "Choose alert delivery", style: .primary)
                    HIGLabel("Last synced", subtitle: "2 minutes ago", style: .secondary)
                    HIGLabel("Optional detail", style: .caption)
                }
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle("Label")
    }
}

#if DEBUG
#Preview("ShowcaseLabelView") {
    ShowcaseLabelView()
}
#endif