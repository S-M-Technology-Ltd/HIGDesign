import HIGThemesContract
import HIGTokensComponent
import HIGTokensSemantic

public struct HIGSystemTheme: HIGTheme, Sendable {
    public let name = "System"
    public let colors: any HIGColorSemanticTokens
    public let typography: any HIGTypographySemanticTokens
    public let spacing: any HIGSpacingSemanticTokens
    public let button: any HIGButtonTokens

    public init(
        colors: any HIGColorSemanticTokens = HIGSystemColorSemanticTokens(),
        typography: any HIGTypographySemanticTokens = HIGSystemTypographySemanticTokens(),
        spacing: any HIGSpacingSemanticTokens = HIGSystemSpacingSemanticTokens(),
        button: any HIGButtonTokens = HIGSystemButtonTokens()
    ) {
        self.colors = colors
        self.typography = typography
        self.spacing = spacing
        self.button = button
    }
}