import HIGDesign
import SwiftUI

struct ShowcaseTabsView: View {
    @Environment(\.higTheme) private var theme
    @State private var selection = "profile"

    private let items = [
        HIGTabsItem(id: "profile", title: "Profile"),
        HIGTabsItem(id: "activity", title: "Activity"),
        HIGTabsItem(id: "settings", title: "Settings"),
    ]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                ShowcaseMetadataView(component: .tabs)

                VStack(spacing: theme.spacing.screenEdge) {
                    ShowcaseSampleView(code: """
                    HIGTabs(selection: $selection, items: items)
                    // switch content on selection
                    """) {
                        VStack(alignment: .leading, spacing: theme.spacing.item) {
                            HIGTabs(selection: $selection, items: items)
                            Text(contentCopy)
                                .font(theme.typography.body)
                                .foregroundStyle(theme.colors.labelSecondary)
                        }
                    }
                }
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle("Tabs")
    }

    private var contentCopy: String {
        switch selection {
        case "activity":
            "Recent activity and audit events."
        case "settings":
            "Notification and privacy preferences."
        default:
            "Profile overview and public details."
        }
    }
}

#if DEBUG
#Preview("ShowcaseTabsView") {
    ShowcasePreviewContainer {
        ShowcaseTabsView()
    }
}
#endif
