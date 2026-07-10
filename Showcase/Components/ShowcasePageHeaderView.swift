import HIGDesign
import SwiftUI

struct ShowcasePageHeaderView: View {
    @Environment(\.higTheme) private var theme
    @State private var crumbNote = "Ready"

    private let crumbs = [
        HIGBreadcrumbItem(id: "home", title: "Home"),
        HIGBreadcrumbItem(id: "apps", title: "Apps"),
        HIGBreadcrumbItem(id: "mailbox", title: "Mailbox"),
    ]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                ShowcaseMetadataView(component: .pageHeader)

                VStack(spacing: theme.spacing.screenEdge) {
                    ShowcaseSampleView(code: """
                    HIGPageHeader(
                        "Mailbox",
                        subtitle: "Inbox and archive",
                        breadcrumbItems: crumbs,
                        onBreadcrumbSelect: { _ in }
                    ) {
                        HIGButton("Compose", role: .primary) {}
                    }
                    """) {
                        HIGPageHeader(
                            "Mailbox",
                            subtitle: "Inbox and archive · \(crumbNote)",
                            breadcrumbItems: crumbs,
                            onBreadcrumbSelect: { item in
                                crumbNote = "Navigated to \(item.title)"
                            }
                        ) {
                            HIGButton("Compose", role: .primary) {}
                        }
                    }

                    ShowcaseSampleView(code: """
                    HIGPageHeader("Dashboard")
                    """) {
                        HIGPageHeader("Dashboard")
                    }
                }
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle("Page Header")
    }
}

#if DEBUG
#Preview("ShowcasePageHeaderView") {
    ShowcasePreviewContainer {
        ShowcasePageHeaderView()
    }
}
#endif
