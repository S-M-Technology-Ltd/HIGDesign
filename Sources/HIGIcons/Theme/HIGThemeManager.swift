import HIGThemesContract

/// Provides imperative access to the active HIG theme and icon tokens.
@MainActor
public enum HIGThemeManager {
    /// The theme most recently registered by ``HIGThemeableView``.
    public static var current: any HIGTheme {
        guard let theme = HIGThemeRegistration.currentTheme else {
            preconditionFailure("HIGTheme is required. Wrap content in HIGThemeableView(theme:).")
        }
        return theme
    }

    /// Resolves an outline Heroicon token from ``current``.
    public static func outlineIcon(from token: HIGHeroIconToken) -> HIGHeroIconDescriptor {
        current.outlineIcon(from: token)
    }

    /// Resolves a solid Heroicon token from ``current``.
    public static func solidIcon(from token: HIGHeroIconToken) -> HIGHeroIconDescriptor {
        current.solidIcon(from: token)
    }
}