import HIGDesign
import SwiftUI

/// Catalog detail content shared by the live showcase app and pixel-match snapshots.
struct ShowcaseSnapshotCatalogDetail: View {
    let component: ShowcaseComponent
    @Binding var iconSettings: ShowcaseIconSettings

    var body: some View {
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