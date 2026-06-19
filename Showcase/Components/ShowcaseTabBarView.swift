import HIGDesign
import SwiftUI

private enum ShowcaseTab: String, Hashable, Sendable {
    case home
    case library
    case settings
}

struct ShowcaseTabBarView: View {
    @State private var selection = ShowcaseTab.home

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            ShowcaseMetadataView(component: .tabBar)
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
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.title2)
            Text(detail)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .higPadding(.screenEdge)
    }
}

#if DEBUG
#Preview("ShowcaseTabBarView") {
    ShowcaseTabBarView()
}
#endif