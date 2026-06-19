import HIGTokensComponent
import HIGTokensSemantic

public protocol HIGTheme: Sendable {
    var name: String { get }
    var colors: any HIGColorSemanticTokens { get }
    var typography: any HIGTypographySemanticTokens { get }
    var spacing: any HIGSpacingSemanticTokens { get }
    var button: any HIGButtonTokens { get }
}