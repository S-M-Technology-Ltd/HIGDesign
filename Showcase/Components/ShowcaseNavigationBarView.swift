import HIGDesign
import SwiftUI

struct ShowcaseNavigationBarView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    ShowcaseMetadataView(component: .navigationBar)

                    Text("This screen uses a large navigation title via higNavigationBarTitle.")
                        .foregroundStyle(.secondary)
                }
                .higPadding(.screenEdge)
            }
            .higNavigationBarTitle("Inbox", displayMode: .large)
        }
        .navigationTitle("Navigation Bar")
    }
}

#if DEBUG
#Preview("ShowcaseNavigationBarView") {
    ShowcaseNavigationBarView()
}
#endif