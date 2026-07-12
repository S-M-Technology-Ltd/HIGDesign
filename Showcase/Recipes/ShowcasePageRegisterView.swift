import HIGDesign
import SwiftUI

struct ShowcasePageRegisterView: View {
    @Environment(\.higTheme) private var theme
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""

    var body: some View {
        ShowcaseRecipeLayoutView(
            component: .pageRegister,
            code: """
            HIGCard {
                HIGTextField("Name", …)
                HIGTextField("Email", …)
                HIGSecureField("Password", …)
                HIGButton("Create account") {}
            }
            """
        ) {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                HIGPageHeader(
                    "Create account",
                    subtitle: "Covers register / register-v2 / register-v3."
                )
                HIGCard {
                    VStack(alignment: .leading, spacing: theme.spacing.item) {
                        HIGTextField("Name", text: $name, placeholder: "Full name")
                        HIGTextField("Email", text: $email, placeholder: "name@example.com")
                        HIGSecureField("Password", text: $password, placeholder: "Choose a password")
                        HIGButton("Create account", role: .primary) {}
                        HIGButton("Already have an account?", role: .borderless) {}
                    }
                }
            }
        }
    }
}

#if DEBUG
#Preview("ShowcasePageRegisterView") {
    ShowcasePreviewContainer { ShowcasePageRegisterView() }
}
#endif
