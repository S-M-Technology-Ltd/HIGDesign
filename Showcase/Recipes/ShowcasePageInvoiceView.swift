import HIGDesign
import SwiftUI

private struct ShowcaseInvoiceLine: Identifiable {
    let id: Int
    let item: String
    let qty: String
    let amount: String
}

struct ShowcasePageInvoiceView: View {
    @Environment(\.higTheme) private var theme

    private let lines: [ShowcaseInvoiceLine] = [
        .init(id: 1, item: "HIGDesign Pro", qty: "1", amount: "$99.00"),
        .init(id: 2, item: "Priority support", qty: "1", amount: "$49.00"),
        .init(id: 3, item: "Tax", qty: "—", amount: "$12.24"),
    ]

    private var columns: [HIGDataTableColumn<ShowcaseInvoiceLine>] {
        [
            HIGDataTableColumn("Item", minWidth: 140, value: \.item),
            HIGDataTableColumn("Qty", value: \.qty),
            HIGDataTableColumn("Amount", alignment: .trailing, value: \.amount),
        ]
    }

    var body: some View {
        ShowcaseRecipeLayoutView(
            component: .pageInvoice,
            code: """
            HIGPageHeader("Invoice #1842")
            HIGPanel("Bill to") { … }
            HIGDataTable(rows: lines, columns: …)
            """
        ) {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                HIGPageHeader(
                    "Invoice #1842",
                    subtitle: "Issued March 12 · Due March 26"
                ) {
                    HIGButton("Download", role: .secondary) {}
                }
                HIGPanel("Bill to", description: "Acme Admin Co.") {
                    Text("Attn: Finance\n1 Infinite Loop\nCupertino, CA")
                        .font(theme.typography.body)
                        .foregroundStyle(theme.colors.labelSecondary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                HIGDataTable(rows: lines, columns: columns)
                HStack {
                    Spacer(minLength: theme.spacing.item)
                    Text("Total $160.24")
                        .font(theme.typography.headline)
                        .foregroundStyle(theme.colors.labelPrimary)
                }
            }
        }
    }
}

#if DEBUG
#Preview("ShowcasePageInvoiceView") {
    ShowcasePreviewContainer { ShowcasePageInvoiceView() }
}
#endif
