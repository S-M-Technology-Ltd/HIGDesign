import HIGThemesContract
import HIGTokensRaw
import SwiftUI

/// An inline alert banner for persistent, non-modal feedback.
public struct HIGAlertBanner: View {
    private let title: String
    private let message: String?
    private let style: HIGAlertBannerStyle
    private let actionTitle: String?
    private let action: () -> Void
    private let onDismiss: (() -> Void)?

    @Environment(\.higTheme) private var theme

    public init(
        _ title: String,
        message: String? = nil,
        style: HIGAlertBannerStyle = .info,
        actionTitle: String? = nil,
        action: @escaping () -> Void = {},
        onDismiss: (() -> Void)? = nil
    ) {
        self.title = title
        self.message = message
        self.style = style
        self.actionTitle = actionTitle
        self.action = action
        self.onDismiss = onDismiss
    }

    public var body: some View {
        let tokens = theme.alert
        let dismissSize = HIGSpacing.xl.rawValue

        HStack(alignment: .top, spacing: theme.spacing.item) {
            Image(systemName: style.systemImage)
                .font(tokens.titleFont)
                .foregroundStyle(style.accentColor(theme: theme))
                .accessibilityHidden(true)

            VStack(alignment: .leading, spacing: theme.spacing.compactItem) {
                Text(title)
                    .font(tokens.titleFont)
                    .foregroundStyle(theme.colors.labelPrimary)

                if let message {
                    Text(message)
                        .font(tokens.messageFont)
                        .foregroundStyle(theme.colors.labelSecondary)
                }

                if let actionTitle {
                    Button(actionTitle, action: action)
                        .font(tokens.messageFont.weight(.semibold))
                        .buttonStyle(.plain)
                        .foregroundStyle(style.accentColor(theme: theme))
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            if let onDismiss {
                Button(action: onDismiss) {
                    Image(systemName: "xmark")
                        .font(.caption.weight(.bold))
                        .foregroundStyle(theme.colors.labelSecondary)
                        .frame(width: dismissSize, height: dismissSize)
                        .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
                .accessibilityLabel("Dismiss")
            }
        }
        .padding(tokens.contentPadding)
        .background(style.backgroundColor(theme: theme))
        .clipShape(RoundedRectangle(cornerRadius: tokens.cornerRadius, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: tokens.cornerRadius, style: .continuous)
                .strokeBorder(
                    style.accentColor(theme: theme).opacity(theme.opacity.bannerBorder),
                    lineWidth: theme.border.hairline
                )
        }
        .accessibilityElement(children: .combine)
    }
}

#if DEBUG
#Preview("HIGAlertBanner") {
    HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        VStack(spacing: HIGSpacing.lg.rawValue) {
            HIGAlertBanner("Sync complete", message: "Your changes were saved to iCloud.", style: .success)
            HIGAlertBanner(
                "Storage almost full",
                message: "Remove older items to keep syncing.",
                style: .warning,
                actionTitle: "Manage"
            )
            HIGAlertBanner(
                "Payment failed",
                message: "Update your billing method.",
                style: .error,
                onDismiss: {}
            )
        }
        .padding()
    }
}
#endif
