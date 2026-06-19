import HIGDesign
import SwiftUI

public struct ShowcaseRootView: View {
    @State private var selection: ShowcaseComponent? = .button
    @State private var themeChoice: ShowcaseThemeChoice = .system
    @State private var colorScheme: ColorScheme?
    @State private var dynamicTypeSizeChoice: ShowcaseDynamicTypeSizeChoice = .system

    public init() {}

    public var body: some View {
        Group {
            HIGThemeableView(theme: themeChoice.makeTheme()) {
                ShowcaseCatalogView(
                    selection: $selection,
                    themeChoice: $themeChoice,
                    colorScheme: $colorScheme,
                    dynamicTypeSizeChoice: $dynamicTypeSizeChoice
                )
            }
        }
        .preferredColorScheme(colorScheme)
        .modifier(ShowcaseDynamicTypeSizeModifier(choice: dynamicTypeSizeChoice))
    }
}

#if DEBUG
#Preview("ShowcaseRootView") {
    ShowcaseRootView()
}
#endif