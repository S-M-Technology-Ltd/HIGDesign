import HIGDesign
import SwiftUI

struct ShowcasePageSearchResultView: View {
    @Environment(\.higTheme) private var theme
    @State private var query = "admin shell"

    var body: some View {
        ShowcaseRecipeLayoutView(
            component: .pageSearchResult,
            code: """
            HIGSearchField("Search", text: $query)
            HIGListGroup { HIGListGroupRow(…) }
            """
        ) {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                HIGPageHeader(
                    "Search results",
                    subtitle: "Query chrome plus result rows for site search."
                )
                HIGSearchField("Search", text: $query, placeholder: "Search the admin console")
                HIGListGroup(header: "3 results for “\(query)”") {
                    HIGListGroupRow(
                        "Admin shell styles",
                        subtitle: "Navigation · HIGAdminShell",
                        systemImage: "rectangle.split.3x1",
                        showsChevron: true
                    ) {}
                    HIGDivider()
                    HIGListGroupRow(
                        "Page header",
                        subtitle: "Navigation · HIGPageHeader",
                        systemImage: "textformat",
                        showsChevron: true
                    ) {}
                    HIGDivider()
                    HIGListGroupRow(
                        "Dashboard grid",
                        subtitle: "Layout · HIGDashboardGrid",
                        systemImage: "square.grid.2x2",
                        showsChevron: true
                    ) {}
                }
            }
        }
    }
}

#if DEBUG
#Preview("ShowcasePageSearchResultView") {
    ShowcasePreviewContainer { ShowcasePageSearchResultView() }
}
#endif
