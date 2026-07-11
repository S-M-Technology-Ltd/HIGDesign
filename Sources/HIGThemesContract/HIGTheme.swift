import HIGTokensComponent
import HIGTokensSemantic

public protocol HIGTheme: Sendable {
    var name: String { get }
    var colors: any HIGColorSemanticTokens { get }
    var typography: any HIGTypographySemanticTokens { get }
    var spacing: any HIGSpacingSemanticTokens { get }
    var opacity: any HIGOpacitySemanticTokens { get }
    var border: any HIGBorderSemanticTokens { get }
    var motion: any HIGMotionSemanticTokens { get }
    var divider: any HIGDividerTokens { get }
    var button: any HIGButtonTokens { get }
    var buttonGroup: any HIGButtonGroupTokens { get }
    var menuToggle: any HIGMenuToggleTokens { get }
    var textField: any HIGTextFieldTokens { get }
    var inputGroup: any HIGInputGroupTokens { get }
    var fieldMessage: any HIGFieldMessageTokens { get }
    var datePicker: any HIGDatePickerTokens { get }
    var timePicker: any HIGDatePickerTokens { get }
    var toggle: any HIGToggleTokens { get }
    var checkbox: any HIGCheckboxTokens { get }
    var radio: any HIGRadioTokens { get }
    var segmentedControl: any HIGSegmentedControlTokens { get }
    var slider: any HIGSliderTokens { get }
    var picker: any HIGPickerTokens { get }
    var card: any HIGCardTokens { get }
    var panel: any HIGPanelTokens { get }
    var breadcrumb: any HIGBreadcrumbTokens { get }
    var pageHeader: any HIGPageHeaderTokens { get }
    var pagination: any HIGPaginationTokens { get }
    var tabs: any HIGTabsTokens { get }
    var accordion: any HIGAccordionTokens { get }
    var steps: any HIGStepsTokens { get }
    var pearlSteps: any HIGPearlStepsTokens { get }
    var timeline: any HIGTimelineTokens { get }
    var statusIndicator: any HIGStatusIndicatorTokens { get }
    var emptyState: any HIGEmptyStateTokens { get }
    var closeButton: any HIGCloseButtonTokens { get }
    var modal: any HIGModalTokens { get }
    var tooltip: any HIGTooltipTokens { get }
    var popover: any HIGPopoverTokens { get }
    var drawer: any HIGDrawerTokens { get }
    var networkProgressBar: any HIGNetworkProgressBarTokens { get }
    var progress: any HIGProgressTokens { get }
    var alert: any HIGAlertTokens { get }
    var toast: any HIGToastTokens { get }
    var badge: any HIGBadgeTokens { get }
    var icon: any HIGIconTokens { get }
    var avatar: any HIGAvatarTokens { get }
    var link: any HIGLinkTokens { get }
    var bulletList: any HIGBulletListTokens { get }
    var textEditor: any HIGTextEditorTokens { get }
    var stepper: any HIGStepperTokens { get }
    var menuButton: any HIGMenuButtonTokens { get }
    var tag: any HIGTagTokens { get }
    var navigationBar: any HIGNavigationBarTokens { get }
    var toolbar: any HIGToolbarTokens { get }
    var activityIndicator: any HIGActivityIndicatorTokens { get }
    var matrixLoader: any HIGMatrixLoaderTokens { get }
    var shimmer: any HIGShimmerTokens { get }
    var list: any HIGListTokens { get }
    var sidebar: any HIGSidebarTokens { get }
    var photoPicker: any HIGPhotoPickerTokens { get }
    var photoEditor: any HIGPhotoEditorTokens { get }
    var longTextEditor: any HIGLongTextEditorTokens { get }
}