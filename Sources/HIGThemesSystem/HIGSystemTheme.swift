import HIGThemesContract
import HIGTokensComponent
import HIGTokensSemantic

public struct HIGSystemTheme: HIGTheme, Sendable {
    public let name = "System"
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
    public let sidebar: any HIGSidebarTokens

    public init(
        colors: any HIGColorSemanticTokens = HIGSystemColorSemanticTokens(),
        typography: any HIGTypographySemanticTokens = HIGSystemTypographySemanticTokens(),
        spacing: any HIGSpacingSemanticTokens = HIGSystemSpacingSemanticTokens(),
        button: any HIGButtonTokens = HIGSystemButtonTokens(),
        textField: any HIGTextFieldTokens = HIGSystemTextFieldTokens(),
        toggle: any HIGToggleTokens = HIGSystemToggleTokens(),
        card: any HIGCardTokens = HIGSystemCardTokens(),
        progress: any HIGProgressTokens = HIGSystemProgressTokens(),
        alert: any HIGAlertTokens = HIGSystemAlertTokens(),
        toast: any HIGToastTokens = HIGSystemToastTokens(),
        badge: any HIGBadgeTokens = HIGSystemBadgeTokens(),
        list: any HIGListTokens = HIGSystemListTokens(),
        sidebar: any HIGSidebarTokens = HIGSystemSidebarTokens()
    ) {
        self.colors = colors
        self.typography = typography
        self.spacing = spacing
        self.button = button
        self.textField = textField
        self.toggle = toggle
        self.card = card
        self.progress = progress
        self.alert = alert
        self.toast = toast
        self.badge = badge
        self.list = list
        self.sidebar = sidebar
    }
}