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
    public let card: any HIGCardTokens
    public let progress: any HIGProgressTokens
    public let alert: any HIGAlertTokens
    public let toast: any HIGToastTokens
    public let badge: any HIGBadgeTokens
    public let list: any HIGListTokens

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
        self.card = base.card
        self.progress = base.progress
        self.alert = base.alert
        self.toast = base.toast
        self.badge = base.badge
        self.list = base.list
    }
}