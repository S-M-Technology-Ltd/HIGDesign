import HIGDesign
import SwiftUI

/// A showcase sample with live preview content and API code beneath it.
struct ShowcaseSampleView<Content: View>: View {
    @Environment(\.higTheme) private var theme

    let code: String
    var title: String?
    var subtitle: String?
    var layout: Layout = .stack
    var contentAlignment: Alignment = .leading
    @ViewBuilder let content: () -> Content

    enum Layout {
        case stack
        case tile
    }

    var body: some View {
        switch layout {
        case .stack:
            stackBody
        case .tile:
            tileBody
        }
    }

    private var stackBody: some View {
        VStack(alignment: .leading, spacing: theme.spacing.compactItem) {
            content()
                .frame(maxWidth: .infinity, alignment: contentAlignment)

            ShowcaseCodeSnippetView(code: code)
        }
    }

    private var tileBody: some View {
        let cardTokens = theme.card

        return VStack(alignment: .leading, spacing: theme.spacing.compactItem) {
            if let title {
                VStack(spacing: HIGSpacing.none.rawValue) {
                    Text(title)
                        .font(theme.typography.callout.weight(.medium))
                        .foregroundStyle(theme.colors.labelPrimary)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity)

                    if let subtitle {
                        Text(subtitle)
                            .font(theme.typography.caption)
                            .foregroundStyle(theme.colors.labelSecondary)
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity)
                    }
                }
            }

            content()
                .frame(
                    maxWidth: .infinity,
                    minHeight: HIGAccessibility.defaultMinimumTouchTarget,
                    alignment: contentAlignment
                )

            ShowcaseCodeSnippetView(code: code)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(.vertical, theme.spacing.screenEdge)
        .padding(.horizontal, theme.spacing.item)
        .background(theme.colors.backgroundSecondary)
        .clipShape(RoundedRectangle(cornerRadius: cardTokens.cornerRadius, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: cardTokens.cornerRadius, style: .continuous)
                .strokeBorder(theme.colors.separator, lineWidth: cardTokens.borderWidth)
        }
    }
}

#if DEBUG
#Preview("ShowcaseSampleView — Stack") {
    ShowcasePreviewContainer(includeNavigationStack: false) {
        ShowcaseSampleView(code: "HIGButton(\"Continue\", role: .primary) {}") {
            HIGButton("Continue", role: .primary) {}
        }
        .higPadding(.screenEdge)
    }
}

#Preview("ShowcaseSampleView — Tile") {
    ShowcasePreviewContainer(includeNavigationStack: false) {
        ShowcaseSampleView(
            code: "HIGActivityIndicator(nil, size: .medium, style: .orbital)",
            title: "Orbital",
            subtitle: "Medium",
            layout: .tile,
            contentAlignment: .center
        ) {
            HIGActivityIndicator(nil, size: .medium, style: .orbital)
        }
        .higPadding(.screenEdge)
    }
}
#endif