import HIGThemesContract
import SwiftUI

/// A grouped content surface with theme-backed background, padding, and radius.
public struct HIGCard<Content: View>: View {
    private let title: String?
    private let content: () -> Content

    @Environment(\.higTheme) private var theme

    public init(
        _ title: String? = nil,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.title = title
        self.content = content
    }

    public var body: some View {
        let tokens = theme.card

        VStack(alignment: .leading, spacing: theme.spacing.item) {
            if let title {
                Text(title)
                    .font(theme.typography.headline)
                    .foregroundStyle(theme.colors.labelPrimary)
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
        .accessibilityLabel(title ?? "Card")
    }
}

#if DEBUG
#Preview("HIGCard") {
    HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        HIGCard("Account") {
            Text("Manage profile, security, and sign-in methods.")
                .font(.body)
                .foregroundStyle(.secondary)
        }
        .padding()
    }
}
#endif