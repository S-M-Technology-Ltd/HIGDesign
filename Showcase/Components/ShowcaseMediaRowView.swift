import HIGDesign
import SwiftUI

struct ShowcaseMediaRowView: View {
    @Environment(\.higTheme) private var theme

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                ShowcaseMetadataView(component: .mediaRow)

                VStack(spacing: theme.spacing.screenEdge) {
                    ShowcaseSampleView(code: """
                    HIGMediaRow(
                        "Alex Rivera",
                        subtitle: "Product designer · Online",
                        showsBorder: true
                    ) {
                        HIGAvatar("AR", status: .online)
                    } trailing: {
                        Image(systemName: "chevron.right")
                    }
                    """) {
                        VStack(spacing: theme.spacing.item) {
                            HIGMediaRow(
                                "Alex Rivera",
                                subtitle: "Product designer · Online",
                                showsBorder: true
                            ) {
                                HIGAvatar("AR", status: .online)
                            } trailing: {
                                Image(systemName: "chevron.right")
                                    .foregroundStyle(theme.colors.labelSecondary)
                            }

                            HIGMediaRow(
                                "Jordan Lee",
                                subtitle: "Engineering · Away",
                                showsBorder: true
                            ) {
                                HIGAvatar("JL", status: .away)
                            } trailing: {
                                HIGBadge("Pro")
                            }
                        }
                    }

                    ShowcaseSampleView(code: """
                    HIGMediaRow(
                        "Release notes",
                        subtitle: "v1.4.0 matrix loader shipped.",
                        showsBorder: true
                    ) {
                        Image(systemName: "doc.text")
                    }
                    """) {
                        HIGMediaRow(
                            "Release notes",
                            subtitle: "v1.4.0 matrix loader shipped.",
                            showsBorder: true
                        ) {
                            Image(systemName: "doc.text")
                                .font(theme.typography.title)
                                .foregroundStyle(theme.colors.accent)
                        }
                    }
                }
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle("Media Row")
    }
}

#if DEBUG
#Preview("ShowcaseMediaRowView") {
    ShowcasePreviewContainer {
        ShowcaseMediaRowView()
    }
}
#endif
