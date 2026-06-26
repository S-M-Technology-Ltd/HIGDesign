import HIGThemesContract

@MainActor
enum HIGIconsBootstrap {
    private static let activate: Void = {
        HIGThemeRegistration.handler = { theme in
            HIGThemeManager.register(theme)
        }
    }()

    static func ensureActivated() {
        _ = activate
    }
}