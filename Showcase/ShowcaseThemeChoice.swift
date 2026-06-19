import HIGDesign

public enum ShowcaseThemeChoice: String, CaseIterable, Identifiable, Sendable {
    case system
    case highContrast

    public var id: String { rawValue }

    public var title: String {
        switch self {
        case .system:
            "System"
        case .highContrast:
            "High Contrast"
        }
    }

    public func makeTheme() -> any HIGTheme {
        switch self {
        case .system:
            HIGSystemTheme()
        case .highContrast:
            HIGHighContrastTheme()
        }
    }
}