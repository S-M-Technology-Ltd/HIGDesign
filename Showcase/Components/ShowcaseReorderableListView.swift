import HIGDesign
import SwiftUI

struct ShowcaseReorderableListView: View {
    @Environment(\.higTheme) private var theme
    @State private var items = [
        HIGReorderableListItem(id: "1", title: "Inbox", systemImage: "tray"),
        HIGReorderableListItem(id: "2", title: "Starred", systemImage: "star"),
        HIGReorderableListItem(id: "3", title: "Snoozed", systemImage: "clock"),
        HIGReorderableListItem(id: "4", title: "Archive", systemImage: "archivebox"),
        HIGReorderableListItem(id: "5", title: "Trash", systemImage: "trash")
    ]
    @State private var locked = [
        HIGReorderableListItem(id: "a", title: "Priority", systemImage: "flag"),
        HIGReorderableListItem(id: "b", title: "Labels", systemImage: "tag")
    ]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                ShowcaseMetadataView(component: .reorderableList)

                VStack(spacing: theme.spacing.screenEdge) {
                    ShowcaseSampleView(code: """
                    HIGReorderableList(items: $items)
                    """) {
                        VStack(alignment: .leading, spacing: theme.spacing.item) {
                            HIGReorderableList(items: $items)
                                .frame(height: 260)
                            Text("Order: \(items.map(\.title).joined(separator: " → "))")
                                .font(theme.typography.caption)
                                .foregroundStyle(theme.colors.labelSecondary)
                        }
                    }

                    ShowcaseSampleView(code: """
                    HIGReorderableList(
                        items: $items,
                        caption: "Reordering disabled",
                        isReorderingEnabled: false
                    )
                    """) {
                        HIGReorderableList(
                            items: $locked,
                            caption: "Reordering disabled",
                            isReorderingEnabled: false
                        )
                        .frame(height: 140)
                    }
                }
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle("Reorderable List")
    }
}

#if DEBUG
#Preview("ShowcaseReorderableListView") {
    ShowcasePreviewContainer {
        ShowcaseReorderableListView()
    }
}
#endif
