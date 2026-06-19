import HIGThemesContract
import SwiftUI

/// Visual emphasis for ``HIGAlertBanner``.
public enum HIGAlertBannerStyle: Sendable {
    case info
    case warning
    case error

    var systemImage: String {
        switch self {
        case .info:
            "info.circle.fill"
        case .warning:
            "exclamationmark.triangle.fill"
        case .error:
            "xmark.octagon.fill"
        }
    }

    func accentColor(theme: any HIGTheme) -> Color {
        switch self {
        case .info:
            theme.colors.accent
        case .warning:
            .orange
        case .error:
            theme.colors.destructive
        }
    }

    func backgroundColor(theme: any HIGTheme) -> Color {
        accentColor(theme: theme).opacity(0.12)
    }
}