import HIGThemesContract
import SwiftUI

/// A modal-style alert surface for confirmations and destructive actions.
///
/// Use ``higAlert(_:isPresented:message:primaryButtonTitle:primaryButtonRole:primaryAction:secondaryButtonTitle:secondaryButtonRole:secondaryAction:)``
/// to present native alerts. ``HIGAlert`` renders the same hierarchy inline for previews and showcase snapshots.
public struct HIGAlert: View {
    private let title: String
    private let message: String?
    private let primaryButtonTitle: String
    private let primaryButtonRole: HIGAlertButtonRole
    private let primaryAction: () -> Void
    private let secondaryButtonTitle: String?
    private let secondaryButtonRole: HIGAlertButtonRole
    private let secondaryAction: () -> Void

    @Environment(\.higTheme) private var theme

    public init(
        _ title: String,
        message: String? = nil,
        primaryButtonTitle: String,
        primaryButtonRole: HIGAlertButtonRole = .default,
        primaryAction: @escaping () -> Void = {},
        secondaryButtonTitle: String? = nil,
        secondaryButtonRole: HIGAlertButtonRole = .cancel,
        secondaryAction: @escaping () -> Void = {}
    ) {
        self.title = title
        self.message = message
        self.primaryButtonTitle = primaryButtonTitle
        self.primaryButtonRole = primaryButtonRole
        self.primaryAction = primaryAction
        self.secondaryButtonTitle = secondaryButtonTitle
        self.secondaryButtonRole = secondaryButtonRole
        self.secondaryAction = secondaryAction
    }

    public var body: some View {
        let tokens = theme.alert

        VStack(alignment: .leading, spacing: theme.spacing.item) {
            Text(title)
                .font(tokens.titleFont)
                .foregroundStyle(theme.colors.labelPrimary)
                .frame(maxWidth: .infinity, alignment: .leading)

            if let message {
                Text(message)
                    .font(tokens.messageFont)
                    .foregroundStyle(theme.colors.labelSecondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }

            HStack(spacing: theme.spacing.item) {
                if let secondaryButtonTitle {
                    alertButton(
                        title: secondaryButtonTitle,
                        role: secondaryButtonRole,
                        action: secondaryAction
                    )
                }

                alertButton(
                    title: primaryButtonTitle,
                    role: primaryButtonRole,
                    action: primaryAction
                )
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .padding(tokens.contentPadding)
        .frame(maxWidth: tokens.modalMaxWidth)
        .background(theme.colors.backgroundSecondary)
        .clipShape(RoundedRectangle(cornerRadius: tokens.cornerRadius, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: tokens.cornerRadius, style: .continuous)
                .strokeBorder(theme.colors.separator, lineWidth: theme.border.hairline)
        }
        .accessibilityElement(children: .contain)
        .accessibilityLabel(title)
    }

    @ViewBuilder
    private func alertButton(
        title: String,
        role: HIGAlertButtonRole,
        action: @escaping () -> Void
    ) -> some View {
        switch role {
        case .destructive:
            HIGButton(title, role: .destructive, action: action)
        case .cancel:
            HIGButton(title, role: .secondary, action: action)
        case .default:
            HIGButton(title, role: .primary, action: action)
        }
    }
}

#if DEBUG
#Preview("HIGAlert") {
    HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        HIGAlert(
            "Delete Item?",
            message: "This action cannot be undone.",
            primaryButtonTitle: "Delete",
            primaryButtonRole: .destructive,
            secondaryButtonTitle: "Cancel",
            secondaryButtonRole: .cancel
        )
        .padding()
    }
}
#endif