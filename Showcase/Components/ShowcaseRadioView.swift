import HIGDesign
import SwiftUI

private enum ShowcaseBillingPlan: String, Hashable, Sendable {
    case monthly
    case yearly
}

struct ShowcaseRadioView: View {
    @Environment(\.higTheme) private var theme
    @State private var plan = ShowcaseBillingPlan.monthly

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                ShowcaseMetadataView(component: .radio)

                ShowcaseSampleView(code: """
                HIGRadio(
                    "Billing Plan",
                    selection: $plan,
                    options: [
                        HIGRadioOption(value: .monthly, label: "Monthly"),
                        HIGRadioOption(value: .yearly, label: "Yearly"),
                    ]
                )
                """) {
                    HIGRadio(
                        "Billing Plan",
                        selection: $plan,
                        options: [
                            HIGRadioOption(value: ShowcaseBillingPlan.monthly, label: "Monthly"),
                            HIGRadioOption(value: ShowcaseBillingPlan.yearly, label: "Yearly"),
                        ]
                    )
                }
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle("Radio")
    }
}

#if DEBUG
#Preview("ShowcaseRadioView") {
    ShowcasePreviewContainer {
        ShowcaseRadioView()
    }
}
#endif