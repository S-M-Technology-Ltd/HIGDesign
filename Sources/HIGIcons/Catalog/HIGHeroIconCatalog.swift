import Foundation

struct HIGHeroIconCatalogEntry: Decodable, Sendable {
    struct PathEntry: Decodable, Sendable {
        let d: String
        let strokeWidth: CGFloat?
    }

    let paths: [PathEntry]
    let renderMode: HIGHeroIconRenderMode
}

enum HIGHeroIconRenderMode: String, Decodable, Sendable {
    case fill
    case stroke
}

enum HIGHeroIconCatalog {
    private static let entries: [String: [HIGHeroIconVariant: HIGHeroIconCatalogEntry]] = loadEntries()

    static func entry(for token: HIGHeroIconToken, variant: HIGHeroIconVariant) -> HIGHeroIconCatalogEntry? {
        entries[token.rawValue]?[variant]
    }

    private static func loadEntries() -> [String: [HIGHeroIconVariant: HIGHeroIconCatalogEntry]] {
        guard let url = Bundle.module.url(forResource: "hero-icon-catalog", withExtension: "json") else {
            preconditionFailure("Missing hero-icon-catalog.json in HIGIcons resources.")
        }

        do {
            let data = try Data(contentsOf: url)
            let decoded = try JSONDecoder().decode([String: [String: HIGHeroIconCatalogEntry]].self, from: data)
            return decoded.reduce(into: [:]) { result, pair in
                let variants = pair.value.reduce(into: [HIGHeroIconVariant: HIGHeroIconCatalogEntry]()) { variantResult, variantPair in
                    guard let variant = HIGHeroIconVariant(rawValue: variantPair.key) else { return }
                    variantResult[variant] = variantPair.value
                }
                result[pair.key] = variants
            }
        } catch {
            preconditionFailure("Failed to decode hero-icon-catalog.json: \(error)")
        }
    }
}