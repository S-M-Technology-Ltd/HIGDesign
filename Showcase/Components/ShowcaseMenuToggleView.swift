import HIGDesign
import SwiftUI

struct ShowcaseMenuToggleView: View {
    @Environment(\.higTheme) private var theme
    @State private var isExpanded = false
    @State private var isDrawerPresented = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                ShowcaseMetadataView(component: .menuToggle)

                VStack(spacing: theme.spacing.screenEdge) {
                    ShowcaseSampleView(code: """
                    HIGMenuToggle(isExpanded: $isExpanded)
                    """) {
                        HStack(spacing: theme.spacing.item) {
                            HIGMenuToggle(isExpanded: $isExpanded)
                            Text(isExpanded ? "Expanded" : "Collapsed")
                                .font(theme.typography.body)
                                .foregroundStyle(theme.colors.labelSecondary)
                        }
                    }

                    ShowcaseSampleView(code: """
                    HIGMenuToggle(isExpanded: $isDrawerPresented)
                        .higDrawer(isPresented: $isDrawerPresented, title: "Navigation") {
                            Text("Drawer content")
                        }
                    """) {
                        HStack(spacing: theme.spacing.item) {
                            HIGMenuToggle(isExpanded: $isDrawerPresented)
                            Text("Opens drawer")
                                .font(theme.typography.caption)
                                .foregroundStyle(theme.colors.labelSecondary)
                        }
                        .frame(maxWidth: .infinity, minHeight: theme.drawer.width / 2, alignment: .topLeading)
                        .higDrawer(
                            isPresented: $isDrawerPresented,
                            edge: .leading,
                            title: "Navigation"
                        ) {
                            Text("Side navigation content.")
                                .font(theme.typography.body)
                                .foregroundStyle(theme.colors.labelSecondary)
                        }
                    }
                }
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle("Menu Toggle")
    }
}

#if DEBUG
#Preview("ShowcaseMenuToggleView") {
    ShowcasePreviewContainer {
        ShowcaseMenuToggleView()
    }
}
#endif
