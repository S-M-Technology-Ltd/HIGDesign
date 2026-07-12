import HIGDesign
import SwiftUI

private struct ShowcasePageUserRow: Identifiable {
    let id: Int
    let name: String
    let role: String
    let status: String
}

struct ShowcasePageUserView: View {
    @Environment(\.higTheme) private var theme

    private let rows: [ShowcasePageUserRow] = [
        .init(id: 1, name: "Alex Kim", role: "Admin", status: "Active"),
        .init(id: 2, name: "Sam Rivera", role: "Editor", status: "Active"),
        .init(id: 3, name: "Jordan Lee", role: "Viewer", status: "Invited"),
    ]

    private var columns: [HIGDataTableColumn<ShowcasePageUserRow>] {
        [
            HIGDataTableColumn("Name", minWidth: 120, value: \.name),
            HIGDataTableColumn("Role", value: \.role),
            HIGDataTableColumn("Status", alignment: .trailing, value: \.status),
        ]
    }

    var body: some View {
        ShowcaseRecipeLayoutView(
            component: .pageUser,
            code: """
            HIGPageHeader("Users")
            HIGDataTable(rows: users, columns: …)
            """
        ) {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                HIGPageHeader(
                    "Users",
                    subtitle: "Admin user directory page composition."
                ) {
                    HIGButton("Invite", role: .primary) {}
                }
                HIGDataTable(rows: rows, columns: columns)
            }
        }
    }
}

#if DEBUG
#Preview("ShowcasePageUserView") {
    ShowcasePreviewContainer { ShowcasePageUserView() }
}
#endif
