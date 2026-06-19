import HIGThemesContract
import SwiftUI

/// A compact status label for counts and short metadata.
public struct HIGBadge: View {
    private let text: String
    private let style: HIGBadgeStyle

    @Environment(\.higTheme) private var theme

    public init(_ text: String, style: HIGBadgeStyle = .neutral) {
        self.text = text
        self.style = style
    }

    public var body: some View {
        let tokens = theme.badge

        Text(text)
            .font(tokens.font)
            .foregroundStyle(foregroundColor)
            .padding(.horizontal, tokens.horizontalPadding)
            .padding(.vertical, tokens.verticalPadding)
            .background(backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: tokens.cornerRadius, style: .continuous))
            .accessibilityLabel("Badge \(text)")
    }

    private var foregroundColor: Color {
        switch style {
        case .neutral:
            theme.colors.labelPrimary
        case .accent:
            Color.white
        case .destructive:
            theme.colors.destructive
        }
    }

    private var backgroundColor: Color {
        switch style {
        case .neutral:
            theme.colors.fillPrimary
        case .accent:
            theme.colors.accent
        case .destructive:
            theme.colors.destructive.opacity(0.12)
        }
    }
}

#if DEBUG
#Preview("HIGBadge") {
    HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        HStack(spacing: 12) {
            HIGBadge("New")
            HIGBadge("3", style: .accent)
            HIGBadge("!", style: .destructive)
        }
        .padding()
    }
}
#endif