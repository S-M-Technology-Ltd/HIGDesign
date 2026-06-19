import HIGThemesContract
import SwiftUI

/// A pill-shaped label for categories, filters, and metadata chips.
public struct HIGTag: View {
    private let text: String
    private let style: HIGTagStyle

    @Environment(\.higTheme) private var theme

    public init(_ text: String, style: HIGTagStyle = .neutral) {
        self.text = text
        self.style = style
    }

    public var body: some View {
        let tokens = theme.tag

        Text(text)
            .font(tokens.font)
            .foregroundStyle(foregroundColor)
            .padding(.horizontal, tokens.horizontalPadding)
            .padding(.vertical, tokens.verticalPadding)
            .background(backgroundColor)
            .overlay {
                if style == .outline {
                    Capsule()
                        .strokeBorder(theme.colors.separator, lineWidth: 1)
                }
            }
            .clipShape(Capsule())
            .accessibilityLabel("Tag \(text)")
    }

    private var foregroundColor: Color {
        switch style {
        case .neutral:
            theme.colors.labelPrimary
        case .accent:
            Color.white
        case .outline:
            theme.colors.accent
        }
    }

    private var backgroundColor: Color {
        switch style {
        case .neutral:
            theme.colors.fillPrimary
        case .accent:
            theme.colors.accent
        case .outline:
            .clear
        }
    }
}

#if DEBUG
#Preview("HIGTag") {
    HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        HStack(spacing: 12) {
            HIGTag("Design")
            HIGTag("SwiftUI", style: .accent)
            HIGTag("Beta", style: .outline)
        }
        .padding()
    }
}
#endif