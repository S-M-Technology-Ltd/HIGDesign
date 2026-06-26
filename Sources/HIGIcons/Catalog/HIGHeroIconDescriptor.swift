import Foundation

/// A theme-aware Heroicons reference resolved from the active theme.
public struct HIGHeroIconDescriptor: Hashable, Sendable {
    public let token: HIGHeroIconToken
    public let variant: HIGHeroIconVariant

    public init(token: HIGHeroIconToken, variant: HIGHeroIconVariant) {
        self.token = token
        self.variant = variant
    }
}