import HIGThemesContract
import SwiftUI

/// A grouped form section with optional header and footer copy.
public struct HIGFormSection<Content: View>: View {
    private let title: String?
    private let footer: String?
    private let content: () -> Content

    @Environment(\.higTheme) private var theme

    public init(
        _ title: String? = nil,
        footer: String? = nil,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.title = title
        self.footer = footer
        self.content = content
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: theme.list.sectionSpacing) {
            if let title {
                Text(title)
                    .font(theme.typography.caption)
                    .foregroundStyle(theme.colors.labelSecondary)
                    .textCase(.uppercase)
            }

            VStack(spacing: theme.list.rowSpacing) {
                content()
            }
            .padding(theme.spacing.item)
            .background(theme.colors.backgroundSecondary)
            .clipShape(RoundedRectangle(cornerRadius: theme.card.cornerRadius, style: .continuous))

            if let footer {
                Text(footer)
                    .font(theme.typography.caption)
                    .foregroundStyle(theme.colors.labelSecondary)
            }
        }
        .accessibilityElement(children: .contain)
    }
}

#if DEBUG
#Preview("HIGFormSection") {
    HIGFormSectionPreviewView()
}

#Preview("HIGFormSectionPreviewView") {
    HIGFormSectionPreviewView()
}

private struct HIGFormSectionPreviewView: View {
    @State private var notificationsEnabled = true
    @State private var email = "person@example.com"

    var body: some View {
        HIGThemeableView(theme: HIGComponentPreviewTheme()) {
            HIGFormSection("Account", footer: "Manage sign-in and profile details.") {
                HIGToggle("Notifications", isOn: $notificationsEnabled)
                HIGDivider()
                HIGTextField("Email", text: $email)
            }
            .padding()
        }
    }
}
#endif