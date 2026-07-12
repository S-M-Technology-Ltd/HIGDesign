import HIGDesign
import SwiftUI

struct ShowcasePageForgotPasswordView: View {
    @Environment(\.higTheme) private var theme
    @State private var email = ""

    var body: some View {
        ShowcaseRecipeLayoutView(
            component: .pageForgotPassword,
            code: """
            HIGCard {
                HIGTextField("Email", text: $email)
                HIGButton("Send reset link") {}
            }
            """
        ) {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                HIGPageHeader(
                    "Forgot password",
                    subtitle: "Request a password reset email."
                )
                HIGCard {
                    VStack(alignment: .leading, spacing: theme.spacing.item) {
                        HIGTextField("Email", text: $email, placeholder: "name@example.com")
                        HIGFieldMessage("We will email a secure reset link.", kind: .helper)
                        HIGButton("Send reset link", role: .primary) {}
                        HIGButton("Back to sign in", role: .borderless) {}
                    }
                }
            }
        }
    }
}

#if DEBUG
#Preview("ShowcasePageForgotPasswordView") {
    ShowcasePreviewContainer { ShowcasePageForgotPasswordView() }
}
#endif
