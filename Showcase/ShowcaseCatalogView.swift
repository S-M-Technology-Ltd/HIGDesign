import SwiftUI

struct ShowcaseCatalogView: View {
    @Binding var selection: ShowcaseComponent?
    @Binding var themeChoice: ShowcaseThemeChoice
    @Binding var colorScheme: ColorScheme?

    var body: some View {
        #if os(watchOS)
        watchCatalog
        #else
        standardCatalog
        #endif
    }

    private var standardCatalog: some View {
        NavigationSplitView {
            List(ShowcaseComponent.allCases, selection: $selection) { component in
                VStack(alignment: .leading, spacing: 2) {
                    Text(component.title)
                    Text(component.summary)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .lineLimit(2)
                }
                .tag(component)
            }
            .navigationTitle("Components")
            .safeAreaInset(edge: .bottom) {
                ShowcaseSettingsView(themeChoice: $themeChoice, colorScheme: $colorScheme)
                    .padding()
                    .background(.regularMaterial)
            }
        } detail: {
            if let selection {
                showcaseDetail(for: selection)
            } else {
                ShowcaseWelcomeView()
            }
        }
    }

    private var watchCatalog: some View {
        NavigationStack {
            List(ShowcaseComponent.allCases) { component in
                NavigationLink(component.title) {
                    showcaseDetail(for: component)
                }
            }
            .navigationTitle("HIGDesign")
        }
    }

    @ViewBuilder
    private func showcaseDetail(for component: ShowcaseComponent) -> some View {
        switch component {
        case .button:
            ShowcaseButtonView()
        case .textField:
            ShowcaseTextFieldView()
        case .toggle:
            ShowcaseToggleView()
        case .divider:
            ShowcaseDividerView()
        case .progressView:
            ShowcaseProgressView()
        case .card:
            ShowcaseCardView()
        case .tabBar:
            ShowcaseTabBarView()
        case .toolbar:
            ShowcaseToolbarView()
        }
    }
}

#if DEBUG
#Preview("ShowcaseCatalogView") {
    ShowcaseCatalogView(
        selection: .constant(.button),
        themeChoice: .constant(.system),
        colorScheme: .constant(nil)
    )
}
#endif