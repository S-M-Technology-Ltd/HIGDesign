import HIGDesign
import SwiftUI

struct ShowcaseSettingsView: View {
    @Binding var themeChoice: ShowcaseThemeChoice
    @Binding var colorScheme: ColorScheme?
    @Binding var dynamicTypeSizeChoice: ShowcaseDynamicTypeSizeChoice
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @Environment(\.colorSchemeContrast) private var colorSchemeContrast

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Showcase Settings")
                .font(.headline)

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

            VStack(alignment: .leading, spacing: 4) {
                Text("Applied Dynamic Type: \(dynamicTypeSizeChoice.title)")
                Text("Environment Dynamic Type: \(String(describing: dynamicTypeSize))")
                Text("Reduce Motion: \(reduceMotion ? "On" : "Off")")
                Text("Contrast: \(colorSchemeContrast == .increased ? "Increased" : "Standard")")
            }
            .font(.caption)
            .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#if DEBUG
#Preview("ShowcaseSettingsView") {
    ShowcaseSettingsView(
        themeChoice: .constant(.system),
        colorScheme: .constant(nil),
        dynamicTypeSizeChoice: .constant(.system)
    )
        .padding()
}
#endif