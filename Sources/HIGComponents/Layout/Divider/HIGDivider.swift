import HIGThemesContract
import SwiftUI

/// A horizontal rule that uses the active theme separator color.
public struct HIGDivider: View {
    public init() {}

    @Environment(\.higTheme) private var theme

    public var body: some View {
        Rectangle()
            .fill(theme.colors.separator)
            .frame(height: 1)
            .accessibilityHidden(true)
    }
}

#if DEBUG
import HIGTokensComponent
import HIGTokensSemantic

private struct HIGDividerPreviewTheme: HIGTheme {
    let name = "Preview"
    let colors: any HIGColorSemanticTokens = HIGSystemColorSemanticTokens()
    let typography: any HIGTypographySemanticTokens = HIGSystemTypographySemanticTokens()
    let spacing: any HIGSpacingSemanticTokens = HIGSystemSpacingSemanticTokens()
    let button: any HIGButtonTokens = HIGSystemButtonTokens()
    let textField: any HIGTextFieldTokens = HIGSystemTextFieldTokens()
    let toggle: any HIGToggleTokens = HIGSystemToggleTokens()
}

#Preview("HIGDivider") {
    HIGThemeableView(theme: HIGDividerPreviewTheme()) {
        VStack(spacing: 16) {
            Text("Above")
            HIGDivider()
            Text("Below")
        }
        .padding()
    }
}
#endif