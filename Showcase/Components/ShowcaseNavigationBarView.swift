import HIGDesign
import SwiftUI

struct ShowcaseNavigationBarView: View {
    var body: some View {
        NavigationStack {
            HIGNavigationBar("Inbox", displayMode: .large) {
                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {
                        ShowcaseMetadataView(component: .navigationBar)

                        Text("Composable navigation titles with leading and trailing actions.")
                            .foregroundStyle(.secondary)
                    }
                    .higPadding(.screenEdge)
                }
            } leading: {
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
    }
}

#if DEBUG
#Preview("ShowcaseNavigationBarView") {
    ShowcaseNavigationBarView()
}
#endif