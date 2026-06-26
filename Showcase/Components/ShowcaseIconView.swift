import HIGDesign
import SwiftUI

struct ShowcaseIconView: View {
    @Binding var iconSettings: ShowcaseIconSettings
    @Environment(\.higTheme) private var theme

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                ShowcaseMetadataView(component: .icon)

                #if os(watchOS)
                ShowcaseIconSettingsSectionView(settings: $iconSettings)
                #endif

                playgroundPreview

                Text("Examples")
                    .font(theme.typography.headline)
                    .foregroundStyle(theme.colors.labelPrimary)

                VStack(spacing: theme.spacing.item) {
                    ShowcaseSampleView(code: "HIGIcon(\"bell\", size: .small)", contentAlignment: .center) {
                        HIGIcon("bell", size: .small)
                    }
                    ShowcaseSampleView(code: "HIGIcon(\"star.fill\", style: .accent)", contentAlignment: .center) {
                        HIGIcon("star.fill", style: .accent)
                    }
                    ShowcaseSampleView(code: "HIGIcon(\"folder\", size: .large, style: .secondary)", contentAlignment: .center) {
                        HIGIcon("folder", size: .large, style: .secondary)
                    }
                    ShowcaseSampleView(code: "HIGIcon(\"checkmark.circle.fill\", style: .accent)", contentAlignment: .center) {
                        HIGIcon("checkmark.circle.fill", style: .accent)
                    }
                    ShowcaseSampleView(code: "HIGIcon(\"exclamationmark.triangle.fill\", style: .primary)", contentAlignment: .center) {
                        HIGIcon("exclamationmark.triangle.fill", style: .primary)
                    }
                    ShowcaseSampleView(code: "HIGIcon(\"info.circle\", style: .secondary)", contentAlignment: .center) {
                        HIGIcon("info.circle", style: .secondary)
                    }
                }

                Text("Heroicons")
                    .font(theme.typography.headline)
                    .foregroundStyle(theme.colors.labelPrimary)

                VStack(spacing: theme.spacing.item) {
                    ShowcaseSampleView(
                        code: "HIGHeroIcon(descriptor: theme.outlineIcon(from: .academicCap))",
                        contentAlignment: .center
                    ) {
                        HIGHeroIcon(descriptor: theme.outlineIcon(from: .academicCap))
                    }
                    ShowcaseSampleView(
                        code: "HIGHeroIcon(descriptor: theme.solidIcon(from: .academicCap), style: .accent)",
                        contentAlignment: .center
                    ) {
                        HIGHeroIcon(descriptor: theme.solidIcon(from: .academicCap), style: .accent)
                    }
                    ShowcaseSampleView(
                        code: "HIGHeroIcon(.bell, variant: .outline, size: .large)",
                        contentAlignment: .center
                    ) {
                        HIGHeroIcon(.bell, variant: .outline, size: .large)
                    }
                    ShowcaseSampleView(
                        code: "HIGHeroIcon(.bell, variant: .solid, style: .secondary)",
                        contentAlignment: .center
                    ) {
                        HIGHeroIcon(.bell, variant: .solid, style: .secondary)
                    }
                }
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle("Icon")
    }

    private var playgroundPreview: some View {
        VStack(alignment: .leading, spacing: theme.spacing.screenEdge) {
            Text("Live Preview")
                .font(theme.typography.headline)
                .foregroundStyle(theme.colors.labelPrimary)

            ShowcaseSampleView(code: apiSnippet, contentAlignment: .center) {
                HStack {
                    Spacer()
                    playgroundIcon
                    Spacer()
                }
                .padding(.vertical, theme.spacing.item)
            }
        }
    }

    @ViewBuilder
    private var playgroundIcon: some View {
        switch iconSettings.family {
        case .sfSymbol:
            HIGIcon(
                iconSettings.sfSymbolName,
                size: iconSettings.higSize,
                style: iconSettings.higStyle
            )
        case .heroicon:
            HIGHeroIcon(
                iconSettings.heroiconToken.token,
                variant: iconSettings.heroiconVariant,
                size: iconSettings.higSize,
                style: iconSettings.higStyle
            )
        }
    }

    private var apiSnippet: String {
        let sizeLabel = apiSizeLabel
        let styleLabel = apiStyleLabel

        switch iconSettings.family {
        case .sfSymbol:
            return """
            HIGIcon("\(iconSettings.sfSymbolName)", \
            size: \(sizeLabel), \
            style: \(styleLabel))
            """
        case .heroicon:
            let variantLabel = iconSettings.heroiconVariant == .outline ? ".outline" : ".solid"
            return """
            HIGHeroIcon(.\(iconSettings.heroiconToken.rawValue), \
            variant: \(variantLabel), \
            size: \(sizeLabel), \
            style: \(styleLabel))
            """
        }
    }

    private var apiSizeLabel: String {
        switch iconSettings.sizeChoice {
        case .small:
            ".small"
        case .medium:
            ".medium"
        case .large:
            ".large"
        case .fixed:
            ".fixed(\(Int(iconSettings.fixedSize)))"
        }
    }

    private var apiStyleLabel: String {
        switch iconSettings.styleChoice {
        case .primary:
            ".primary"
        case .secondary:
            ".secondary"
        case .accent:
            ".accent"
        case .tint:
            ".tint(.orange)"
        }
    }
}

#if DEBUG
#Preview("ShowcaseIconView") {
    ShowcasePreviewContainer(includeNavigationStack: false) {
        NavigationStack {
            ShowcaseIconView(iconSettings: .constant(ShowcaseIconSettings()))
        }
    }
}
#endif