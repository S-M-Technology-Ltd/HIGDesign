import HIGThemesContract
import HIGTokensComponent
import HIGTokensSemantic
import SwiftUI

/// A brand theme that overrides accent color while inheriting system defaults.
public struct HIGBrandTheme: HIGTheme, Sendable {
    public let name: String
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
        name: String,
        accent: Color,
        base: HIGSystemTheme = HIGSystemTheme()
    ) {
        let baseColors = base.colors
        self.name = name
        self.colors = HIGSystemColorSemanticTokens(
            labelPrimary: baseColors.labelPrimary,
            labelSecondary: baseColors.labelSecondary,
            labelOnAccent: baseColors.labelOnAccent,
            backgroundPrimary: baseColors.backgroundPrimary,
            backgroundSecondary: baseColors.backgroundSecondary,
            fillPrimary: baseColors.fillPrimary,
            separator: baseColors.separator,
            accent: accent,
            destructive: baseColors.destructive,
            warning: baseColors.warning
        )
        self.typography = base.typography
        self.spacing = base.spacing
        self.opacity = base.opacity
        self.border = base.border
        self.motion = base.motion
        self.divider = base.divider
        self.button = base.button
        self.textField = base.textField
        self.toggle = base.toggle
        self.checkbox = base.checkbox
        self.radio = base.radio
        self.segmentedControl = base.segmentedControl
        self.slider = base.slider
        self.picker = base.picker
        self.card = base.card
        self.progress = base.progress
        self.alert = base.alert
        self.toast = base.toast
        self.badge = base.badge
        self.icon = base.icon
        self.avatar = base.avatar
        self.link = base.link
        self.bulletList = base.bulletList
        self.textEditor = base.textEditor
        self.stepper = base.stepper
        self.menuButton = base.menuButton
        self.tag = base.tag
        self.navigationBar = base.navigationBar
        self.toolbar = base.toolbar
        self.activityIndicator = base.activityIndicator
        self.matrixLoader = base.matrixLoader
        self.shimmer = base.shimmer
        self.list = base.list
        self.sidebar = base.sidebar
        self.photoPicker = base.photoPicker
        self.photoEditor = base.photoEditor
        self.longTextEditor = base.longTextEditor
    }
}