import HIGDesign
import SwiftUI

struct ShowcaseAppContactsView: View {
    @Environment(\.higTheme) private var theme
    @State private var selected = "alex"

    var body: some View {
        ShowcaseRecipeLayoutView(
            component: .appContacts,
            code: """
            HIGPageHeader("Contacts")
            HIGListGroup { HIGListGroupRow(…) }
            HIGPanel("Profile") { HIGAvatar(…, status: .online) }
            """
        ) {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                HIGPageHeader(
                    "Contacts",
                    subtitle: "Directory list with avatar status and detail panel."
                )
                HIGListGroup(header: "Team") {
                    HIGListGroupRow(
                        "Alex Kim",
                        subtitle: "Product",
                        systemImage: "person.crop.circle",
                        isSelected: selected == "alex"
                    ) { selected = "alex" }
                    HIGDivider()
                    HIGListGroupRow(
                        "Sam Rivera",
                        subtitle: "Design",
                        systemImage: "person.crop.circle",
                        isSelected: selected == "sam"
                    ) { selected = "sam" }
                    HIGDivider()
                    HIGListGroupRow(
                        "Jordan Lee",
                        subtitle: "Engineering",
                        systemImage: "person.crop.circle",
                        isSelected: selected == "jordan"
                    ) { selected = "jordan" }
                }
                HIGPanel("Profile", description: selectedName) {
                    HStack(spacing: theme.spacing.item) {
                        HIGAvatar(selectedInitials, status: selectedStatus)
                        VStack(alignment: .leading, spacing: theme.spacing.compactItem) {
                            Text(selectedName)
                                .font(theme.typography.headline)
                                .foregroundStyle(theme.colors.labelPrimary)
                            Text(selectedRole)
                                .font(theme.typography.caption)
                                .foregroundStyle(theme.colors.labelSecondary)
                        }
                        Spacer(minLength: theme.spacing.item)
                        HIGButton("Message", role: .secondary) {}
                    }
                }
            }
        }
    }

    private var selectedName: String {
        switch selected {
        case "sam": "Sam Rivera"
        case "jordan": "Jordan Lee"
        default: "Alex Kim"
        }
    }

    private var selectedRole: String {
        switch selected {
        case "sam": "Design"
        case "jordan": "Engineering"
        default: "Product"
        }
    }

    private var selectedInitials: String {
        switch selected {
        case "sam": "SR"
        case "jordan": "JL"
        default: "AK"
        }
    }

    private var selectedStatus: HIGStatusKind {
        switch selected {
        case "sam": .away
        case "jordan": .busy
        default: .online
        }
    }
}

#if DEBUG
#Preview("ShowcaseAppContactsView") {
    ShowcasePreviewContainer {
        ShowcaseAppContactsView()
    }
}
#endif
