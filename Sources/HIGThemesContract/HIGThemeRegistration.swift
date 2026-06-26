import SwiftUI

/// Optional hook for modules that need imperative access to the active theme.
@MainActor
public enum HIGThemeRegistration {
    public static var handler: ((any HIGTheme) -> Void)?
}

struct HIGThemeRegistrationView: View {
    let theme: any HIGTheme

    var body: some View {
        Color.clear
            .frame(width: 0, height: 0)
            .accessibilityHidden(true)
            .onAppear {
                HIGThemeRegistration.handler?(theme)
            }
    }
}

