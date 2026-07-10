import HIGDesign
import SwiftUI

struct ShowcaseTimelineView: View {
    @Environment(\.higTheme) private var theme

    private let items = [
        HIGTimelineItem(
            id: "placed",
            title: "Order placed",
            detail: "Customer submitted checkout for #4821.",
            timestamp: "9:41 AM",
            systemImage: "cart"
        ),
        HIGTimelineItem(
            id: "paid",
            title: "Payment captured",
            detail: "Visa ending 4242 authorized successfully.",
            timestamp: "9:42 AM",
            systemImage: "creditcard"
        ),
        HIGTimelineItem(
            id: "ship",
            title: "Shipped",
            detail: "Carrier: UPS Ground",
            timestamp: "Today",
            systemImage: "shippingbox"
        ),
        HIGTimelineItem(
            id: "done",
            title: "Delivered",
            timestamp: "Tomorrow"
        ),
    ]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                ShowcaseMetadataView(component: .timeline)

                VStack(spacing: theme.spacing.screenEdge) {
                    ShowcaseSampleView(code: """
                    HIGTimeline(items: [
                        HIGTimelineItem(
                            title: "Order placed",
                            detail: "…",
                            timestamp: "9:41 AM",
                            systemImage: "cart"
                        ),
                        …
                    ])
                    """) {
                        HIGTimeline(items: items)
                    }
                }
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle("Timeline")
    }
}

#if DEBUG
#Preview("ShowcaseTimelineView") {
    ShowcasePreviewContainer {
        ShowcaseTimelineView()
    }
}
#endif
