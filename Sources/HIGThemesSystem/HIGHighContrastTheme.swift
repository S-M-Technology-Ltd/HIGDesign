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
    }
}