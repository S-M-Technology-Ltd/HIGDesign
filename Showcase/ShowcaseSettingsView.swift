import HIGDesign
import SwiftUI

struct ShowcaseSettingsView: View {
    @Environment(\.higTheme) private var theme
    let selection: ShowcaseComponent?
    @Binding var themeChoice: ShowcaseThemeChoice
    @Binding var colorScheme: ColorScheme?
    @Binding var dynamicTypeSizeChoice: ShowcaseDynamicTypeSizeChoice
    @Binding var iconSettings: ShowcaseIconSettings
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @Environment(\.colorSchemeContrast) private var colorSchemeContrast

    var body: some View {
        VStack(alignment: .leading, spacing: theme.spacing.item) {
            Text("Showcase Settings")
                .font(theme.typography.headline)

            Picker("Theme", selection: $themeChoice) {
                ForEach(ShowcaseThemeChoice.allCases) { choice in
                    Text(choice.title).tag(choice)
                }
            }
            #if !os(watchOS)
            .pickerStyle(.segmented)
            #endif

            Picker("Color Scheme", selection: $colorScheme) {
                Text("System").tag(Optional<ColorScheme>.none)
                Text("Light").tag(Optional(ColorScheme.light))
                Text("Dark").tag(Optional(ColorScheme.dark))
            }

            Picker("Dynamic Type", selection: $dynamicTypeSizeChoice) {
                ForEach(ShowcaseDynamicTypeSizeChoice.allCases) { choice in
                    Text(choice.title).tag(choice)
                }
            }
            #if !os(watchOS)
            .pickerStyle(.menu)
            #endif

            if selection == .icon {
                Divider()
                ShowcaseIconSettingsSectionView(settings: $iconSettings)
            }

            VStack(alignment: .leading, spacing: HIGSpacing.xxs.rawValue) {
                Text("Applied Dynamic Type: \(dynamicTypeSizeChoice.title)")
                Text("Environment Dynamic Type: \(String(describing: dynamicTypeSize))")
                Text("Reduce Motion: \(reduceMotion ? "On" : "Off")")
                Text("Contrast: \(colorSchemeContrast == .increased ? "Increased" : "Standard")")
            }
            .font(theme.typography.caption)
            .foregroundStyle(theme.colors.labelSecondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#if DEBUG
#Preview("ShowcaseSettingsView") {
    ShowcasePreviewContainer(includeNavigationStack: false) {
        ShowcaseSettingsView(
            selection: .icon,
            themeChoice: .constant(.system),
            colorScheme: .constant(nil),
            dynamicTypeSizeChoice: .constant(.system),
            iconSettings: .constant(ShowcaseIconSettings())
        )
        .higPadding(.screenEdge)
    }
}
#endif