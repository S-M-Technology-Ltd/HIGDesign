import HIGDesign
import SwiftUI

private enum ShowcaseColorChoice: String, Hashable, Sendable, CaseIterable {
    case accent
    case secondary
    case destructive
    case warning
    case fill
}

struct ShowcaseColorSelectorView: View {
    @Environment(\.higTheme) private var theme
    @State private var selection = ShowcaseColorChoice.accent
    @State private var unlabeled = ShowcaseColorChoice.secondary

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                ShowcaseMetadataView(component: .colorSelector)

                VStack(spacing: theme.spacing.screenEdge) {
                    ShowcaseSampleView(code: """
                    HIGColorSelector(
                        "Theme accent",
                        selection: $color,
                        options: […]
                    )
                    """) {
                        VStack(alignment: .leading, spacing: theme.spacing.item) {
                            HIGColorSelector(
                                "Theme accent",
                                selection: $selection,
                                options: colorOptions
                            )
                            Text("Selected: \(selection.rawValue)")
                                .font(theme.typography.caption)
                                .foregroundStyle(theme.colors.labelSecondary)
                        }
                    }

                    ShowcaseSampleView(code: """
                    HIGColorSelector(
                        selection: $color,
                        options: […]
                    )
                    """) {
                        HIGColorSelector(
                            selection: $unlabeled,
                            options: colorOptions
                        )
                    }
                }
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle("Color Selector")
    }

    private var colorOptions: [HIGColorOption<ShowcaseColorChoice>] {
        [
            HIGColorOption(value: .accent, color: theme.colors.accent, label: "Accent"),
            HIGColorOption(value: .secondary, color: theme.colors.fillPrimary, label: "Fill"),
            HIGColorOption(value: .destructive, color: theme.colors.destructive, label: "Destructive"),
            HIGColorOption(value: .warning, color: theme.colors.warning, label: "Warning"),
            HIGColorOption(value: .fill, color: theme.colors.separator, label: "Separator")
        ]
    }
}

#if DEBUG
#Preview("ShowcaseColorSelectorView") {
    ShowcasePreviewContainer {
        ShowcaseColorSelectorView()
    }
}
#endif
