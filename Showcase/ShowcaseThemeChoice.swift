import HIGDesign

public enum ShowcaseThemeChoice: String, CaseIterable, Identifiable, Sendable {
    case system
    case highContrast
    case brand

    public var id: String { rawValue }

    public var title: String {
        switch self {
        case .system:
            "System"
        case .highContrast:
            "High Contrast"
        case .brand:
            "Brand"
        }
    }

    public func makeTheme() -> any HIGTheme {
        switch self {
        case .system:
            HIGSystemTheme()
        case .highContrast:
            HIGHighContrastTheme()
        case .brand:
            HIGBrandTheme(name: "Brand", accent: .purple)
        }
    }
}