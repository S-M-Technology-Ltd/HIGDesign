import HIGDesign
import SwiftUI

struct ShowcaseStepperView: View {
    @Environment(\.higTheme) private var theme
    @State private var quantity = 2
    @State private var guests = 4

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                ShowcaseMetadataView(component: .stepper)

                VStack(spacing: theme.spacing.section) {
                    ShowcaseSampleView(code: "HIGStepper(\"Quantity\", value: $quantity, in: 1 ... 10)") {
                        HIGStepper("Quantity", value: $quantity, in: 1 ... 10)
                    }
                    ShowcaseSampleView(code: "HIGStepper(\"Guests\", value: $guests, in: 1 ... 20)") {
                        HIGStepper("Guests", value: $guests, in: 1 ... 20)
                    }
                }
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle("Stepper")
    }
}

#if DEBUG
#Preview("ShowcaseStepperView") {
    ShowcasePreviewContainer {
        ShowcaseStepperView()
    }
}
#endif