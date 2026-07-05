import HIGDesign
import SwiftUI

#if canImport(AppKit)
import AppKit
#endif

/// Full showcase split view for macOS platform snapshots with a pre-selected component.
struct ShowcaseSnapshotPlatformCaptureView: View {
    @State private var selection: ShowcaseComponent?
    @State private var themeChoice: ShowcaseThemeChoice
    @State private var colorScheme: ColorScheme?
    @State private var dynamicTypeSizeChoice: ShowcaseDynamicTypeSizeChoice = .system
    @State private var iconSettings = ShowcaseIconSettings()

    let component: ShowcaseComponent
    let entryTheme: ShowcaseThemeChoice
    let entryColorScheme: ColorScheme

    init(
        component: ShowcaseComponent,
        themeChoice: ShowcaseThemeChoice,
        colorScheme: ColorScheme
    ) {
        self.component = component
        entryTheme = themeChoice
        entryColorScheme = colorScheme
        _themeChoice = State(initialValue: themeChoice)
        _colorScheme = State(initialValue: colorScheme)
        _selection = State(initialValue: component)
    }

    var body: some View {
        ZStack {
            Color(nsColor: .windowBackgroundColor)
            ShowcaseCatalogView(
                selection: $selection,
                themeChoice: $themeChoice,
                colorScheme: $colorScheme,
                dynamicTypeSizeChoice: $dynamicTypeSizeChoice,
                iconSettings: $iconSettings
            )
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .preferredColorScheme(entryColorScheme)
        #if os(macOS)
        .tint(Color(nsColor: .controlAccentColor))
        #endif
        .onAppear {
            selection = component
        }
    }
}