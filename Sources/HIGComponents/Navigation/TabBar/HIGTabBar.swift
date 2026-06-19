import HIGThemesContract
import SwiftUI

/// A tab bar container that applies HIG theme accent styling to native `TabView` tabs.
public struct HIGTabBar<Selection: Hashable & Sendable, TabContent: View>: View {
    @Binding private var selection: Selection
    private let tabs: [HIGTabItem<Selection>]
    private let content: (Selection) -> TabContent

    @Environment(\.higTheme) private var theme

    public init(
        selection: Binding<Selection>,
        tabs: [HIGTabItem<Selection>],
        @ViewBuilder content: @escaping (Selection) -> TabContent
    ) {
        _selection = selection
        self.tabs = tabs
        self.content = content
    }

    public var body: some View {
        TabView(selection: $selection) {
            ForEach(tabs) { tab in
                content(tab.id)
                    .tabItem {
                        Label(tab.title, systemImage: tab.systemImage)
                    }
                    .tag(tab.id)
            }
        }
        .tint(theme.colors.accent)
    }
}

#if DEBUG
private enum HIGTabBarPreviewTab: String, Hashable, Sendable {
    case home
    case settings
}

#Preview("HIGTabBar") {
    @Previewable @State var selection = HIGTabBarPreviewTab.home

    HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        HIGTabBar(
            selection: $selection,
            tabs: [
                HIGTabItem(id: HIGTabBarPreviewTab.home, title: "Home", systemImage: "house"),
                HIGTabItem(id: HIGTabBarPreviewTab.settings, title: "Settings", systemImage: "gearshape"),
            ]
        ) { tab in
            switch tab {
            case .home:
                Text("Home")
            case .settings:
                Text("Settings")
            }
        }
    }
}
#endif