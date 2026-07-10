import HIGThemesContract
import HIGTokensComponent
import SwiftUI

/// A themed tooltip label bubble for short helper copy.
///
/// Prefer ``View/higTooltip(_:)`` for platform help/hover tooltips. Use this view
/// when you need a visible, token-backed label (showcase, custom overlays).
public struct HIGTooltipLabel: View {
    private let text: String

    @Environment(\.higTheme) private var theme

    public init(_ text: String) {
        self.text = text
    }

    public var body: some View {
        let tokens = theme.tooltip

        Text(text)
            .font(tokens.font)
            .foregroundStyle(theme.colors.labelOnAccent)
            .multilineTextAlignment(.leading)
            .padding(.horizontal, tokens.horizontalPadding)
            .padding(.vertical, tokens.verticalPadding)
            .frame(maxWidth: tokens.maxWidth, alignment: .leading)
            .background(theme.colors.accent)
            .clipShape(RoundedRectangle(cornerRadius: tokens.cornerRadius, style: .continuous))
            .accessibilityLabel(text)
    }
}

#if DEBUG
#Preview("HIGTooltipLabel") {
    HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        HIGTooltipLabel("Save changes before leaving this page.")
            .padding()
    }
}
#endif
