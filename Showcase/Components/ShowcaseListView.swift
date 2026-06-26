import HIGDesign
import SwiftUI

private struct ShowcaseListRow: Identifiable {
    let id = UUID()
    let title: String
    let detail: String
}

struct ShowcaseListView: View {
    @Environment(\.higTheme) private var theme
    private let rows = [
        ShowcaseListRow(title: "Inbox", detail: "12 unread"),
        ShowcaseListRow(title: "Drafts", detail: "3 items"),
        ShowcaseListRow(title: "Archive", detail: "128 items"),
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: theme.spacing.screenEdge) {
            ShowcaseMetadataView(component: .list)
                .higPadding(.screenEdge)

            ShowcaseSampleView(code: """
            HIGList(rows) { row in
                VStack(alignment: .leading, spacing: HIGSpacing.xxs.rawValue) {
                    Text(row.title)
                    Text(row.detail)
                }
            }
            """) {
                HIGList(rows) { row in
                    VStack(alignment: .leading, spacing: HIGSpacing.xxs.rawValue) {
                        Text(row.title)
                            .font(theme.typography.headline)
                        Text(row.detail)
                            .font(theme.typography.caption)
                            .foregroundStyle(theme.colors.labelSecondary)
                    }
                }
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle("List")
    }
}

#if DEBUG
#Preview("ShowcaseListView") {
    ShowcasePreviewContainer {
        ShowcaseListView()
    }
}
#endif