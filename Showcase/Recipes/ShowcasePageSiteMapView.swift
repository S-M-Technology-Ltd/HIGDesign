import HIGDesign
import SwiftUI

struct ShowcasePageSiteMapView: View {
    @Environment(\.higTheme) private var theme
    @State private var expanded: Set<String> = ["apps", "pages"]

    var body: some View {
        ShowcaseRecipeLayoutView(
            component: .pageSiteMap,
            code: """
            HIGPageHeader("Site map")
            HIGTreeView(nodes: …, expandedIDs: $expanded)
            """
        ) {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                HIGPageHeader(
                    "Site map",
                    subtitle: "Hierarchical overview of admin destinations."
                )
                HIGTreeView(
                    nodes: [
                        HIGTreeNode(
                            id: "apps",
                            title: "Apps",
                            children: [
                                HIGTreeNode(id: "mailbox", title: "Mailbox"),
                                HIGTreeNode(id: "calendar", title: "Calendar"),
                                HIGTreeNode(id: "contacts", title: "Contacts"),
                            ]
                        ),
                        HIGTreeNode(
                            id: "pages",
                            title: "Pages",
                            children: [
                                HIGTreeNode(id: "login", title: "Login"),
                                HIGTreeNode(id: "profile", title: "Profile"),
                                HIGTreeNode(id: "invoice", title: "Invoice"),
                            ]
                        ),
                    ],
                    expandedIDs: $expanded
                )
            }
        }
    }
}

#if DEBUG
#Preview("ShowcasePageSiteMapView") {
    ShowcasePreviewContainer { ShowcasePageSiteMapView() }
}
#endif
