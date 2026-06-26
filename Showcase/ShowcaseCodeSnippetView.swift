import HIGDesign
import SwiftUI

/// Token-backed monospaced API snippet used under showcase samples.
struct ShowcaseCodeSnippetView: View {
    @Environment(\.higTheme) private var theme

    let code: String

    var body: some View {
        let cardTokens = theme.card

        Text(code)
            .font(theme.typography.caption.monospaced())
            .foregroundStyle(theme.colors.labelSecondary)
            .multilineTextAlignment(.leading)
            .fixedSize(horizontal: false, vertical: true)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(cardTokens.contentPadding)
            .background(theme.colors.fillPrimary)
            .clipShape(RoundedRectangle(cornerRadius: cardTokens.cornerRadius, style: .continuous))
    }
}

#if DEBUG
#Preview("ShowcaseCodeSnippetView") {
    ShowcasePreviewContainer(includeNavigationStack: false) {
        ShowcaseCodeSnippetView(code: "HIGButton(\"Continue\", role: .primary) {}")
            .higPadding(.screenEdge)
    }
}
#endif