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
    public let card: any HIGCardTokens = HIGSystemCardTokens()
    public let progress: any HIGProgressTokens = HIGSystemProgressTokens()

    public init() {}
}
#endif