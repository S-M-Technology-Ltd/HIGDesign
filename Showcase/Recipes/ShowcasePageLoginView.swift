import HIGDesign
import SwiftUI

struct ShowcasePageLoginView: View {
    @Environment(\.higTheme) private var theme
    @State private var email = "admin@example.com"
    @State private var password = ""

    var body: some View {
        ShowcaseRecipeLayoutView(
            component: .pageLogin,
            code: """
            HIGCard {
                HIGTextField("Email", text: $email)
                HIGSecureField("Password", text: $password)
                HIGButton("Sign in") {}
            }
            """
        ) {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                HIGHero(
                    "Sign in",
                    subtitle: "Covers login / login-v2 / login-v3 as one HIG composition.",
                    style: .standard,
                    alignment: .center
                )
                HIGCard {
                    VStack(alignment: .leading, spacing: theme.spacing.item) {
                        HIGTextField("Email", text: $email, placeholder: "name@example.com")
                        HIGSecureField("Password", text: $password, placeholder: "Required")
                        HIGButton("Sign in", role: .primary) {}
                        HIGButton("Forgot password?", role: .borderless) {}
                    }
                }
            }
        }
    }
}

#if DEBUG
#Preview("ShowcasePageLoginView") {
    ShowcasePreviewContainer { ShowcasePageLoginView() }
}
#endif
