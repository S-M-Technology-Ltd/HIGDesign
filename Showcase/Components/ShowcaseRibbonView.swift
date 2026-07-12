import HIGDesign
import SwiftUI

struct ShowcaseRibbonView: View {
    @Environment(\.higTheme) private var theme

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                ShowcaseMetadataView(component: .ribbon)

                VStack(spacing: theme.spacing.screenEdge) {
                    ShowcaseSampleView(code: """
                    HIGRibbon("NEW", style: .accent)
                    HIGRibbon("SALE", style: .destructive)
                    HIGRibbon("BETA", style: .neutral)
                    """) {
                        HStack(spacing: theme.spacing.item) {
                            HIGRibbon("NEW", style: .accent)
                            HIGRibbon("SALE", style: .destructive)
                            HIGRibbon("BETA", style: .neutral)
                        }
                    }

                    ShowcaseSampleView(code: """
                    card.higRibbon("NEW", style: .accent, edge: .topTrailing)
                    """) {
                        ribbonHostCard(title: "Featured product")
                            .higRibbon("NEW", style: .accent, edge: .topTrailing)
                            .clipShape(cardShape)
                    }

                    ShowcaseSampleView(code: """
                    card.higRibbon("SALE", style: .destructive, edge: .topLeading)
                    """) {
                        ribbonHostCard(title: "Limited offer")
                            .higRibbon("SALE", style: .destructive, edge: .topLeading)
                            .clipShape(cardShape)
                    }
                }
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle("Ribbon")
    }

    private var cardShape: RoundedRectangle {
        RoundedRectangle(cornerRadius: theme.card.cornerRadius, style: .continuous)
    }

    private func ribbonHostCard(title: String) -> some View {
        Text(title)
            .font(theme.typography.callout)
            .foregroundStyle(theme.colors.labelPrimary)
            .frame(maxWidth: .infinity, minHeight: HIGSpacing.massive.rawValue * 2, alignment: .center)
            .padding(theme.card.contentPadding)
            .background(theme.colors.backgroundSecondary)
            .overlay {
                cardShape.strokeBorder(theme.colors.separator, lineWidth: theme.card.borderWidth)
            }
    }
}

#if DEBUG
#Preview("ShowcaseRibbonView") {
    ShowcasePreviewContainer {
        ShowcaseRibbonView()
    }
}
#endif
