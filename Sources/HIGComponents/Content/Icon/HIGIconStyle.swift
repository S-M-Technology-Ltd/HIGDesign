import HIGThemesContract
import SwiftUI

/// Color emphasis for ``HIGIcon``.
public enum HIGIconStyle: Sendable {
    case primary
    case secondary
    case accent

    func color(theme: any HIGTheme) -> Color {
        switch self {
        case .primary:
            theme.colors.labelPrimary
        case .secondary:
            theme.colors.labelSecondary
        case .accent:
            theme.colors.accent
        }
    }
}