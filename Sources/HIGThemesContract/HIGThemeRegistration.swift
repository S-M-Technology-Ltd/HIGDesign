import SwiftUI

/// Tracks the active theme for imperative access outside SwiftUI environment reads.
@MainActor
public enum HIGThemeRegistration {
    private(set) public static var currentTheme: (any HIGTheme)?

    public static func register(_ theme: any HIGTheme) {
        currentTheme = theme
    }
}

struct HIGThemeRegistrationBridge<Content: View>: View {
    private let theme: any HIGTheme
    private let content: () -> Content

    init(theme: any HIGTheme, @ViewBuilder content: @escaping () -> Content) {
        self.theme = theme
        self.content = content
        HIGThemeRegistration.register(theme)
    }

    var body: some View {
        content()
    }
}