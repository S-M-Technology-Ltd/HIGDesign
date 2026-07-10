import HIGThemesContract
import HIGTokensComponent
import SwiftUI

/// A themed modal surface for sheet and dialog content chrome.
///
/// Present with native `.sheet` / `.fullScreenCover`. ``HIGModal`` provides the
/// HIG-styled interior (title, message, close, body, footer).
public struct HIGModal<Content: View, Footer: View>: View {
    private let title: String?
    private let message: String?
    private let onDismiss: (() -> Void)?
    private let content: () -> Content
    private let footer: () -> Footer

    @Environment(\.higTheme) private var theme

    public init(
        title: String? = nil,
        message: String? = nil,
        onDismiss: (() -> Void)? = nil,
        @ViewBuilder content: @escaping () -> Content,
        @ViewBuilder footer: @escaping () -> Footer
    ) {
        self.title = title
        self.message = message
        self.onDismiss = onDismiss
        self.content = content
        self.footer = footer
    }

    public var body: some View {
        let tokens = theme.modal

        VStack(alignment: .leading, spacing: tokens.headerSpacing) {
            if hasHeader {
                header(tokens: tokens)
            }

            content()
                .frame(maxWidth: .infinity, alignment: .leading)

            footer()
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .padding(tokens.contentPadding)
        .frame(maxWidth: tokens.maxWidth, alignment: .leading)
        .background(theme.colors.backgroundSecondary)
        .clipShape(RoundedRectangle(cornerRadius: tokens.cornerRadius, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: tokens.cornerRadius, style: .continuous)
                .strokeBorder(theme.colors.separator, lineWidth: tokens.borderWidth)
        }
        .accessibilityElement(children: .contain)
        .accessibilityLabel(title ?? "Modal")
    }

    private var hasHeader: Bool {
        title != nil || message != nil || onDismiss != nil
    }

    private func header(tokens: any HIGModalTokens) -> some View {
        HStack(alignment: .top, spacing: theme.spacing.item) {
            VStack(alignment: .leading, spacing: tokens.headerSpacing) {
                if let title {
                    Text(title)
                        .font(tokens.titleFont)
                        .foregroundStyle(theme.colors.labelPrimary)
                        .accessibilityAddTraits(.isHeader)
                }
                if let message {
                    Text(message)
                        .font(tokens.messageFont)
                        .foregroundStyle(theme.colors.labelSecondary)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            if let onDismiss {
                HIGCloseButton(action: onDismiss)
            }
        }
    }
}

extension HIGModal where Footer == EmptyView {
    /// Creates a modal without a footer.
    public init(
        title: String? = nil,
        message: String? = nil,
        onDismiss: (() -> Void)? = nil,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.init(
            title: title,
            message: message,
            onDismiss: onDismiss,
            content: content,
            footer: { EmptyView() }
        )
    }
}

#if DEBUG
#Preview("HIGModal") {
    HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        HIGModal(
            title: "Edit project",
            message: "Update the display name and owners.",
            onDismiss: {}
        ) {
            Text("Form fields go here.")
                .font(.body)
                .foregroundStyle(.secondary)
        } footer: {
            HIGButton("Save", role: .primary) {}
        }
        .padding()
    }
}
#endif
