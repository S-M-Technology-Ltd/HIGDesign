import HIGDesign
import SwiftUI

private struct ShowcaseInvoiceRow: Identifiable {
    let id: String
    let period: String
    let amount: String
    let status: String
}

/// Billing center: plan comparison, payment method, invoice history.
struct ShowcasePageBillingCenterView: View {
    @Environment(\.higTheme) private var theme
    @State private var seats = 12
    @State private var autoRenew = true

    private let invoices: [ShowcaseInvoiceRow] = [
        .init(id: "inv-1842", period: "Mar 2026", amount: "$160.24", status: "Paid"),
        .init(id: "inv-1810", period: "Feb 2026", amount: "$160.24", status: "Paid"),
        .init(id: "inv-1777", period: "Jan 2026", amount: "$148.00", status: "Paid"),
    ]

    private var columns: [HIGDataTableColumn<ShowcaseInvoiceRow>] {
        [
            HIGDataTableColumn("Invoice", minWidth: 100, value: \.id),
            HIGDataTableColumn("Period", value: \.period),
            HIGDataTableColumn("Amount", value: \.amount),
            HIGDataTableColumn("Status", alignment: .trailing, value: \.status),
        ]
    }

    var body: some View {
        ShowcaseRecipeLayoutView(
            component: .pageBillingCenter,
            code: """
            HIGPageHeader("Billing")
            HIGPricingCard plans
            payment method + seat stepper
            HIGDataTable invoices
            """
        ) {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                HIGPageHeader(
                    "Billing center",
                    subtitle: "Plan, seats, payment method, and invoice history."
                ) {
                    HIGButton("Update card", role: .secondary) {}
                }

                HIGAlertBanner(
                    "Renewal on April 12",
                    message: "Your Pro plan renews automatically for \(seats) seats.",
                    style: .info
                )

                #if os(watchOS)
                pricingStack
                #else
                HStack(alignment: .top, spacing: theme.spacing.item) {
                    pricingStack
                }
                #endif

                HIGPanel("Subscription", description: "Seat-based Pro plan") {
                    VStack(alignment: .leading, spacing: theme.spacing.item) {
                        HIGStepper("Seats", value: $seats, in: 1...200)
                        HIGToggle("Auto-renew", isOn: $autoRenew)
                        HIGMediaRow("Visa ···· 4242", subtitle: "Expires 08/28", showsBorder: true) {
                            Image(systemName: "creditcard.fill")
                                .foregroundStyle(theme.colors.accent)
                        } trailing: {
                            HIGBadge("Default", style: .accent)
                        }
                    }
                }

                HIGPanel("Invoices") {
                    HIGDataTable(rows: invoices, columns: columns)
                }
            }
        }
    }

    private var pricingStack: some View {
        Group {
            #if os(watchOS)
            VStack(spacing: theme.spacing.item) { pricingCards }
            #else
            HStack(alignment: .top, spacing: theme.spacing.item) { pricingCards }
            #endif
        }
    }

    @ViewBuilder
    private var pricingCards: some View {
        HIGPricingCard(
            "Starter",
            price: "29",
            period: "/mo",
            features: ["3 seats", "Email support", "Basic analytics"],
            actionTitle: "Downgrade"
        ) {}
        HIGPricingCard(
            "Pro",
            price: "99",
            period: "/mo",
            features: ["Unlimited seats", "SSO", "Priority support", "Advanced analytics"],
            isFeatured: true,
            ribbonText: "Current",
            actionTitle: "Current plan"
        ) {}
    }
}

#if DEBUG
#Preview("ShowcasePageBillingCenterView") {
    ShowcasePreviewContainer { ShowcasePageBillingCenterView() }
}
#endif
