import HIGDesign
import SwiftUI

struct ShowcasePricingCardView: View {
    @Environment(\.higTheme) private var theme

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                ShowcaseMetadataView(component: .pricingCard)

                VStack(spacing: theme.spacing.screenEdge) {
                    ShowcaseSampleView(code: """
                    HIGPricingCard(
                        "Basic",
                        price: "9",
                        period: "/mo",
                        features: ["1 project", "Email support"],
                        actionTitle: "Choose Basic"
                    ) { /* … */ }
                    """) {
                        HIGPricingCard(
                            "Basic",
                            price: "9",
                            period: "/mo",
                            features: ["1 project", "Email support"],
                            actionTitle: "Choose Basic"
                        ) {}
                    }

                    ShowcaseSampleView(code: """
                    HIGPricingCard(
                        "Pro",
                        price: "29",
                        period: "/mo",
                        features: […],
                        isFeatured: true,
                        ribbonText: "Popular",
                        actionTitle: "Choose Pro"
                    ) { /* … */ }
                    """) {
                        HIGPricingCard(
                            "Pro",
                            price: "29",
                            period: "/mo",
                            features: [
                                "Unlimited projects",
                                "Priority support",
                                "Analytics dashboard"
                            ],
                            isFeatured: true,
                            ribbonText: "Popular",
                            actionTitle: "Choose Pro"
                        ) {}
                    }

                    ShowcaseSampleView(code: """
                    // Side-by-side plan comparison
                    HStack {
                        HIGPricingCard("Starter", …)
                        HIGPricingCard("Team", …, isFeatured: true)
                    }
                    """) {
                        HStack(alignment: .top, spacing: theme.spacing.item) {
                            HIGPricingCard(
                                "Starter",
                                price: "0",
                                period: "/mo",
                                features: ["Community access"],
                                actionTitle: "Start free"
                            ) {}

                            HIGPricingCard(
                                "Team",
                                price: "49",
                                period: "/mo",
                                features: ["5 seats", "SSO"],
                                isFeatured: true,
                                actionTitle: "Contact sales"
                            ) {}
                        }
                    }
                }
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle("Pricing Card")
    }
}

#if DEBUG
#Preview("ShowcasePricingCardView") {
    ShowcasePreviewContainer {
        ShowcasePricingCardView()
    }
}
#endif
