import HIGDesign
import SwiftUI

struct ShowcaseCatalogView: View {
    @Environment(\.higTheme) private var theme
    @Binding var selection: ShowcaseComponent?
    @Binding var themeChoice: ShowcaseThemeChoice
    @Binding var colorScheme: ColorScheme?
    @Binding var dynamicTypeSizeChoice: ShowcaseDynamicTypeSizeChoice
    @Binding var iconSettings: ShowcaseIconSettings

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
                VStack(alignment: .leading, spacing: HIGSpacing.xxs.rawValue / 2) {
                    Text(component.title)
                    Text(component.summary)
                        .font(theme.typography.caption)
                        .foregroundStyle(theme.colors.labelSecondary)
                        .lineLimit(2)
                }
                .tag(component)
            }
            .navigationTitle("Components")
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
        }
    }
}

#if DEBUG
#Preview("ShowcaseCatalogView") {
    ShowcasePreviewContainer(includeNavigationStack: false) {
        ShowcaseCatalogView(
        selection: .constant(.button),
        themeChoice: .constant(.system),
        colorScheme: .constant(nil),
        dynamicTypeSizeChoice: .constant(.system),
        iconSettings: .constant(ShowcaseIconSettings())
    )
    }
}
#endif