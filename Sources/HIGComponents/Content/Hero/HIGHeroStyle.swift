import Foundation

/// Visual emphasis for ``HIGHero``.
public enum HIGHeroStyle: String, Sendable, CaseIterable {
    /// Secondary background with primary/secondary labels and border.
    case standard
    /// Accent fill with on-accent labels (marketing / call-to-action hero).
    case accent
}
