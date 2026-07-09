import HIGDesign
import SwiftUI

public enum ShowcaseThemeChoice: String, CaseIterable, Identifiable, Sendable {
    case system
    case highContrast
    case brand
    case custom

    public var id: String { rawValue }

    public var title: String {
        switch self {
        case .system:
            "System"
        case .highContrast:
            "High Contrast"
        case .brand:
            "Brand"
        case .custom:
            "Custom"
        }
    }

    public func makeTheme() -> any HIGTheme {
        switch self {
        case .system:
            HIGSystemTheme()
        case .highContrast:
            HIGHighContrastTheme()
        case .brand:
            HIGBrandTheme(name: "Brand", accent: .purple)
        case .custom:
            ShowcaseCustomTheme()
        }
    }
}

private struct ShowcaseCustomTheme: HIGTheme {
    let name = "Custom"
    let colors = HIGSystemColorSemanticTokens(accent: .indigo, warning: .mint)
    let button = HIGSystemButtonTokens(minHeight: 56, cornerRadius: 16, font: .headline)
    let card = HIGSystemCardTokens(cornerRadius: 24, contentPadding: 24)
    let textField = HIGSystemTextFieldTokens(cornerRadius: 14, borderWidth: 2)
    let tag = HIGSystemTagTokens(cornerRadius: 12, font: .callout.weight(.semibold))
    let toast = HIGSystemToastTokens(cornerRadius: 20)
    let spacing = HIGSystemSpacingSemanticTokens(screenEdge: 28, section: 36, item: 14)
}