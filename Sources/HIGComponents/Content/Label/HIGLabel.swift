import HIGThemesContract
import HIGTokensRaw
import SwiftUI

/// A title and optional subtitle using HIG typography roles.
public struct HIGLabel: View {
    private let title: String
    private let subtitle: String?
    private let style: HIGLabelStyle

    @Environment(\.higTheme) private var theme

    public init(
        _ title: String,
        subtitle: String? = nil,
        style: HIGLabelStyle = .primary
    ) {
        self.title = title
        self.subtitle = subtitle
        self.style = style
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: theme.spacing.compactItem) {
            Text(title)
                .font(titleFont)
                .foregroundStyle(titleColor)

            if let subtitle {
                Text(subtitle)
                    .font(theme.typography.callout)
                    .foregroundStyle(theme.colors.labelSecondary)
            }
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel(accessibilityText)
    }

    private var titleFont: Font {
        switch style {
        case .primary:
            theme.typography.headline
        case .secondary:
            theme.typography.body
        case .caption:
            theme.typography.caption
        }
    }

    private var titleColor: Color {
        switch style {
        case .primary, .secondary:
            theme.colors.labelPrimary
        case .caption:
            theme.colors.labelSecondary
        }
    }

    private var accessibilityText: String {
        if let subtitle {
            "\(title), \(subtitle)"
        } else {
            title
        }
    }
}

#if DEBUG
#Preview("HIGLabel") {
    HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        VStack(alignment: .leading, spacing: HIGSpacing.lg.rawValue) {
            HIGLabel("Notifications", subtitle: "Choose alert styles", style: .primary)
            HIGLabel("Last synced", subtitle: "2 minutes ago", style: .secondary)
            HIGLabel("Optional", style: .caption)
        }
        .padding()
    }
}
#endif