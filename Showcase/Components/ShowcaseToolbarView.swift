import HIGDesign
import SwiftUI

struct ShowcaseToolbarView: View {
    @Environment(\.higTheme) private var theme
    var body: some View {
        NavigationStack {
            HIGToolbar {
                ScrollView {
                    VStack(alignment: .leading, spacing: theme.spacing.section) {
                        ShowcaseMetadataView(component: .toolbar)

                        Text("Use the toolbar actions in the navigation bar above.")
                            .foregroundStyle(theme.colors.labelSecondary)

                        ShowcaseCodeSnippetView(code: """
                        HIGToolbar {
                            // content
                        } toolbar: {
                            ToolbarItem(placement: .cancellationAction) {
                                HIGToolbarTextAction("Close") {}
                            }
                            ToolbarItem(placement: .primaryAction) {
                                HIGToolbarIconAction("plus", accessibilityLabel: "Add") {}
                            }
                        }
                        """)
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
    ShowcasePreviewContainer(includeNavigationStack: false) {
        ShowcaseToolbarView()
    }
}
#endif