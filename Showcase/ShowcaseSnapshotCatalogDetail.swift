import HIGDesign
import SwiftUI

/// Catalog detail content shared by the live showcase app and pixel-match snapshots.
struct ShowcaseSnapshotCatalogDetailView: View {
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
        case .panel:
            ShowcasePanelView()
        case .breadcrumb:
            ShowcaseBreadcrumbView()
        case .pageHeader:
            ShowcasePageHeaderView()
        case .pagination:
            ShowcasePaginationView()
        case .tabs:
            ShowcaseTabsView()
        case .accordion:
            ShowcaseAccordionView()
        case .steps:
            ShowcaseStepsView()
        case .pearlSteps:
            ShowcasePearlStepsView()
        case .timeline:
            ShowcaseTimelineView()
        case .statusIndicator:
            ShowcaseStatusIndicatorView()
        case .emptyState:
            ShowcaseEmptyStateView()
        case .closeButton:
            ShowcaseCloseButtonView()
        case .modal:
            ShowcaseModalView()
        case .tooltip:
            ShowcaseTooltipView()
        case .popover:
            ShowcasePopoverView()
        case .drawer:
            ShowcaseDrawerView()
        case .confirmationDialog:
            ShowcaseConfirmationDialogView()
        case .networkProgressBar:
            ShowcaseNetworkProgressBarView()
        case .buttonGroup:
            ShowcaseButtonGroupView()
        case .menuToggle:
            ShowcaseMenuToggleView()
        case .inputGroup:
            ShowcaseInputGroupView()
        case .fieldMessage:
            ShowcaseFieldMessageView()
        case .datePicker:
            ShowcaseDatePickerView()
        case .timePicker:
            ShowcaseTimePickerView()
        case .select:
            ShowcaseSelectView()
        case .autocomplete:
            ShowcaseAutocompleteView()
        case .tagInput:
            ShowcaseTagInputView()
        case .dataTable:
            ShowcaseDataTableView()
        case .dropZone:
            ShowcaseDropZoneView()
        case .adminShell:
            ShowcaseAdminShellView()
        case .codeBlock:
            ShowcaseCodeBlockView()
        case .carousel:
            ShowcaseCarouselView()
        case .mediaRow:
            ShowcaseMediaRowView()
        case .hero:
            ShowcaseHeroView()
        case .listGroup:
            ShowcaseListGroupView()
        case .barChart:
            ShowcaseBarChartView()
        case .lineChart:
            ShowcaseLineChartView()
        case .pieChart:
            ShowcasePieChartView()
        case .areaChart:
            ShowcaseAreaChartView()
        case .lightbox:
            ShowcaseLightboxView()
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
        case .matrixLoader:
            ShowcaseMatrixLoaderView()
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