import HIGThemesContract
import HIGTokensComponent
import SwiftUI

/// Centered empty-content messaging with optional icon and actions.
///
/// Use for blank admin lists, search-no-results, and error recovery panels.
public struct HIGEmptyState<Actions: View>: View {
    private let title: String
    private let message: String?
    private let systemImage: String?
    private let actions: () -> Actions

    @Environment(\.higTheme) private var theme

    public init(
        _ title: String,
        message: String? = nil,
        systemImage: String? = "tray",
        @ViewBuilder actions: @escaping () -> Actions
    ) {
        self.title = title
        self.message = message
        self.systemImage = systemImage
        self.actions = actions
    }

    public var body: some View {
        let tokens = theme.emptyState

        VStack(spacing: tokens.stackSpacing) {
            if let systemImage {
                Image(systemName: systemImage)
                    .font(.system(size: tokens.iconPointSize, weight: .regular))
                    .foregroundStyle(theme.colors.labelSecondary)
                    .accessibilityHidden(true)
            }

            Text(title)
                .font(tokens.titleFont)
                .foregroundStyle(theme.colors.labelPrimary)
                .multilineTextAlignment(.center)
                .accessibilityAddTraits(.isHeader)

            if let message {
                Text(message)
                    .font(tokens.messageFont)
                    .foregroundStyle(theme.colors.labelSecondary)
                    .multilineTextAlignment(.center)
            }

            VStack(spacing: tokens.actionSpacing) {
                actions()
            }
        }
        .frame(maxWidth: tokens.maxContentWidth)
        .frame(maxWidth: .infinity)
        .padding(theme.spacing.section)
        .accessibilityElement(children: .contain)
        .accessibilityLabel(accessibilityLabelText)
    }

    private var accessibilityLabelText: String {
        if let message {
            "\(title). \(message)"
        } else {
            title
        }
    }
}

extension HIGEmptyState where Actions == EmptyView {
    /// Creates an empty state without action controls.
    public init(
        _ title: String,
        message: String? = nil,
        systemImage: String? = "tray"
    ) {
        self.init(title, message: message, systemImage: systemImage, actions: { EmptyView() })
    }
}

#if DEBUG
#Preview("HIGEmptyState") {
    HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        HIGEmptyState(
            "No messages",
            message: "When you receive mail, it will show up here.",
            systemImage: "envelope"
        ) {
            HIGButton("Compose", role: .primary) {}
        }
        .padding()
    }
}

#Preview("HIGEmptyState — Title Only") {
    HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        HIGEmptyState("Nothing here yet")
            .padding()
    }
}
#endif
