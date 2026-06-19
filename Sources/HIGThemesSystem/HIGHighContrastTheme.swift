import HIGThemesContract
import HIGTokensComponent
import HIGTokensSemantic
import SwiftUI

public struct HIGHighContrastTheme: HIGTheme, Sendable {
    public let name = "High Contrast"
    public let colors: any HIGColorSemanticTokens
    public let typography: any HIGTypographySemanticTokens
    public let spacing: any HIGSpacingSemanticTokens
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
    public let list: any HIGListTokens
    public let sidebar: any HIGSidebarTokens

    public init(base: HIGSystemTheme = HIGSystemTheme()) {
        let baseColors = base.colors
        self.colors = HIGSystemColorSemanticTokens(
            labelPrimary: baseColors.labelPrimary,
            labelSecondary: baseColors.labelSecondary,
            backgroundPrimary: baseColors.backgroundPrimary,
            backgroundSecondary: baseColors.backgroundSecondary,
            fillPrimary: baseColors.fillPrimary,
            separator: baseColors.separator,
            accent: baseColors.accent,
            destructive: Color.red
        )
        self.typography = base.typography
        self.spacing = base.spacing
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
        self.list = base.list
        self.sidebar = base.sidebar
    }
}