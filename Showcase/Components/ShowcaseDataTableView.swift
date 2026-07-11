import HIGDesign
import SwiftUI

private struct ShowcaseDataTablePerson: Identifiable {
    let id: Int
    let name: String
    let role: String
    let team: String
    let status: String
}

struct ShowcaseDataTableView: View {
    @Environment(\.higTheme) private var theme

    private let people: [ShowcaseDataTablePerson] = [
        .init(id: 1, name: "Alex Rivera", role: "Admin", team: "Platform", status: "Active"),
        .init(id: 2, name: "Jordan Lee", role: "Editor", team: "Design", status: "Away"),
        .init(id: 3, name: "Sam Chen", role: "Viewer", team: "Support", status: "Offline"),
        .init(id: 4, name: "Riley Kim", role: "Editor", team: "Product", status: "Active"),
    ]

    private var columns: [HIGDataTableColumn<ShowcaseDataTablePerson>] {
        [
            HIGDataTableColumn("Name", minWidth: 120, value: \.name),
            HIGDataTableColumn("Role", value: \.role),
            HIGDataTableColumn("Team", value: \.team),
            HIGDataTableColumn("Status", alignment: .trailing, value: \.status),
        ]
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                ShowcaseMetadataView(component: .dataTable)

                VStack(spacing: theme.spacing.screenEdge) {
                    ShowcaseSampleView(code: """
                    HIGDataTable(
                        rows: people,
                        columns: [
                            HIGDataTableColumn("Name", value: \\.name),
                            HIGDataTableColumn("Role", value: \\.role),
                            HIGDataTableColumn("Status", alignment: .trailing, value: \\.status),
                        ]
                    )
                    """) {
                        HIGDataTable(rows: people, columns: columns)
                    }

                    ShowcaseSampleView(code: """
                    HIGDataTable(
                        rows: [],
                        columns: columns,
                        emptyMessage: "No people yet"
                    )
                    """) {
                        HIGDataTable(
                            rows: [ShowcaseDataTablePerson](),
                            columns: columns,
                            emptyMessage: "No people yet"
                        )
                    }
                }
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle("Data Table")
    }
}

#if DEBUG
#Preview("ShowcaseDataTableView") {
    ShowcasePreviewContainer {
        ShowcaseDataTableView()
    }
}
#endif
