import HIGDesign
import SwiftUI

private enum ShowcaseListGroupMailbox: String, Hashable, Sendable {
    case inbox
    case drafts
    case archive
}

struct ShowcaseListGroupView: View {
    @Environment(\.higTheme) private var theme
    @State private var selection: ShowcaseListGroupMailbox = .inbox

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                ShowcaseMetadataView(component: .listGroup)

                VStack(spacing: theme.spacing.screenEdge) {
                    ShowcaseSampleView(code: """
                    HIGListGroup(header: "Mailboxes", footer: "Choose a destination.") {
                        HIGListGroupRow("Inbox", systemImage: "tray", isSelected: true) {}
                        HIGDivider()
                        HIGListGroupRow("Drafts", systemImage: "doc", showsChevron: true) {}
                    }
                    """) {
                        HIGListGroup(
                            header: "Mailboxes",
                            footer: "Choose a destination."
                        ) {
                            HIGListGroupRow(
                                "Inbox",
                                subtitle: "12 unread",
                                systemImage: "tray",
                                isSelected: selection == .inbox
                            ) {
                                selection = .inbox
                            }
                            HIGDivider()
                            HIGListGroupRow(
                                "Drafts",
                                systemImage: "doc",
                                isSelected: selection == .drafts,
                                showsChevron: true
                            ) {
                                selection = .drafts
                            }
                            HIGDivider()
                            HIGListGroupRow(
                                "Archive",
                                systemImage: "archivebox",
                                isSelected: selection == .archive,
                                showsChevron: true
                            ) {
                                selection = .archive
                            }
                        }
                    }

                    ShowcaseSampleView(code: """
                    HIGListGroup {
                        HIGListGroupRow("Settings")
                        HIGDivider()
                        HIGListGroupRow("Sign out")
                    }
                    """) {
                        HIGListGroup {
                            HIGListGroupRow("Settings", systemImage: "gearshape")
                            HIGDivider()
                            HIGListGroupRow("Help", systemImage: "questionmark.circle")
                            HIGDivider()
                            HIGListGroupRow("Sign out", systemImage: "rectangle.portrait.and.arrow.right")
                        }
                    }
                }
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle("List Group")
    }
}

#if DEBUG
#Preview("ShowcaseListGroupView") {
    ShowcasePreviewContainer {
        ShowcaseListGroupView()
    }
}
#endif
