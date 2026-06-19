#if DEBUG
import HIGTokensComponent
import HIGTokensSemantic

public struct HIGComponentPreviewTheme: HIGTheme {
    public let name = "Preview"
    public let colors: any HIGColorSemanticTokens = HIGSystemColorSemanticTokens()
    public let typography: any HIGTypographySemanticTokens = HIGSystemTypographySemanticTokens()
    public let spacing: any HIGSpacingSemanticTokens = HIGSystemSpacingSemanticTokens()
    public let button: any HIGButtonTokens = HIGSystemButtonTokens()
    public let textField: any HIGTextFieldTokens = HIGSystemTextFieldTokens()
    public let toggle: any HIGToggleTokens = HIGSystemToggleTokens()
    public let checkbox: any HIGCheckboxTokens = HIGSystemCheckboxTokens()
    public let radio: any HIGRadioTokens = HIGSystemRadioTokens()
    public let segmentedControl: any HIGSegmentedControlTokens = HIGSystemSegmentedControlTokens()
    public let slider: any HIGSliderTokens = HIGSystemSliderTokens()
    public let picker: any HIGPickerTokens = HIGSystemPickerTokens()
    public let card: any HIGCardTokens = HIGSystemCardTokens()
    public let progress: any HIGProgressTokens = HIGSystemProgressTokens()
    public let alert: any HIGAlertTokens = HIGSystemAlertTokens()
    public let toast: any HIGToastTokens = HIGSystemToastTokens()
    public let badge: any HIGBadgeTokens = HIGSystemBadgeTokens()
    public let list: any HIGListTokens = HIGSystemListTokens()
    public let sidebar: any HIGSidebarTokens = HIGSystemSidebarTokens()

    public init() {}
}
#endif