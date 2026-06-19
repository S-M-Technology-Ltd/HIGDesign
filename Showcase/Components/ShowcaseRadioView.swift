import HIGDesign
import SwiftUI

private enum ShowcaseBillingPlan: String, Hashable, Sendable {
    case monthly
    case yearly
}

struct ShowcaseRadioView: View {
    @State private var plan = ShowcaseBillingPlan.monthly

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                ShowcaseMetadataView(component: .radio)

                HIGRadio(
                    "Billing Plan",
                    selection: $plan,
                    options: [
                        HIGRadioOption(value: ShowcaseBillingPlan.monthly, label: "Monthly"),
                        HIGRadioOption(value: ShowcaseBillingPlan.yearly, label: "Yearly"),
                    ]
                )
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle("Radio")
    }
}

#if DEBUG
#Preview("ShowcaseRadioView") {
    ShowcaseRadioView()
}
#endif