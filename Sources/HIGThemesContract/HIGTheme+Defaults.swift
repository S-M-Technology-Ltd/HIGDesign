import HIGTokensComponent
import HIGTokensSemantic

extension HIGTheme {
    public var name: String { "Custom" }

    public var colors: any HIGColorSemanticTokens { HIGSystemColorSemanticTokens() }
    public var typography: any HIGTypographySemanticTokens { HIGSystemTypographySemanticTokens() }
    public var spacing: any HIGSpacingSemanticTokens { HIGSystemSpacingSemanticTokens() }
    public var opacity: any HIGOpacitySemanticTokens { HIGSystemOpacitySemanticTokens() }
    public var border: any HIGBorderSemanticTokens { HIGSystemBorderSemanticTokens() }
    public var motion: any HIGMotionSemanticTokens { HIGSystemMotionSemanticTokens() }

    public var divider: any HIGDividerTokens { HIGSystemDividerTokens() }
    public var button: any HIGButtonTokens { HIGSystemButtonTokens() }
    public var buttonGroup: any HIGButtonGroupTokens { HIGSystemButtonGroupTokens() }
    public var menuToggle: any HIGMenuToggleTokens { HIGSystemMenuToggleTokens() }
    public var textField: any HIGTextFieldTokens { HIGSystemTextFieldTokens() }
    public var inputGroup: any HIGInputGroupTokens { HIGSystemInputGroupTokens() }
    public var fieldMessage: any HIGFieldMessageTokens { HIGSystemFieldMessageTokens() }
    public var datePicker: any HIGDatePickerTokens { HIGSystemDatePickerTokens() }
    public var timePicker: any HIGDatePickerTokens { HIGSystemDatePickerTokens() }
    public var select: any HIGSelectTokens { HIGSystemSelectTokens() }
    public var autocomplete: any HIGSelectTokens { HIGSystemSelectTokens() }
    public var tagInput: any HIGSelectTokens { HIGSystemSelectTokens() }
    public var toggle: any HIGToggleTokens { HIGSystemToggleTokens() }
    public var checkbox: any HIGCheckboxTokens { HIGSystemCheckboxTokens() }
    public var radio: any HIGRadioTokens { HIGSystemRadioTokens() }
    public var segmentedControl: any HIGSegmentedControlTokens { HIGSystemSegmentedControlTokens() }
    public var slider: any HIGSliderTokens { HIGSystemSliderTokens() }
    public var picker: any HIGPickerTokens { HIGSystemPickerTokens() }
    public var card: any HIGCardTokens { HIGSystemCardTokens() }
    public var panel: any HIGPanelTokens { HIGSystemPanelTokens() }
    public var breadcrumb: any HIGBreadcrumbTokens { HIGSystemBreadcrumbTokens() }
    public var pageHeader: any HIGPageHeaderTokens { HIGSystemPageHeaderTokens() }
    public var pagination: any HIGPaginationTokens { HIGSystemPaginationTokens() }
    public var tabs: any HIGTabsTokens { HIGSystemTabsTokens() }
    public var accordion: any HIGAccordionTokens { HIGSystemAccordionTokens() }
    public var steps: any HIGStepsTokens { HIGSystemStepsTokens() }
    public var pearlSteps: any HIGPearlStepsTokens { HIGSystemPearlStepsTokens() }
    public var timeline: any HIGTimelineTokens { HIGSystemTimelineTokens() }
    public var statusIndicator: any HIGStatusIndicatorTokens { HIGSystemStatusIndicatorTokens() }
    public var emptyState: any HIGEmptyStateTokens { HIGSystemEmptyStateTokens() }
    public var closeButton: any HIGCloseButtonTokens { HIGSystemCloseButtonTokens() }
    public var modal: any HIGModalTokens { HIGSystemModalTokens() }
    public var tooltip: any HIGTooltipTokens { HIGSystemTooltipTokens() }
    public var popover: any HIGPopoverTokens { HIGSystemPopoverTokens() }
    public var drawer: any HIGDrawerTokens { HIGSystemDrawerTokens() }
    public var networkProgressBar: any HIGNetworkProgressBarTokens { HIGSystemNetworkProgressBarTokens() }
    public var progress: any HIGProgressTokens { HIGSystemProgressTokens() }
    public var alert: any HIGAlertTokens { HIGSystemAlertTokens() }
    public var toast: any HIGToastTokens { HIGSystemToastTokens() }
    public var badge: any HIGBadgeTokens { HIGSystemBadgeTokens() }
    public var icon: any HIGIconTokens { HIGSystemIconTokens() }
    public var avatar: any HIGAvatarTokens { HIGSystemAvatarTokens() }
    public var link: any HIGLinkTokens { HIGSystemLinkTokens() }
    public var bulletList: any HIGBulletListTokens { HIGSystemBulletListTokens() }
    public var textEditor: any HIGTextEditorTokens { HIGSystemTextEditorTokens() }
    public var stepper: any HIGStepperTokens { HIGSystemStepperTokens() }
    public var menuButton: any HIGMenuButtonTokens { HIGSystemMenuButtonTokens() }
    public var tag: any HIGTagTokens { HIGSystemTagTokens() }
    public var navigationBar: any HIGNavigationBarTokens { HIGSystemNavigationBarTokens() }
    public var toolbar: any HIGToolbarTokens { HIGSystemToolbarTokens() }
    public var activityIndicator: any HIGActivityIndicatorTokens { HIGSystemActivityIndicatorTokens() }
    public var matrixLoader: any HIGMatrixLoaderTokens { HIGSystemMatrixLoaderTokens() }
    public var shimmer: any HIGShimmerTokens { HIGSystemShimmerTokens() }
    public var list: any HIGListTokens { HIGSystemListTokens() }
    public var sidebar: any HIGSidebarTokens { HIGSystemSidebarTokens() }
    public var photoPicker: any HIGPhotoPickerTokens { HIGSystemPhotoPickerTokens() }
    public var photoEditor: any HIGPhotoEditorTokens { HIGSystemPhotoEditorTokens() }
    public var longTextEditor: any HIGLongTextEditorTokens { HIGSystemLongTextEditorTokens() }
}
