#if DEBUG
import HIGTokensComponent
import HIGTokensSemantic
import SwiftUI

private struct HIGThemeablePreviewTheme: HIGTheme {
    let name = "Preview"
    let colors: any HIGColorSemanticTokens = HIGSystemColorSemanticTokens()
    let typography: any HIGTypographySemanticTokens = HIGSystemTypographySemanticTokens()
    let spacing: any HIGSpacingSemanticTokens = HIGSystemSpacingSemanticTokens()
    let button: any HIGButtonTokens = HIGSystemButtonTokens()
    let textField: any HIGTextFieldTokens = HIGSystemTextFieldTokens()
    let toggle: any HIGToggleTokens = HIGSystemToggleTokens()
}

#Preview("HIGThemeableView — Container") {
    HIGThemeableView(theme: HIGThemeablePreviewTheme()) {
        Text("Themed content")
            .padding()
    }
}
#endif