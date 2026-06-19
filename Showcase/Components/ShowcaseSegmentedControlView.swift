import HIGDesign
import SwiftUI

private enum ShowcaseInboxFilter: String, Hashable, Sendable {
    case all
    case unread
    case flagged
}

struct ShowcaseSegmentedControlView: View {
    @State private var filter = ShowcaseInboxFilter.all

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                ShowcaseMetadataView(component: .segmentedControl)

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
            .higPadding(.screenEdge)
        }
        .navigationTitle("Segmented Control")
    }
}

#if DEBUG
#Preview("ShowcaseSegmentedControlView") {
    ShowcaseSegmentedControlView()
}
#endif