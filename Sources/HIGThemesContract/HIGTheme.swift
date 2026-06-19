import HIGTokensComponent
import HIGTokensSemantic

public protocol HIGTheme: Sendable {
    var name: String { get }
    var colors: any HIGColorSemanticTokens { get }
    var typography: any HIGTypographySemanticTokens { get }
    var spacing: any HIGSpacingSemanticTokens { get }
    var button: any HIGButtonTokens { get }
    var textField: any HIGTextFieldTokens { get }
    var toggle: any HIGToggleTokens { get }
    var checkbox: any HIGCheckboxTokens { get }
    var radio: any HIGRadioTokens { get }
    var segmentedControl: any HIGSegmentedControlTokens { get }
    var slider: any HIGSliderTokens { get }
    var picker: any HIGPickerTokens { get }
    var card: any HIGCardTokens { get }
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
    var list: any HIGListTokens { get }
    var sidebar: any HIGSidebarTokens { get }
}