import HIGDesign
import SwiftUI

struct ShowcaseBreadcrumbView: View {
    @Environment(\.higTheme) private var theme
    @State private var selectedPath = "UI Kit / Buttons"

    private let items = [
        HIGBreadcrumbItem(id: "home", title: "Home"),
        HIGBreadcrumbItem(id: "uikit", title: "UI Kit"),
        HIGBreadcrumbItem(id: "buttons", title: "Buttons"),
    ]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                ShowcaseMetadataView(component: .breadcrumb)

                VStack(spacing: theme.spacing.screenEdge) {
                    ShowcaseSampleView(code: """
                    HIGBreadcrumb(
                        items: [
                            HIGBreadcrumbItem("Home"),
                            HIGBreadcrumbItem("UI Kit"),
                            HIGBreadcrumbItem("Buttons"),
                        ],
                        onSelect: { item in /* navigate */ }
                    )
                    """) {
                        VStack(alignment: .leading, spacing: theme.spacing.item) {
                            HIGBreadcrumb(items: items, onSelect: { item in
                                selectedPath = item.title
                            })
                            Text("Last selection: \(selectedPath)")
                                .font(theme.typography.caption)
                                .foregroundStyle(theme.colors.labelSecondary)
                        }
                    }

                    ShowcaseSampleView(code: """
                    HIGBreadcrumb(items: items) // display-only trail
                    """) {
                        HIGBreadcrumb(items: items)
                    }
                }
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle("Breadcrumb")
    }
}

#if DEBUG
#Preview("ShowcaseBreadcrumbView") {
    ShowcasePreviewContainer {
        ShowcaseBreadcrumbView()
    }
}
#endif
