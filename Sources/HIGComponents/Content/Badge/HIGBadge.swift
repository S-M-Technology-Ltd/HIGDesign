import HIGThemesContract
import HIGTokensRaw
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
        case .accent, .info:
            theme.colors.labelOnAccent
        case .success, .warning, .destructive:
            theme.colors.labelOnAccent
        }
    }

    private var backgroundColor: Color {
        switch style {
        case .neutral:
            theme.colors.fillPrimary
        case .accent, .info:
            theme.colors.accent
        case .success:
            theme.colors.success
        case .warning:
            theme.colors.warning
        case .destructive:
            theme.colors.destructive
        }
    }
}

#if DEBUG
#Preview("HIGBadge") {
    HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        HStack(spacing: HIGSpacing.md.rawValue) {
            HIGBadge("New")
            HIGBadge("3", style: .accent)
            HIGBadge("OK", style: .success)
            HIGBadge("Soon", style: .warning)
            HIGBadge("!", style: .destructive)
            HIGBadge("Info", style: .info)
        }
        .padding()
    }
}
#endif
