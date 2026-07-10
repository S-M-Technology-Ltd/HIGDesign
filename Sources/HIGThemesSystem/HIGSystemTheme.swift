import HIGThemesContract
import HIGTokensComponent
import HIGTokensSemantic

public struct HIGSystemTheme: HIGTheme, Sendable {
    public let name = "System"
    public let colors: any HIGColorSemanticTokens
    public let typography: any HIGTypographySemanticTokens
    public let spacing: any HIGSpacingSemanticTokens
    public let opacity: any HIGOpacitySemanticTokens
    public let border: any HIGBorderSemanticTokens
    public let motion: any HIGMotionSemanticTokens
    public let divider: any HIGDividerTokens
    public let button: any HIGButtonTokens
    public let textField: any HIGTextFieldTokens
    public let toggle: any HIGToggleTokens
    public let checkbox: any HIGCheckboxTokens
    public let radio: any HIGRadioTokens
    public let segmentedControl: any HIGSegmentedControlTokens
    public let slider: any HIGSliderTokens
    public let picker: any HIGPickerTokens
    public let card: any HIGCardTokens
    public let panel: any HIGPanelTokens
    public let breadcrumb: any HIGBreadcrumbTokens
    public let pageHeader: any HIGPageHeaderTokens
    public let progress: any HIGProgressTokens
    public let alert: any HIGAlertTokens
    public let toast: any HIGToastTokens
    public let badge: any HIGBadgeTokens
    public let icon: any HIGIconTokens
    public let avatar: any HIGAvatarTokens
    public let link: any HIGLinkTokens
    public let bulletList: any HIGBulletListTokens
    public let textEditor: any HIGTextEditorTokens
    public let stepper: any HIGStepperTokens
    public let menuButton: any HIGMenuButtonTokens
    public let tag: any HIGTagTokens
    public let navigationBar: any HIGNavigationBarTokens
    public let toolbar: any HIGToolbarTokens
    public let activityIndicator: any HIGActivityIndicatorTokens
    public let matrixLoader: any HIGMatrixLoaderTokens
    public let shimmer: any HIGShimmerTokens
    public let list: any HIGListTokens
    public let sidebar: any HIGSidebarTokens
    public let photoPicker: any HIGPhotoPickerTokens
    public let photoEditor: any HIGPhotoEditorTokens
    public let longTextEditor: any HIGLongTextEditorTokens

    public init(
        colors: any HIGColorSemanticTokens = HIGSystemColorSemanticTokens(),
        typography: any HIGTypographySemanticTokens = HIGSystemTypographySemanticTokens(),
        spacing: any HIGSpacingSemanticTokens = HIGSystemSpacingSemanticTokens(),
        opacity: any HIGOpacitySemanticTokens = HIGSystemOpacitySemanticTokens(),
        border: any HIGBorderSemanticTokens = HIGSystemBorderSemanticTokens(),
        motion: any HIGMotionSemanticTokens = HIGSystemMotionSemanticTokens(),
        divider: any HIGDividerTokens = HIGSystemDividerTokens(),
        button: any HIGButtonTokens = HIGSystemButtonTokens(),
        textField: any HIGTextFieldTokens = HIGSystemTextFieldTokens(),
        toggle: any HIGToggleTokens = HIGSystemToggleTokens(),
        checkbox: any HIGCheckboxTokens = HIGSystemCheckboxTokens(),
        radio: any HIGRadioTokens = HIGSystemRadioTokens(),
        segmentedControl: any HIGSegmentedControlTokens = HIGSystemSegmentedControlTokens(),
        slider: any HIGSliderTokens = HIGSystemSliderTokens(),
        picker: any HIGPickerTokens = HIGSystemPickerTokens(),
        card: any HIGCardTokens = HIGSystemCardTokens(),
        panel: any HIGPanelTokens = HIGSystemPanelTokens(),
        breadcrumb: any HIGBreadcrumbTokens = HIGSystemBreadcrumbTokens(),
        pageHeader: any HIGPageHeaderTokens = HIGSystemPageHeaderTokens(),
        progress: any HIGProgressTokens = HIGSystemProgressTokens(),
        alert: any HIGAlertTokens = HIGSystemAlertTokens(),
        toast: any HIGToastTokens = HIGSystemToastTokens(),
        badge: any HIGBadgeTokens = HIGSystemBadgeTokens(),
        icon: any HIGIconTokens = HIGSystemIconTokens(),
        avatar: any HIGAvatarTokens = HIGSystemAvatarTokens(),
        link: any HIGLinkTokens = HIGSystemLinkTokens(),
        bulletList: any HIGBulletListTokens = HIGSystemBulletListTokens(),
        textEditor: any HIGTextEditorTokens = HIGSystemTextEditorTokens(),
        stepper: any HIGStepperTokens = HIGSystemStepperTokens(),
        menuButton: any HIGMenuButtonTokens = HIGSystemMenuButtonTokens(),
        tag: any HIGTagTokens = HIGSystemTagTokens(),
        navigationBar: any HIGNavigationBarTokens = HIGSystemNavigationBarTokens(),
        toolbar: any HIGToolbarTokens = HIGSystemToolbarTokens(),
        activityIndicator: any HIGActivityIndicatorTokens = HIGSystemActivityIndicatorTokens(),
        matrixLoader: any HIGMatrixLoaderTokens = HIGSystemMatrixLoaderTokens(),
        shimmer: any HIGShimmerTokens = HIGSystemShimmerTokens(),
        list: any HIGListTokens = HIGSystemListTokens(),
        sidebar: any HIGSidebarTokens = HIGSystemSidebarTokens(),
        photoPicker: any HIGPhotoPickerTokens = HIGSystemPhotoPickerTokens(),
        photoEditor: any HIGPhotoEditorTokens = HIGSystemPhotoEditorTokens(),
        longTextEditor: any HIGLongTextEditorTokens = HIGSystemLongTextEditorTokens()
    ) {
        self.colors = colors
        self.typography = typography
        self.spacing = spacing
        self.opacity = opacity
        self.border = border
        self.motion = motion
        self.divider = divider
        self.button = button
        self.textField = textField
        self.toggle = toggle
        self.checkbox = checkbox
        self.radio = radio
        self.segmentedControl = segmentedControl
        self.slider = slider
        self.picker = picker
        self.card = card
        self.panel = panel
        self.breadcrumb = breadcrumb
        self.pageHeader = pageHeader
        self.progress = progress
        self.alert = alert
        self.toast = toast
        self.badge = badge
        self.icon = icon
        self.avatar = avatar
        self.link = link
        self.bulletList = bulletList
        self.textEditor = textEditor
        self.stepper = stepper
        self.menuButton = menuButton
        self.tag = tag
        self.navigationBar = navigationBar
        self.toolbar = toolbar
        self.activityIndicator = activityIndicator
        self.matrixLoader = matrixLoader
        self.shimmer = shimmer
        self.list = list
        self.sidebar = sidebar
        self.photoPicker = photoPicker
        self.photoEditor = photoEditor
        self.longTextEditor = longTextEditor
    }
}