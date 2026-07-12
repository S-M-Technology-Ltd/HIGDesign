import HIGDesign
import SwiftUI
import UniformTypeIdentifiers

private struct ShowcaseDocumentRow: Identifiable {
    let id: Int
    let name: String
    let owner: String
    let status: String
}

struct ShowcaseAppDocumentsView: View {
    @Environment(\.higTheme) private var theme
    @State private var files: [URL] = []

    private let rows: [ShowcaseDocumentRow] = [
        .init(id: 1, name: "Q3 Plan.pdf", owner: "Alex", status: "Shared"),
        .init(id: 2, name: "Brand kit.zip", owner: "Sam", status: "Private"),
        .init(id: 3, name: "API notes.md", owner: "Jordan", status: "Shared"),
    ]

    private var columns: [HIGDataTableColumn<ShowcaseDocumentRow>] {
        [
            HIGDataTableColumn("Name", minWidth: 140, value: \.name),
            HIGDataTableColumn("Owner", value: \.owner),
            HIGDataTableColumn("Status", alignment: .trailing, value: \.status),
        ]
    }

    var body: some View {
        ShowcaseRecipeLayoutView(
            component: .appDocuments,
            code: """
            HIGPageHeader("Documents")
            HIGDropZone(urls: $files, allowedContentTypes: [.pdf])
            HIGDataTable(rows: files, columns: …)
            """
        ) {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                HIGPageHeader(
                    "Documents",
                    subtitle: "File table plus drop zone — security-scoped access stays in the host app."
                )
                HIGDropZone(
                    urls: $files,
                    allowedContentTypes: [.pdf, .plainText, .image]
                )
                HIGDataTable(rows: rows, columns: columns)
            }
        }
    }
}

#if DEBUG
#Preview("ShowcaseAppDocumentsView") {
    ShowcasePreviewContainer {
        ShowcaseAppDocumentsView()
    }
}
#endif
