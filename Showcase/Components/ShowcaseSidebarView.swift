import HIGDesign
import SwiftUI

private enum ShowcaseSidebarSection: String, Hashable, Sendable {
    case inbox
    case drafts
    case archive
}

struct ShowcaseSidebarView: View {
    @Environment(\.higTheme) private var theme
    @State private var selection: ShowcaseSidebarSection? = .inbox

    var body: some View {
        VStack(alignment: .leading, spacing: HIGSpacing.none.rawValue) {
            ShowcaseMetadataView(component: .sidebar)
                .higPadding(.screenEdge)

            ShowcaseCodeSnippetView(code: """
            HIGSidebar(
                selection: $selection,
                title: "Mail",
                items: [
                    HIGSidebarItem(id: .inbox, title: "Inbox", systemImage: "tray"),
                    HIGSidebarItem(id: .drafts, title: "Drafts", systemImage: "doc"),
                    HIGSidebarItem(id: .archive, title: "Archive", systemImage: "archivebox"),
                ]
            ) { section in
                // detail content
            }
            """)
            .higPadding(.screenEdge)

            HIGSidebar(
                selection: $selection,
                title: "Mail",
                items: [
                    HIGSidebarItem(id: ShowcaseSidebarSection.inbox, title: "Inbox", systemImage: "tray"),
                    HIGSidebarItem(id: ShowcaseSidebarSection.drafts, title: "Drafts", systemImage: "doc"),
                    HIGSidebarItem(id: ShowcaseSidebarSection.archive, title: "Archive", systemImage: "archivebox"),
                ]
            ) { section in
                VStack(alignment: .leading, spacing: theme.spacing.compactItem) {
                    Text(sectionTitle(section))
                        .font(theme.typography.title)
                    Text("Example messages for the \(sectionTitle(section)) section.")
                        .foregroundStyle(theme.colors.labelSecondary)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .higPadding(.screenEdge)
            }
        }
        .navigationTitle("Sidebar")
    }

    private func sectionTitle(_ section: ShowcaseSidebarSection) -> String {
        switch section {
        case .inbox:
            "Inbox"
        case .drafts:
            "Drafts"
        case .archive:
            "Archive"
        }
    }
}

#if DEBUG
#Preview("ShowcaseSidebarView") {
    ShowcasePreviewContainer {
        ShowcaseSidebarView()
    }
}
#endif