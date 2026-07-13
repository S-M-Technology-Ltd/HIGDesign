import HIGDesign
import SwiftUI

public struct ShowcaseRootView: View {
    @State private var selectedTab: ShowcaseComponent.CatalogSection = .components
    @State private var componentSelection: ShowcaseComponent?
    @State private var pageSelection: ShowcaseComponent?
    @State private var themeChoice: ShowcaseThemeChoice = .system
    @State private var colorScheme: ColorScheme?
    @State private var dynamicTypeSizeChoice: ShowcaseDynamicTypeSizeChoice = .system
    @State private var iconSettings = ShowcaseIconSettings()

    public init() {}

    public var body: some View {
        Group {
            HIGThemeableView(theme: themeChoice.makeTheme()) {
                #if os(watchOS)
                watchRoot
                #else
                standardRoot
                #endif
            }
        }
        .preferredColorScheme(colorScheme)
        .modifier(ShowcaseDynamicTypeSizeModifier(choice: dynamicTypeSizeChoice))
    }

    private var standardRoot: some View {
        TabView(selection: $selectedTab) {
            ShowcaseCatalogView(
                section: .components,
                selection: $componentSelection,
                themeChoice: $themeChoice,
                colorScheme: $colorScheme,
                dynamicTypeSizeChoice: $dynamicTypeSizeChoice,
                iconSettings: $iconSettings
            )
            .tabItem {
                Label(
                    ShowcaseComponent.CatalogSection.components.title,
                    systemImage: ShowcaseComponent.CatalogSection.components.systemImage
                )
            }
            .tag(ShowcaseComponent.CatalogSection.components)

            ShowcaseCatalogView(
                section: .pages,
                selection: $pageSelection,
                themeChoice: $themeChoice,
                colorScheme: $colorScheme,
                dynamicTypeSizeChoice: $dynamicTypeSizeChoice,
                iconSettings: $iconSettings
            )
            .tabItem {
                Label(
                    ShowcaseComponent.CatalogSection.pages.title,
                    systemImage: ShowcaseComponent.CatalogSection.pages.systemImage
                )
            }
            .tag(ShowcaseComponent.CatalogSection.pages)
        }
    }

    /// Compact watchOS navigation without a dual-tab chrome.
    private var watchRoot: some View {
        TabView(selection: $selectedTab) {
            ShowcaseCatalogView(
                section: .components,
                selection: $componentSelection,
                themeChoice: $themeChoice,
                colorScheme: $colorScheme,
                dynamicTypeSizeChoice: $dynamicTypeSizeChoice,
                iconSettings: $iconSettings
            )
            .tag(ShowcaseComponent.CatalogSection.components)
            .tabItem {
                Text(ShowcaseComponent.CatalogSection.components.title)
            }

            ShowcaseCatalogView(
                section: .pages,
                selection: $pageSelection,
                themeChoice: $themeChoice,
                colorScheme: $colorScheme,
                dynamicTypeSizeChoice: $dynamicTypeSizeChoice,
                iconSettings: $iconSettings
            )
            .tag(ShowcaseComponent.CatalogSection.pages)
            .tabItem {
                Text(ShowcaseComponent.CatalogSection.pages.title)
            }
        }
    }
}

#if DEBUG
#Preview("ShowcaseRootView") {
    ShowcasePreviewContainer(includeNavigationStack: false) {
        ShowcaseRootView()
    }
}
#endif
