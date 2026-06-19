import HIGDesign
import SwiftUI

private struct ShowcaseListRow: Identifiable {
    let id = UUID()
    let title: String
    let detail: String
}

struct ShowcaseListView: View {
    private let rows = [
        ShowcaseListRow(title: "Inbox", detail: "12 unread"),
        ShowcaseListRow(title: "Drafts", detail: "3 items"),
        ShowcaseListRow(title: "Archive", detail: "128 items"),
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            ShowcaseMetadataView(component: .list)
                .higPadding(.screenEdge)

            HIGList(rows) { row in
                VStack(alignment: .leading, spacing: 4) {
                    Text(row.title)
                        .font(.headline)
                    Text(row.detail)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .navigationTitle("List")
    }
}

#if DEBUG
#Preview("ShowcaseListView") {
    ShowcaseListView()
}
#endif