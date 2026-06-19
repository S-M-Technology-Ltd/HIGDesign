import HIGDesign
import SwiftUI

struct ShowcaseTextFieldView: View {
    @State private var fullName = ""
    @State private var email = "person@example.com"

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                ShowcaseMetadataView(component: .textField)

                VStack(spacing: 16) {
                    HIGTextField("Full name", text: $fullName, placeholder: "Enter your name")
                    HIGTextField("Email", text: $email, placeholder: "name@example.com")
                }
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle("Text Field")
    }
}

#if DEBUG
#Preview("ShowcaseTextFieldView") {
    ShowcaseTextFieldView()
}
#endif