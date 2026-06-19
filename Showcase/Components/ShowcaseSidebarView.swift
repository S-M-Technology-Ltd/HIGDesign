import HIGDesign
import SwiftUI

private enum ShowcaseSidebarSection: String, Hashable, Sendable {
    case inbox
    case drafts
    case archive
}

struct ShowcaseSidebarView: View {
    @State private var selection: ShowcaseSidebarSection? = .inbox

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ShowcaseMetadataView(component: .sidebar)
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
                VStack(alignment: .leading, spacing: 8) {
                    Text(sectionTitle(section))
                        .font(.title2)
                    Text("Example messages for the \(sectionTitle(section)) section.")
                        .foregroundStyle(.secondary)
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
    ShowcaseSidebarView()
}
#endif