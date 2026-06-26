import HIGDesign
import SwiftUI

struct ShowcaseSecureFieldView: View {
    @Environment(\.higTheme) private var theme
    @State private var password = ""
    @State private var pin = ""

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                ShowcaseMetadataView(component: .secureField)

                VStack(spacing: theme.spacing.screenEdge) {
                    ShowcaseSampleView(code: "HIGSecureField(\"Password\", text: $password, placeholder: \"Enter password\")") {
                        HIGSecureField("Password", text: $password, placeholder: "Enter password")
                    }
                    ShowcaseSampleView(code: "HIGSecureField(\"PIN\", text: $pin, placeholder: \"4-digit PIN\")") {
                        HIGSecureField("PIN", text: $pin, placeholder: "4-digit PIN")
                    }
                }
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle("Secure Field")
    }
}

#if DEBUG
#Preview("ShowcaseSecureFieldView") {
    ShowcasePreviewContainer {
        ShowcaseSecureFieldView()
    }
}
#endif