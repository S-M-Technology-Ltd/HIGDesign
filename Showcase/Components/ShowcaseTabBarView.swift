import HIGDesign
import SwiftUI

private enum ShowcaseTab: String, Hashable, Sendable {
    case home
    case library
    case settings
}

struct ShowcaseTabBarView: View {
    @Environment(\.higTheme) private var theme
    @State private var selection = ShowcaseTab.home

    var body: some View {
        VStack(alignment: .leading, spacing: theme.spacing.screenEdge) {
            ShowcaseMetadataView(component: .tabBar)
                .higPadding(.screenEdge)

            ShowcaseCodeSnippetView(code: """
            HIGTabBar(
                selection: $selection,
                tabs: [
                    HIGTabItem(id: .home, title: "Home", systemImage: "house"),
                    HIGTabItem(id: .library, title: "Library", systemImage: "books.vertical"),
                    HIGTabItem(id: .settings, title: "Settings", systemImage: "gearshape"),
                ]
            ) { tab in
                // tab content
            }
            """)
            .higPadding(.screenEdge)

            HIGTabBar(
                selection: $selection,
                tabs: [
                    HIGTabItem(id: ShowcaseTab.home, title: "Home", systemImage: "house"),
                    HIGTabItem(id: ShowcaseTab.library, title: "Library", systemImage: "books.vertical"),
                    HIGTabItem(id: ShowcaseTab.settings, title: "Settings", systemImage: "gearshape"),
                ]
            ) { tab in
                switch tab {
                case .home:
                    tabContent(title: "Home", detail: "Featured components and updates.")
                case .library:
                    tabContent(title: "Library", detail: "Browse all HIGDesign examples.")
                case .settings:
                    tabContent(title: "Settings", detail: "Theme and accessibility controls.")
                }
            }
        }
        .navigationTitle("Tab Bar")
    }

    private func tabContent(title: String, detail: String) -> some View {
        VStack(alignment: .leading, spacing: theme.spacing.compactItem) {
            Text(title)
                .font(theme.typography.title)
            Text(detail)
                .foregroundStyle(theme.colors.labelSecondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .higPadding(.screenEdge)
    }
}

#if DEBUG
#Preview("ShowcaseTabBarView") {
    ShowcasePreviewContainer {
        ShowcaseTabBarView()
    }
}
#endif