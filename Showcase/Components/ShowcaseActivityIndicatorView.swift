import HIGDesign
import SwiftUI

struct ShowcaseActivityIndicatorView: View {
    @Environment(\.higTheme) private var theme
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass

    private let systemSizes: [HIGActivityIndicatorSize] = [.small, .medium, .large]
    private let customStyles: [HIGActivityIndicatorStyle] = [
        .orbital, .pulsing, .arcs, .rotatingDots, .flickeringDots,
        .scalingDots, .opacityDots, .equalizer, .growingCircle, .gradient,
    ]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                ShowcaseMetadataView(component: .activityIndicator)

                showcaseSection(title: "System sizes") {
                    showcaseTileGrid(compactColumnCount: 2, items: systemSizes) { size in
                        ShowcaseSurfaceTileView(
                            title: size.showcaseTitle,
                            subtitle: "System",
                            code: size.showcaseCode
                        ) {
                            HIGActivityIndicator(nil, size: size, style: .system)
                        }
                    }
                }

                showcaseSection(title: "Custom styles") {
                    showcaseTileGrid(compactColumnCount: 1, items: customStyles) { style in
                        ShowcaseSurfaceTileView(
                            title: style.showcaseLabel,
                            subtitle: "Medium",
                            code: style.showcaseCode
                        ) {
                            HIGActivityIndicator(nil, size: .medium, style: style)
                        }
                    }
                }

                showcaseSection(title: "Shimmer placeholder") {
                    ShowcaseSampleView(code: """
                    VStack(alignment: .leading, spacing: theme.spacing.compactItem) {
                        Text("Loading profile")
                        Text("Fetching account details and preferences.")
                    }
                    .redacted(reason: .placeholder)
                    .higShimmer()
                    """) {
                        shimmerPlaceholder
                    }
                }
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle("Activity Indicator")
    }

    private func showcaseTileGrid<Item: Hashable, Tile: View>(
        compactColumnCount: Int,
        items: [Item],
        @ViewBuilder tile: @escaping (Item) -> Tile
    ) -> some View {
        LazyVGrid(
            columns: showcaseTileColumns(compactColumnCount: compactColumnCount),
            alignment: .leading,
            spacing: theme.spacing.item
        ) {
            ForEach(items, id: \.self) { item in
                tile(item)
                    .frame(maxHeight: .infinity, alignment: .top)
            }
        }
    }

    private func showcaseTileColumns(compactColumnCount: Int) -> [GridItem] {
        #if os(watchOS)
        return [GridItem(.flexible(), spacing: theme.spacing.item, alignment: .top)]
        #else
        if horizontalSizeClass == .regular {
            return [
                GridItem(
                    .adaptive(minimum: showcaseTileMinimumWidth, maximum: .infinity),
                    spacing: theme.spacing.item,
                    alignment: .top
                ),
            ]
        }

        return Array(
            repeating: GridItem(.flexible(), spacing: theme.spacing.item, alignment: .top),
            count: compactColumnCount
        )
        #endif
    }

    /// Wide enough for wrapped API snippets beneath each indicator preview.
    private var showcaseTileMinimumWidth: CGFloat {
        let cardTokens = theme.card
        return cardTokens.contentPadding * 2
            + theme.spacing.section * 10
    }

    private func showcaseSection<Content: View>(
        title: String,
        @ViewBuilder content: () -> Content
    ) -> some View {
        VStack(alignment: .leading, spacing: theme.spacing.item) {
            Text(title)
                .font(theme.typography.headline)
                .foregroundStyle(theme.colors.labelPrimary)

            content()
        }
    }

    private var shimmerPlaceholder: some View {
        let cardTokens = theme.card

        return VStack(alignment: .leading, spacing: theme.spacing.compactItem) {
            Text("Loading profile")
                .font(theme.typography.headline)
                .foregroundStyle(theme.colors.labelPrimary)
            Text("Fetching account details and preferences.")
                .font(theme.typography.callout)
                .foregroundStyle(theme.colors.labelSecondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(cardTokens.contentPadding)
        .redacted(reason: .placeholder)
        .higShimmer()
        .background(theme.colors.backgroundSecondary)
        .clipShape(RoundedRectangle(cornerRadius: cardTokens.cornerRadius, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: cardTokens.cornerRadius, style: .continuous)
                .strokeBorder(theme.colors.separator, lineWidth: cardTokens.borderWidth)
        }
    }
}

private extension HIGActivityIndicatorSize {
    var showcaseTitle: String {
        switch self {
        case .small:
            "Small"
        case .medium:
            "Medium"
        case .large:
            "Large"
        }
    }

    var showcaseCode: String {
        switch self {
        case .small:
            "HIGActivityIndicator(nil, size: .small, style: .system)"
        case .medium:
            "HIGActivityIndicator(nil, size: .medium, style: .system)"
        case .large:
            "HIGActivityIndicator(nil, size: .large, style: .system)"
        }
    }
}

private extension HIGActivityIndicatorStyle {
    var showcaseLabel: String {
        switch self {
        case .system: "System"
        case .orbital: "Orbital"
        case .pulsing: "Pulsing"
        case .arcs: "Arcs"
        case .rotatingDots: "Rotating dots"
        case .flickeringDots: "Flickering dots"
        case .scalingDots: "Scaling dots"
        case .opacityDots: "Opacity dots"
        case .equalizer: "Equalizer"
        case .growingCircle: "Growing circle"
        case .gradient: "Gradient"
        }
    }

    var showcaseCode: String {
        "HIGActivityIndicator(nil, size: .medium, style: .\(showcaseStyleCaseName))"
    }

    var showcaseStyleCaseName: String {
        switch self {
        case .system: "system"
        case .orbital: "orbital"
        case .pulsing: "pulsing"
        case .arcs: "arcs"
        case .rotatingDots: "rotatingDots"
        case .flickeringDots: "flickeringDots"
        case .scalingDots: "scalingDots"
        case .opacityDots: "opacityDots"
        case .equalizer: "equalizer"
        case .growingCircle: "growingCircle"
        case .gradient: "gradient"
        }
    }
}

#if DEBUG
#Preview("ShowcaseActivityIndicatorView") {
    ShowcasePreviewContainer {
        ShowcaseActivityIndicatorView()
    }
}
#endif