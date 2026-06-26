import SwiftUI

/// Color emphasis for icon components.
public enum HIGIconStyle: Sendable {
    case primary
    case secondary
    case accent
    /// A custom tint color that overrides theme semantic icon colors.
    case tint(Color)

    public func color(theme: any HIGTheme) -> Color {
        switch self {
        case .primary:
            theme.colors.labelPrimary
        case .secondary:
            theme.colors.labelSecondary
        case .accent:
            theme.colors.accent
        case .tint(let color):
            color
        }
    }
}