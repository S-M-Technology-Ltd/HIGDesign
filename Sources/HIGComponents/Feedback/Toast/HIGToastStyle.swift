import HIGThemesContract
import SwiftUI

/// Visual emphasis for ``HIGToast`` feedback.
public enum HIGToastStyle: String, Sendable, CaseIterable, Equatable {
    case neutral
    case success
    case warning
    case error
    case info

    var systemImage: String {
        switch self {
        case .neutral:
            "bell.fill"
        case .success:
            "checkmark.circle.fill"
        case .warning:
            "exclamationmark.triangle.fill"
        case .error:
            "xmark.octagon.fill"
        case .info:
            "info.circle.fill"
        }
    }

    func accentColor(theme: any HIGTheme) -> Color {
        switch self {
        case .neutral:
            theme.colors.labelSecondary
        case .success:
            theme.colors.success
        case .warning:
            theme.colors.warning
        case .error:
            theme.colors.destructive
        case .info:
            theme.colors.accent
        }
    }
}
