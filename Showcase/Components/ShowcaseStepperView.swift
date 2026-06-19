import HIGDesign
import SwiftUI

struct ShowcaseStepperView: View {
    @State private var quantity = 2
    @State private var guests = 4

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                ShowcaseMetadataView(component: .stepper)

                VStack(spacing: 20) {
                    HIGStepper("Quantity", value: $quantity, in: 1 ... 10)
                    HIGStepper("Guests", value: $guests, in: 1 ... 20)
                }
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle("Stepper")
    }
}

#if DEBUG
#Preview("ShowcaseStepperView") {
    ShowcaseStepperView()
}
#endif