import HIGDesign
import SwiftUI

struct ShowcaseCatalogView: View {
    @Environment(\.higTheme) private var theme
    @Binding var selection: ShowcaseComponent?
    @Binding var themeChoice: ShowcaseThemeChoice
    @Binding var colorScheme: ColorScheme?
    @Binding var dynamicTypeSizeChoice: ShowcaseDynamicTypeSizeChoice
    @Binding var iconSettings: ShowcaseIconSettings

    @State private var searchText = ""
    @State private var sidebarScrollPosition: ShowcaseComponent.ID?

    private var filteredComponents: [ShowcaseComponent] {
        let sorted = ShowcaseComponent.catalogSorted
        let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !query.isEmpty else { return sorted }
        return sorted.filter { component in
            component.title.localizedCaseInsensitiveContains(query)
                || component.summary.localizedCaseInsensitiveContains(query)
        }
    }

    var body: some View {
        #if os(watchOS)
        watchCatalog
        #else
        standardCatalog
        #endif
    }

    private var standardCatalog: some View {
        splitView
    }

    private var splitView: some View {
        NavigationSplitView {
            catalogSidebar
        } detail: {
            catalogDetail
        }
    }

    private var catalogSidebar: some View {
        List(filteredComponents, selection: $selection) { component in
            VStack(alignment: .leading, spacing: HIGSpacing.xxs.rawValue / 2) {
                Text(component.title)
                Text(component.summary)
                    .font(theme.typography.caption)
                    .foregroundStyle(theme.colors.labelSecondary)
                    .lineLimit(2)
            }
            .tag(component)
        }
        .scrollPosition(id: $sidebarScrollPosition)
        .onChange(of: selection) { _, newValue in
            sidebarScrollPosition = newValue?.id
        }
        .onAppear {
            sidebarScrollPosition = selection?.id
        }
        .navigationTitle("Components")
        .searchable(text: $searchText, prompt: "Search components")
        .safeAreaInset(edge: .bottom) {
            ShowcaseSettingsView(
                selection: selection,
                themeChoice: $themeChoice,
                colorScheme: $colorScheme,
                dynamicTypeSizeChoice: $dynamicTypeSizeChoice,
                iconSettings: $iconSettings
            )
            .padding()
            .background(.regularMaterial)
        }
    }

    @ViewBuilder
    private var catalogDetail: some View {
        if let selection {
            showcaseDetail(for: selection)
        } else {
            ShowcaseWelcomeView()
        }
    }

    private var watchCatalog: some View {
        NavigationStack {
            List(ShowcaseComponent.catalogSorted) { component in
                NavigationLink(component.title) {
                    showcaseDetail(for: component)
                }
            }
            .navigationTitle("HIGDesign")
        }
    }

    @ViewBuilder
    private func showcaseDetail(for component: ShowcaseComponent) -> some View {
        ShowcaseSnapshotCatalogDetail(component: component, iconSettings: $iconSettings)
    }
}

#if DEBUG
#Preview("ShowcaseCatalogView") {
    ShowcasePreviewContainer(includeNavigationStack: false) {
        ShowcaseCatalogView(
            selection: .constant(nil),
            themeChoice: .constant(.system),
            colorScheme: .constant(nil),
            dynamicTypeSizeChoice: .constant(.system),
            iconSettings: .constant(ShowcaseIconSettings())
        )
    }
}
#endif