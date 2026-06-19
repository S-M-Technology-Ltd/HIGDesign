import HIGDesign
import SwiftUI

struct ShowcaseSecureFieldView: View {
    @State private var password = ""
    @State private var pin = ""

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                ShowcaseMetadataView(component: .secureField)

                VStack(spacing: 16) {
                    HIGSecureField("Password", text: $password, placeholder: "Enter password")
                    HIGSecureField("PIN", text: $pin, placeholder: "4-digit PIN")
                }
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle("Secure Field")
    }
}

#if DEBUG
#Preview("ShowcaseSecureFieldView") {
    ShowcaseSecureFieldView()
}
#endif