import HIGDesign
import SwiftUI

struct ShowcaseIconSettingsSectionView: View {
    @Binding var settings: ShowcaseIconSettings
    @Environment(\.higTheme) private var theme

    var body: some View {
        VStack(alignment: .leading, spacing: theme.spacing.item) {
            Text("Icon Playground")
                .font(theme.typography.headline)
                .foregroundStyle(theme.colors.labelPrimary)

            Picker("Family", selection: $settings.family) {
                ForEach(ShowcaseIconFamily.allCases) { family in
                    Text(family.title).tag(family)
                }
            }
            #if !os(watchOS)
            .pickerStyle(.segmented)
            #endif

            switch settings.family {
            case .sfSymbol:
                TextField("SF Symbol name", text: $settings.sfSymbolName)
                    #if !os(watchOS)
                    .textFieldStyle(.roundedBorder)
                    #endif
            case .heroicon:
                Picker("Heroicon", selection: $settings.heroiconToken) {
                    ForEach(ShowcaseHeroiconTokenChoice.allCases) { token in
                        Text(token.title).tag(token)
                    }
                }
                #if !os(watchOS)
                .pickerStyle(.menu)
                #endif

                Picker("Variant", selection: $settings.heroiconVariant) {
                    Text("Outline").tag(HIGHeroIconVariant.outline)
                    Text("Solid").tag(HIGHeroIconVariant.solid)
                }
                #if !os(watchOS)
                .pickerStyle(.segmented)
                #endif
            }

            Picker("Size", selection: $settings.sizeChoice) {
                ForEach(ShowcaseIconSizeChoice.allCases) { size in
                    Text(size.title).tag(size)
                }
            }
            #if !os(watchOS)
            .pickerStyle(.menu)
            #endif

            if settings.sizeChoice == .fixed {
                HStack(spacing: theme.spacing.compactItem) {
                    Text("Fixed Size")
                    Slider(
                        value: $settings.fixedSize,
                        in: fixedIconSizeRange,
                        step: HIGSpacing.xxs.rawValue
                    )
                    Text("\(Int(settings.fixedSize)) pt")
                        .monospacedDigit()
                        .frame(width: HIGAccessibility.defaultMinimumTouchTarget, alignment: .trailing)
                }
                .font(theme.typography.caption)
                .foregroundStyle(theme.colors.labelSecondary)
            }

            Picker("Style", selection: $settings.styleChoice) {
                ForEach(ShowcaseIconStyleChoice.allCases) { style in
                    Text(style.title).tag(style)
                }
            }
            #if !os(watchOS)
            .pickerStyle(.menu)
            #endif

            if settings.styleChoice == .tint {
                ColorPicker("Tint", selection: $settings.customTint, supportsOpacity: false)
            }
        }
    }

    private var fixedIconSizeRange: ClosedRange<Double> {
        let iconTokens = theme.icon
        return Double(iconTokens.smallSize)...ShowcaseIconSettings.maxFixedSize
    }
}

#if DEBUG
#Preview("ShowcaseIconSettingsSectionView") {
    ShowcasePreviewContainer(includeNavigationStack: false) {
        ShowcaseIconSettingsSectionView(settings: .constant(ShowcaseIconSettings()))
            .higPadding(.screenEdge)
    }
}
#endif