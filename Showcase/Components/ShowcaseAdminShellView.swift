import HIGDesign
import SwiftUI

private enum ShowcaseAdminShellSection: String, Hashable, Sendable {
    case dashboard
    case users
    case reports
    case settings
}

struct ShowcaseAdminShellView: View {
    @Environment(\.higTheme) private var theme
    @State private var selection: ShowcaseAdminShellSection? = .dashboard

    private var items: [HIGSidebarItem<ShowcaseAdminShellSection>] {
        [
            HIGSidebarItem(id: .dashboard, title: "Dashboard", systemImage: "square.grid.2x2"),
            HIGSidebarItem(id: .users, title: "Users", systemImage: "person.2"),
            HIGSidebarItem(id: .reports, title: "Reports", systemImage: "chart.bar"),
            HIGSidebarItem(id: .settings, title: "Settings", systemImage: "gearshape"),
        ]
    }

    var body: some View {
        VStack(alignment: .leading, spacing: HIGSpacing.none.rawValue) {
            ShowcaseMetadataView(component: .adminShell)
                .higPadding(.screenEdge)

            ShowcaseCodeSnippetView(code: """
            HIGAdminShell(
                brandTitle: "HIG Admin",
                sidebarTitle: "Menu",
                selection: $selection,
                items: items
            ) { section in
                // detail content
            }
            """)
            .higPadding(.screenEdge)

            HIGAdminShell(
                brandTitle: "HIG Admin",
                sidebarTitle: "Menu",
                selection: $selection,
                items: items
            ) { section in
                VStack(alignment: .leading, spacing: theme.spacing.item) {
                    HIGPageHeader(
                        title(for: section),
                        subtitle: "Admin shell detail for \(title(for: section).lowercased())."
                    )
                    Text("Compose panels, tables, and forms in the detail column.")
                        .font(theme.typography.body)
                        .foregroundStyle(theme.colors.labelSecondary)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            }
            .frame(minHeight: 360)
        }
        .navigationTitle("Admin Shell")
    }

    private func title(for section: ShowcaseAdminShellSection) -> String {
        switch section {
        case .dashboard: "Dashboard"
        case .users: "Users"
        case .reports: "Reports"
        case .settings: "Settings"
        }
    }
}

#if DEBUG
#Preview("ShowcaseAdminShellView") {
    ShowcasePreviewContainer {
        ShowcaseAdminShellView()
    }
}
#endif
