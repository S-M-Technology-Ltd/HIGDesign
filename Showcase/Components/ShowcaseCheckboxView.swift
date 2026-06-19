import HIGDesign
import SwiftUI

struct ShowcaseCheckboxView: View {
    @State private var rememberMe = true
    @State private var marketingEmails = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                ShowcaseMetadataView(component: .checkbox)

                VStack(spacing: 16) {
                    HIGCheckbox("Remember me", isOn: $rememberMe)
                    HIGCheckbox("Marketing emails", isOn: $marketingEmails)
                }
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle("Checkbox")
    }
}

#if DEBUG
#Preview("ShowcaseCheckboxView") {
    ShowcaseCheckboxView()
}
#endif