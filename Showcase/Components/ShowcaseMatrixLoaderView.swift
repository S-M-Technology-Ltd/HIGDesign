import HIGDesign
import SwiftUI

struct ShowcaseMatrixLoaderView: View {
    @Environment(\.higTheme) private var theme
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass

    private let sizes: [HIGMatrixLoaderSize] = [.small, .medium, .large]
    private let styles = HIGMatrixLoaderStyle.allCases

    private let families: [(title: String, ids: [HIGMatrixLoaderID])] = [
        ("Square (23)", (1...23).map { .square($0) }),
        ("Circular (20)", (1...20).map { .circular($0) }),
        ("Hex (10)", (1...10).map { .hex($0) }),
        ("3×3 (20)", (1...20).map { .grid3($0) }),
        ("Triangle (20)", (1...20).map { .triangle($0) }),
        ("Fun (18)", HIGMatrixLoaderFun.allCases.map { .fun($0) }),
        ("Icon (1)", [.icon]),
    ]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                ShowcaseMetadataView(component: .matrixLoader)

                Text("\(HIGMatrixLoaderID.catalogCount) clean-room animations")
                    .font(theme.typography.caption)
                    .foregroundStyle(theme.colors.labelSecondary)

                showcaseSection(title: "Sizes") {
                    showcaseTileGrid(compactColumnCount: 3, items: sizes) { size in
                        ShowcaseSurfaceTileView(
                            title: size.rawValue.capitalized,
                            subtitle: "Pulse",
                            code: """
                            HIGMatrixLoader(style: .pulse, size: .\(size.rawValue))
                            """
                        ) {
                            HIGMatrixLoader(style: .pulse, size: size)
                        }
                    }
                }

                showcaseSection(title: "Convenience styles") {
                    showcaseTileGrid(compactColumnCount: 2, items: styles) { style in
                        ShowcaseSurfaceTileView(
                            title: style.rawValue.capitalized,
                            subtitle: style.loaderID.displayName,
                            code: """
                            HIGMatrixLoader(style: .\(style.rawValue), size: .medium)
                            """
                        ) {
                            HIGMatrixLoader(style: style, size: .medium)
                        }
                    }
                }

                showcaseSection(title: "Seeded (stable across 112)") {
                    ShowcaseSampleView(code: """
                    HStack(spacing: theme.spacing.item) {
                        HIGMatrixLoader(seed: "prep", size: .medium)
                        HIGMatrixLoader(seed: "tools", size: .medium)
                        HIGMatrixLoader(seed: "prep", size: .medium)
                    }
                    """) {
                        HStack(spacing: theme.spacing.item) {
                            labeledSeed("prep")
                            labeledSeed("tools")
                            labeledSeed("prep")
                        }
                    }
                }

                ForEach(families, id: \.title) { family in
                    showcaseSection(title: family.title) {
                        LazyVGrid(
                            columns: catalogColumns,
                            alignment: .leading,
                            spacing: theme.spacing.item
                        ) {
                            ForEach(family.ids, id: \.self) { id in
                                VStack(spacing: theme.spacing.compactItem) {
                                    HIGMatrixLoader(id, size: .medium)
                                    Text(id.displayName)
                                        .font(theme.typography.caption)
                                        .foregroundStyle(theme.colors.labelSecondary)
                                        .lineLimit(1)
                                        .minimumScaleFactor(0.7)
                                }
                                .frame(maxWidth: .infinity)
                                .padding(theme.spacing.compactItem)
                                .background(theme.colors.backgroundSecondary)
                                .clipShape(
                                    RoundedRectangle(
                                        cornerRadius: theme.card.cornerRadius,
                                        style: .continuous
                                    )
                                )
                            }
                        }
                    }
                }
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle("Matrix Loader")
    }

    private var catalogColumns: [GridItem] {
        #if os(watchOS)
        [GridItem(.flexible(), spacing: theme.spacing.item)]
        #else
        [
            GridItem(
                .adaptive(minimum: theme.matrixLoader.largeDiameter * 2.2, maximum: .infinity),
                spacing: theme.spacing.item
            ),
        ]
        #endif
    }

    private func labeledSeed(_ key: String) -> some View {
        VStack(spacing: theme.spacing.compactItem) {
            HIGMatrixLoader(seed: key, size: .medium)
            Text(key)
                .font(theme.typography.caption)
                .foregroundStyle(theme.colors.labelSecondary)
        }
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
                    .adaptive(minimum: theme.matrixLoader.largeDiameter * 4, maximum: .infinity),
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
}

#if DEBUG
#Preview("ShowcaseMatrixLoaderView") {
    ShowcasePreviewContainer {
        ShowcaseMatrixLoaderView()
    }
}
#endif
