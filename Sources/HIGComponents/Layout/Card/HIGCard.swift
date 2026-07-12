import HIGThemesContract
import SwiftUI

/// A grouped content surface with theme-backed background, padding, and radius.
public struct HIGCard<Content: View>: View {
    private let title: String?
    private let subtitle: String?
    private let content: () -> Content

    @Environment(\.higTheme) private var theme

    public init(
        _ title: String? = nil,
        subtitle: String? = nil,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.title = title
        self.subtitle = subtitle
        self.content = content
    }

    public var body: some View {
        let tokens = theme.card

        VStack(alignment: .leading, spacing: theme.spacing.item) {
            if title != nil || subtitle != nil {
                VStack(alignment: .leading, spacing: theme.spacing.compactItem) {
                    if let title {
                        Text(title)
                            .font(theme.typography.headline)
                            .foregroundStyle(theme.colors.labelPrimary)
                    }
                    if let subtitle {
                        Text(subtitle)
                            .font(theme.typography.caption)
                            .foregroundStyle(theme.colors.labelSecondary)
                    }
                }
            }

            content()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(tokens.contentPadding)
        .background(theme.colors.backgroundSecondary)
        .clipShape(RoundedRectangle(cornerRadius: tokens.cornerRadius, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: tokens.cornerRadius, style: .continuous)
                .strokeBorder(theme.colors.separator, lineWidth: tokens.borderWidth)
        }
        .accessibilityElement(children: .contain)
        .accessibilityLabel(accessibilityLabelText)
    }

    private var accessibilityLabelText: String {
        switch (title, subtitle) {
        case let (title?, subtitle?):
            "\(title). \(subtitle)"
        case let (title?, nil):
            title
        case let (nil, subtitle?):
            subtitle
        case (nil, nil):
            "Card"
        }
    }
}

#if DEBUG
#Preview("HIGCard") {
    HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        HIGCard("Account", subtitle: "Security and sign-in") {
            Text("Manage profile, security, and sign-in methods.")
                .font(.body)
                .foregroundStyle(.secondary)
        }
        .padding()
    }
}
#endif
