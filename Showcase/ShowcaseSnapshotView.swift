import HIGThemesContract
import HIGDesign
import SwiftUI

/// Renders a single showcase component for snapshot capture.
public struct ShowcaseSnapshotView: View {
    public let component: ShowcaseComponent

    @Environment(\.higTheme) private var theme

    public init(component: ShowcaseComponent) {
        self.component = component
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: HIGSpacing.none.rawValue) {
            Text(component.title)
                .font(theme.typography.caption.weight(.semibold))
                .foregroundStyle(theme.colors.labelSecondary)
                .padding(.horizontal, theme.spacing.screenEdge)
                .padding(.top, theme.spacing.item)
                .accessibilityHidden(true)

            snapshotContent
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(theme.colors.backgroundPrimary)
    }

    @ViewBuilder
    private var snapshotContent: some View {
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
            ShowcaseIconView(iconSettings: .constant(ShowcaseIconSettings()))
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
#Preview("ShowcaseSnapshotView") {
    ShowcasePreviewContainer(includeNavigationStack: false) {
        ShowcaseSnapshotView(component: .button)
    }
}
#endif