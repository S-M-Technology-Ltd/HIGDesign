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
    #if os(iOS) || os(visionOS)
    @State private var preferredCompactColumn: NavigationSplitViewColumn = .sidebar
    #endif

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

    @ViewBuilder
    private var splitView: some View {
        #if os(iOS) || os(visionOS)
        NavigationSplitView(preferredCompactColumn: $preferredCompactColumn) {
            catalogSidebar
        } detail: {
            catalogDetail
        }
        #else
        NavigationSplitView {
            catalogSidebar
        } detail: {
            catalogDetail
        }
        #endif
    }

    private var catalogSidebar: some View {
        List {
            ForEach(filteredComponents) { component in
                catalogRow(for: component)
            }
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
    private func catalogRow(for component: ShowcaseComponent) -> some View {
        let isSelected = selection == component

        Button {
            selection = component
        } label: {
            VStack(alignment: .leading, spacing: HIGSpacing.xxs.rawValue / 2) {
                Text(component.title)
                Text(component.summary)
                    .font(theme.typography.caption)
                    .foregroundStyle(theme.colors.labelSecondary)
                    .lineLimit(2)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .listRowBackground(isSelected ? theme.colors.fillPrimary.opacity(0.15) : nil)
        .accessibilityAddTraits(isSelected ? .isSelected : [])
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
        case .alert:
            ShowcaseAlertView()
        case .toast:
            ShowcaseToastView()
        case .sidebar:
            ShowcaseSidebarView()
        case .navigationBar:
            ShowcaseNavigationBarView()
        case .label:
            ShowcaseLabelView()
        case .badge:
            ShowcaseBadgeView()
        case .activityIndicator:
            ShowcaseActivityIndicatorView()
        case .list:
            ShowcaseListView()
        case .form:
            ShowcaseFormView()
        case .checkbox:
            ShowcaseCheckboxView()
        case .radio:
            ShowcaseRadioView()
        case .segmentedControl:
            ShowcaseSegmentedControlView()
        case .slider:
            ShowcaseSliderView()
        case .secureField:
            ShowcaseSecureFieldView()
        case .searchField:
            ShowcaseSearchFieldView()
        case .picker:
            ShowcasePickerView()
        case .icon:
            ShowcaseIconView(iconSettings: $iconSettings)
        case .avatar:
            ShowcaseAvatarView()
        case .link:
            ShowcaseLinkView()
        case .bulletList:
            ShowcaseBulletListView()
        case .textEditor:
            ShowcaseTextEditorView()
        case .stepper:
            ShowcaseStepperView()
        case .menuButton:
            ShowcaseMenuButtonView()
        case .tag:
            ShowcaseTagView()
        case .photoPicker:
            ShowcasePhotoPickerView()
        case .photoEditor:
            ShowcasePhotoEditorView()
        case .longTextEditor:
            ShowcaseLongTextEditorView()
        }
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