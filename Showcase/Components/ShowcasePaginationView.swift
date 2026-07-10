import HIGDesign
import SwiftUI

struct ShowcasePaginationView: View {
    @Environment(\.higTheme) private var theme
    @State private var page = 3
    @State private var compactPage = 1

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                ShowcaseMetadataView(component: .pagination)

                VStack(spacing: theme.spacing.screenEdge) {
                    ShowcaseSampleView(code: """
                    HIGPagination(page: $page, pageCount: 12)
                    """) {
                        VStack(alignment: .leading, spacing: theme.spacing.item) {
                            HIGPagination(page: $page, pageCount: 12)
                            Text("Page \(page) of 12")
                                .font(theme.typography.caption)
                                .foregroundStyle(theme.colors.labelSecondary)
                        }
                    }

                    ShowcaseSampleView(code: """
                    HIGPagination(page: $page, pageCount: 4, maxVisiblePages: 5)
                    """) {
                        HIGPagination(page: $compactPage, pageCount: 4, maxVisiblePages: 5)
                    }
                }
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle("Pagination")
    }
}

#if DEBUG
#Preview("ShowcasePaginationView") {
    ShowcasePreviewContainer {
        ShowcasePaginationView()
    }
}
#endif
