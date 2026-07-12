import HIGDesign
import SwiftUI

struct ShowcaseTreeViewView: View {
    @Environment(\.higTheme) private var theme
    @State private var expanded: Set<String> = ["docs", "guides"]
    @State private var selection: String? = "intro"

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                ShowcaseMetadataView(component: .treeView)

                VStack(spacing: theme.spacing.screenEdge) {
                    ShowcaseSampleView(code: """
                    HIGTreeView(
                        nodes: […],
                        expandedIDs: $expanded,
                        selection: $selection
                    )
                    """) {
                        VStack(alignment: .leading, spacing: theme.spacing.item) {
                            HIGTreeView(
                                nodes: sampleNodes,
                                expandedIDs: $expanded,
                                selection: $selection
                            )
                            Text("Selected: \(selection ?? "none")")
                                .font(theme.typography.caption)
                                .foregroundStyle(theme.colors.labelSecondary)
                        }
                    }

                    ShowcaseSampleView(code: """
                    // Start collapsed
                    HIGTreeView(nodes: […], expandedIDs: $expanded)
                    """) {
                        ShowcaseTreeCollapsedDemoView()
                    }
                }
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle("Tree View")
    }

    private var sampleNodes: [HIGTreeNode] {
        [
            HIGTreeNode(
                id: "docs",
                title: "Documentation",
                systemImage: "folder",
                children: [
                    HIGTreeNode(id: "intro", title: "Introduction", systemImage: "doc.text"),
                    HIGTreeNode(
                        id: "guides",
                        title: "Guides",
                        systemImage: "folder",
                        children: [
                            HIGTreeNode(id: "tokens", title: "Tokens", systemImage: "doc.text"),
                            HIGTreeNode(id: "themes", title: "Themes", systemImage: "doc.text")
                        ]
                    )
                ]
            ),
            HIGTreeNode(id: "settings", title: "Settings", systemImage: "gearshape")
        ]
    }
}

private struct ShowcaseTreeCollapsedDemoView: View {
    @State private var expanded: Set<String> = []

    var body: some View {
        HIGTreeView(
            nodes: [
                HIGTreeNode(
                    id: "projects",
                    title: "Projects",
                    systemImage: "folder",
                    children: [
                        HIGTreeNode(id: "alpha", title: "Alpha", systemImage: "doc"),
                        HIGTreeNode(id: "beta", title: "Beta", systemImage: "doc")
                    ]
                )
            ],
            expandedIDs: $expanded
        )
    }
}

#if DEBUG
#Preview("ShowcaseTreeViewView") {
    ShowcasePreviewContainer {
        ShowcaseTreeViewView()
    }
}
#endif
