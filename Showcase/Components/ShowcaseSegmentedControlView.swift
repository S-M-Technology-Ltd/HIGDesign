import HIGDesign
import SwiftUI

private enum ShowcaseInboxFilter: String, Hashable, Sendable {
    case all
    case unread
    case flagged
}

struct ShowcaseSegmentedControlView: View {
    @Environment(\.higTheme) private var theme
    @State private var filter = ShowcaseInboxFilter.all

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                ShowcaseMetadataView(component: .segmentedControl)

                ShowcaseSampleView(code: """
                HIGSegmentedControl(
                    "Inbox Filter",
                    selection: $filter,
                    options: [
                        HIGRadioOption(value: .all, label: "All"),
                        HIGRadioOption(value: .unread, label: "Unread"),
                        HIGRadioOption(value: .flagged, label: "Flagged"),
                    ]
                )
                """) {
                    HIGSegmentedControl(
                        "Inbox Filter",
                        selection: $filter,
                        options: [
                            HIGRadioOption(value: ShowcaseInboxFilter.all, label: "All"),
                            HIGRadioOption(value: ShowcaseInboxFilter.unread, label: "Unread"),
                            HIGRadioOption(value: ShowcaseInboxFilter.flagged, label: "Flagged"),
                        ]
                    )
                }
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle("Segmented Control")
    }
}

#if DEBUG
#Preview("ShowcaseSegmentedControlView") {
    ShowcasePreviewContainer {
        ShowcaseSegmentedControlView()
    }
}
#endif