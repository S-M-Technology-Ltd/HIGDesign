import HIGDesign
import SwiftUI

/// Full showcase catalog chrome for catalog snapshot entries.
struct ShowcaseSnapshotCatalogCaptureView: View {
    @State private var selection: ShowcaseComponent?
    @State private var themeChoice: ShowcaseThemeChoice = .system
    @State private var colorScheme: ColorScheme?
    @State private var dynamicTypeSizeChoice: ShowcaseDynamicTypeSizeChoice = .system
    @State private var iconSettings = ShowcaseIconSettings()

    let entryTheme: ShowcaseThemeChoice
    let entryColorScheme: ColorScheme

    init(themeChoice: ShowcaseThemeChoice, colorScheme: ColorScheme) {
        entryTheme = themeChoice
        entryColorScheme = colorScheme
        _themeChoice = State(initialValue: themeChoice)
        _colorScheme = State(initialValue: colorScheme)
    }

    var body: some View {
        ShowcaseCatalogView(
            section: .components,
            selection: $selection,
            themeChoice: $themeChoice,
            colorScheme: $colorScheme,
            dynamicTypeSizeChoice: $dynamicTypeSizeChoice,
            iconSettings: $iconSettings
        )
        .preferredColorScheme(entryColorScheme)
    }
}