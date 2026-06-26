import HIGDesign
import SwiftUI

struct ShowcaseTextFieldView: View {
    @Environment(\.higTheme) private var theme
    @State private var fullName = ""
    @State private var email = "person@example.com"

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                ShowcaseMetadataView(component: .textField)

                VStack(spacing: theme.spacing.screenEdge) {
                    ShowcaseSampleView(code: "HIGTextField(\"Full name\", text: $fullName, placeholder: \"Enter your name\")") {
                        HIGTextField("Full name", text: $fullName, placeholder: "Enter your name")
                    }
                    ShowcaseSampleView(code: "HIGTextField(\"Email\", text: $email, placeholder: \"name@example.com\")") {
                        HIGTextField("Email", text: $email, placeholder: "name@example.com")
                    }
                }
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle("Text Field")
    }
}

#if DEBUG
#Preview("ShowcaseTextFieldView") {
    ShowcasePreviewContainer {
        ShowcaseTextFieldView()
    }
}
#endif