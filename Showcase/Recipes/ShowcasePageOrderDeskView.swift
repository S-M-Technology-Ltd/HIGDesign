import HIGDesign
import SwiftUI

private struct ShowcaseOrderRow: Identifiable {
    let id: String
    let customer: String
    let total: String
    let status: String
}

/// Order desk: filters, table, selected-order detail, and status actions.
struct ShowcasePageOrderDeskView: View {
    @Environment(\.higTheme) private var theme
    @State private var statusFilter = "all"
    @State private var selectedID = "ord-1042"
    @State private var note = "Customer asked for carbon-neutral shipping."

    private let orders: [ShowcaseOrderRow] = [
        .init(id: "ord-1042", customer: "Acme Labs", total: "$428.00", status: "Paid"),
        .init(id: "ord-1041", customer: "Northwind", total: "$96.50", status: "Fulfillment"),
        .init(id: "ord-1039", customer: "Contoso", total: "$1,240.00", status: "Refund"),
        .init(id: "ord-1038", customer: "Fabrikam", total: "$64.00", status: "Paid"),
    ]

    private var columns: [HIGDataTableColumn<ShowcaseOrderRow>] {
        [
            HIGDataTableColumn("Order", minWidth: 100, value: \.id),
            HIGDataTableColumn("Customer", minWidth: 120, value: \.customer),
            HIGDataTableColumn("Total", value: \.total),
            HIGDataTableColumn("Status", alignment: .trailing, value: \.status),
        ]
    }

    var body: some View {
        ShowcaseRecipeLayoutView(
            component: .pageOrderDesk,
            code: """
            HIGPageHeader("Orders")
            filters + HIGDataTable
            HIGPanel("Order detail") { badges, notes, actions }
            """
        ) {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                HIGPageHeader(
                    "Order desk",
                    subtitle: "Ops queue for payments, fulfillment, and refunds."
                ) {
                    HIGButton("New order", role: .primary) {}
                }

                HIGSegmentedControl(
                    "Status",
                    selection: $statusFilter,
                    options: [
                        HIGRadioOption(value: "all", label: "All"),
                        HIGRadioOption(value: "Paid", label: "Paid"),
                        HIGRadioOption(value: "Fulfillment", label: "Ship"),
                        HIGRadioOption(value: "Refund", label: "Refund"),
                    ]
                )

                HIGPanel("Queue", description: "\(visibleOrders.count) orders") {
                    VStack(alignment: .leading, spacing: theme.spacing.item) {
                        HIGDataTable(rows: visibleOrders, columns: columns)
                        HIGListGroup(header: "Select order") {
                            ForEach(Array(visibleOrders.enumerated()), id: \.element.id) { index, order in
                                if index > 0 { HIGDivider() }
                                HIGListGroupRow(
                                    order.id,
                                    subtitle: "\(order.customer) · \(order.total)",
                                    systemImage: "shippingbox",
                                    isSelected: selectedID == order.id
                                ) { selectedID = order.id }
                            }
                        }
                    }
                }

                if let order = orders.first(where: { $0.id == selectedID }) {
                    HIGPanel(order.id, description: order.customer) {
                        VStack(alignment: .leading, spacing: theme.spacing.item) {
                            HStack(spacing: theme.spacing.item) {
                                HIGBadge(order.status, style: badgeStyle(for: order.status))
                                HIGBadge(order.total, style: .neutral)
                                Spacer(minLength: theme.spacing.item)
                                HIGStatusIndicator(order.status == "Refund" ? .busy : .online)
                            }
                            HIGTextEditor("Internal note", text: $note)
                            HIGButtonGroup {
                                HIGButton("Refund", role: .destructive) {}
                                HIGButton("Mark shipped", role: .secondary) {}
                                HIGButton("Message buyer", role: .primary) {}
                            }
                        }
                    }
                }
            }
        }
    }

    private var visibleOrders: [ShowcaseOrderRow] {
        guard statusFilter != "all" else { return orders }
        return orders.filter { $0.status == statusFilter }
    }

    private func badgeStyle(for status: String) -> HIGBadgeStyle {
        switch status {
        case "Paid": .success
        case "Fulfillment": .info
        case "Refund": .warning
        default: .neutral
        }
    }
}

#if DEBUG
#Preview("ShowcasePageOrderDeskView") {
    ShowcasePreviewContainer { ShowcasePageOrderDeskView() }
}
#endif
