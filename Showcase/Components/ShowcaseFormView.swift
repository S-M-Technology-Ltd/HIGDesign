import HIGDesign
import SwiftUI

struct ShowcaseFormView: View {
    @State private var notificationsEnabled = true
    @State private var email = "person@example.com"

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                ShowcaseMetadataView(component: .form)

                HIGFormSection("Account", footer: "Manage sign-in and profile details.") {
                    HIGToggle("Notifications", isOn: $notificationsEnabled)
                    HIGDivider()
                    HIGTextField("Email", text: $email, placeholder: "name@example.com")
                }
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle("Form Section")
    }
}

#if DEBUG
#Preview("ShowcaseFormView") {
    ShowcaseFormView()
}
#endif