import HIGDesign
import SwiftUI

struct ShowcaseAppMailboxView: View {
    @Environment(\.higTheme) private var theme
    @State private var query = ""

    var body: some View {
        ShowcaseRecipeLayoutView(
            component: .appMailbox,
            code: """
            HIGPageHeader("Inbox")
            HIGSearchField("Search", text: $query)
            HIGMediaRow("Project update", …) { HIGAvatar("AK") }
            """
        ) {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                HIGPageHeader(
                    "Inbox",
                    subtitle: "Compose public HIG surfaces — no mailbox networking in the package."
                )
                HIGSearchField("Search", text: $query, placeholder: "Search mail")
                VStack(spacing: theme.spacing.item) {
                    mailRow(
                        title: "Project update",
                        subtitle: "Alex · Q3 milestones look good — can we ship Friday?",
                        initials: "AK",
                        badge: "2"
                    )
                    mailRow(
                        title: "Invoice #1842",
                        subtitle: "Finance · Payment received for March services.",
                        initials: "FN",
                        badge: nil
                    )
                    mailRow(
                        title: "Design review",
                        subtitle: "Sam · Attached latest mockups for the admin shell.",
                        initials: "SR",
                        badge: "1"
                    )
                }
            }
        }
    }

    private func mailRow(
        title: String,
        subtitle: String,
        initials: String,
        badge: String?
    ) -> some View {
        HIGMediaRow(title, subtitle: subtitle, showsBorder: true) {
            HIGAvatar(initials)
        } trailing: {
            if let badge {
                HIGBadge(badge)
            }
        }
    }
}

#if DEBUG
#Preview("ShowcaseAppMailboxView") {
    ShowcasePreviewContainer {
        ShowcaseAppMailboxView()
    }
}
#endif
