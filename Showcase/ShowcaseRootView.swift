import HIGDesign
import SwiftUI

struct ShowcaseRootView: View {
    @State private var selection: ShowcaseComponent? = .button
    @State private var themeChoice: ShowcaseThemeChoice = .system
    @State private var colorScheme: ColorScheme?

    var body: some View {
        HIGThemeableView(theme: themeChoice.makeTheme()) {
            ShowcaseCatalogView(
                selection: $selection,
                themeChoice: $themeChoice,
                colorScheme: $colorScheme
            )
        }
        .preferredColorScheme(colorScheme)
    }
}

#if DEBUG
#Preview("ShowcaseRootView") {
    ShowcaseRootView()
}
#endif