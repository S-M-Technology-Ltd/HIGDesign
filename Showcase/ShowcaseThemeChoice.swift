import HIGDesign

enum ShowcaseThemeChoice: String, CaseIterable, Identifiable, Sendable {
    case system
    case highContrast

    var id: String { rawValue }

    var title: String {
        switch self {
        case .system:
            "System"
        case .highContrast:
            "High Contrast"
        }
    }

    func makeTheme() -> any HIGTheme {
        switch self {
        case .system:
            HIGSystemTheme()
        case .highContrast:
            HIGHighContrastTheme()
        }
    }
}