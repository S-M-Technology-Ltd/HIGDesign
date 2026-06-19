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
    var card: any HIGCardTokens { get }
    var progress: any HIGProgressTokens { get }
    var alert: any HIGAlertTokens { get }
    var toast: any HIGToastTokens { get }
}