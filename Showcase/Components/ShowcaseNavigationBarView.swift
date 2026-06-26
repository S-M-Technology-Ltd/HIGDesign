import HIGDesign
import SwiftUI

struct ShowcaseNavigationBarView: View {
    @Environment(\.higTheme) private var theme
    var body: some View {
        NavigationStack {
            HIGNavigationBar("Inbox", displayMode: .large) {
                ScrollView {
                    VStack(alignment: .leading, spacing: theme.spacing.section) {
                        ShowcaseMetadataView(component: .navigationBar)

                        Text("Composable navigation titles with leading and trailing actions.")
                            .foregroundStyle(theme.colors.labelSecondary)

                        ShowcaseCodeSnippetView(code: """
                        HIGNavigationBar("Inbox", displayMode: .large) {
                            // content
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
                        """)
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
    ShowcasePreviewContainer(includeNavigationStack: false) {
        ShowcaseNavigationBarView()
    }
}
#endif