import HIGThemesContract

/// Provides imperative access to the active HIG theme and icon tokens.
@MainActor
public enum HIGThemeManager {
    private static var registeredTheme: (any HIGTheme)?

    /// The theme most recently registered by ``HIGThemeableView``.
    public static var current: any HIGTheme {
        guard let registeredTheme else {
            preconditionFailure("HIGTheme is required. Wrap content in HIGThemeableView(theme:).")
        }
        return registeredTheme
    }

    /// Resolves an outline Heroicon token from ``current``.
    public static func outlineIcon(from token: HIGHeroIconToken) -> HIGHeroIconDescriptor {
        current.outlineIcon(from: token)
    }

    /// Resolves a solid Heroicon token from ``current``.
    public static func solidIcon(from token: HIGHeroIconToken) -> HIGHeroIconDescriptor {
        current.solidIcon(from: token)
    }

    static func register(_ theme: any HIGTheme) {
        registeredTheme = theme
    }
}