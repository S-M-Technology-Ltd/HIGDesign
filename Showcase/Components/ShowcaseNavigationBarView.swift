import HIGDesign
import SwiftUI

struct ShowcaseNavigationBarView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    ShowcaseMetadataView(component: .navigationBar)

                    Text("This screen uses the composable higNavigationBar API with leading and trailing actions.")
                        .foregroundStyle(.secondary)
                }
                .higPadding(.screenEdge)
            }
            .higNavigationBar("Inbox", displayMode: .large) {
                HIGNavigationBarIconAction(
                    "line.3.horizontal.decrease.circle",
                    accessibilityLabel: "Filter"
                ) {}
            } trailing: {
                HIGNavigationBarIconAction(
                    "square.and.pencil",
                    accessibilityLabel: "Compose"
                ) {}
            }
        }
        .navigationTitle("Navigation Bar")
    }
}

#if DEBUG
#Preview("ShowcaseNavigationBarView") {
    ShowcaseNavigationBarView()
}
#endif