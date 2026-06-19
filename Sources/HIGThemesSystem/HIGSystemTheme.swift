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

    public init(
        colors: any HIGColorSemanticTokens = HIGSystemColorSemanticTokens(),
        typography: any HIGTypographySemanticTokens = HIGSystemTypographySemanticTokens(),
        spacing: any HIGSpacingSemanticTokens = HIGSystemSpacingSemanticTokens(),
        button: any HIGButtonTokens = HIGSystemButtonTokens(),
        textField: any HIGTextFieldTokens = HIGSystemTextFieldTokens(),
        toggle: any HIGToggleTokens = HIGSystemToggleTokens(),
        card: any HIGCardTokens = HIGSystemCardTokens(),
        progress: any HIGProgressTokens = HIGSystemProgressTokens()
    ) {
        self.colors = colors
        self.typography = typography
        self.spacing = spacing
        self.button = button
        self.textField = textField
        self.toggle = toggle
        self.card = card
        self.progress = progress
    }
}