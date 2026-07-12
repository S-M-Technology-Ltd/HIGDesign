import HIGThemesContract
import HIGTokensComponent
import SwiftUI

/// A bordered list-group surface for dense admin navigation and option lists.
///
/// Inspired by Bootstrap/Remark list groups. Place ``HIGListGroupRow`` (or other rows)
/// in `content`. Prefer ``HIGList`` for native scrolling list chrome.
public struct HIGListGroup<Content: View>: View {
    private let header: String?
    private let footer: String?
    private let content: () -> Content

    @Environment(\.higTheme) private var theme
    @Environment(\.isEnabled) private var isEnabled

    /// Creates a list group.
    /// - Parameters:
    ///   - header: Optional caption above the group.
    ///   - footer: Optional helper text below the group.
    ///   - content: Row content, typically ``HIGListGroupRow`` values.
    public init(
        header: String? = nil,
        footer: String? = nil,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.header = header
        self.footer = footer
        self.content = content
    }

    public var body: some View {
        let tokens = theme.listGroup

        VStack(alignment: .leading, spacing: tokens.headerSpacing) {
            if let header {
                Text(header)
                    .font(tokens.headerFont)
                    .foregroundStyle(theme.colors.labelSecondary)
                    .textCase(.uppercase)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .accessibilityAddTraits(.isHeader)
            }

            VStack(spacing: 0) {
                content()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(theme.colors.backgroundSecondary)
            .clipShape(RoundedRectangle(cornerRadius: tokens.cornerRadius, style: .continuous))
            .overlay {
                RoundedRectangle(cornerRadius: tokens.cornerRadius, style: .continuous)
                    .strokeBorder(theme.colors.separator, lineWidth: tokens.borderWidth)
            }
            .opacity(isEnabled ? theme.opacity.full : theme.opacity.disabled)

            if let footer {
                Text(footer)
                    .font(tokens.footerFont)
                    .foregroundStyle(theme.colors.labelSecondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .accessibilityElement(children: .contain)
        .accessibilityLabel(header ?? "List group")
    }
}

#if DEBUG
#Preview("HIGListGroup") {
    @Previewable @State var selection = "inbox"

    HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        HIGListGroup(header: "Mailboxes", footer: "Choose a destination.") {
            HIGListGroupRow(
                "Inbox",
                subtitle: "12 unread",
                systemImage: "tray",
                isSelected: selection == "inbox"
            ) {
                selection = "inbox"
            }
            HIGDivider()
            HIGListGroupRow(
                "Drafts",
                systemImage: "doc",
                isSelected: selection == "drafts",
                showsChevron: true
            ) {
                selection = "drafts"
            }
            HIGDivider()
            HIGListGroupRow(
                "Archive",
                systemImage: "archivebox",
                isSelected: selection == "archive",
                showsChevron: true
            ) {
                selection = "archive"
            }
        }
        .padding()
    }
}
#endif
