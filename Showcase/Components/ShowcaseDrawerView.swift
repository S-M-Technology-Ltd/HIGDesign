import HIGDesign
import SwiftUI

struct ShowcaseDrawerView: View {
    @Environment(\.higTheme) private var theme
    @State private var isTrailingPresented = false
    @State private var isLeadingPresented = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                ShowcaseMetadataView(component: .drawer)

                VStack(spacing: theme.spacing.screenEdge) {
                    ShowcaseSampleView(code: """
                    HIGDrawer(title: "Details", onDismiss: {}) {
                        Text("Secondary content")
                    }
                    """) {
                        HIGDrawer(title: "Details", onDismiss: {}) {
                            Text("Secondary content for the selected row.")
                                .font(theme.typography.body)
                                .foregroundStyle(theme.colors.labelSecondary)
                        }
                    }

                    ShowcaseSampleView(code: """
                    content.higDrawer(
                        isPresented: $isPresented,
                        edge: .trailing,
                        title: "Inspector"
                    ) {
                        Text("Drawer body")
                    }
                    """) {
                        VStack(alignment: .leading, spacing: theme.spacing.item) {
                            HIGButton("Open trailing drawer", role: .secondary) {
                                isTrailingPresented = true
                            }
                            HIGButton("Open leading drawer", role: .secondary) {
                                isLeadingPresented = true
                            }
                        }
                        .frame(maxWidth: .infinity, minHeight: theme.drawer.width, alignment: .topLeading)
                        .higDrawer(
                            isPresented: $isTrailingPresented,
                            edge: .trailing,
                            title: "Inspector"
                        ) {
                            Text("Trailing drawer body.")
                                .font(theme.typography.body)
                                .foregroundStyle(theme.colors.labelSecondary)
                        }
                        .higDrawer(
                            isPresented: $isLeadingPresented,
                            edge: .leading,
                            title: "Menu"
                        ) {
                            Text("Leading drawer body.")
                                .font(theme.typography.body)
                                .foregroundStyle(theme.colors.labelSecondary)
                        }
                    }
                }
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle("Drawer")
    }
}

#if DEBUG
#Preview("ShowcaseDrawerView") {
    ShowcasePreviewContainer {
        ShowcaseDrawerView()
    }
}
#endif
