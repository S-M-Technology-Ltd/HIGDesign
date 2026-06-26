import HIGThemesContract

extension HIGTheme {
    /// Resolves an outline Heroicon token from the active theme.
    public func outlineIcon(from token: HIGHeroIconToken) -> HIGHeroIconDescriptor {
        HIGHeroIconDescriptor(token: token, variant: .outline)
    }

    /// Resolves a solid Heroicon token from the active theme.
    public func solidIcon(from token: HIGHeroIconToken) -> HIGHeroIconDescriptor {
        HIGHeroIconDescriptor(token: token, variant: .solid)
    }
}