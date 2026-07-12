import HIGDesign
import SwiftUI

struct ShowcasePageLockscreenView: View {
    @Environment(\.higTheme) private var theme
    @State private var password = ""

    var body: some View {
        ShowcaseRecipeLayoutView(
            component: .pageLockscreen,
            code: """
            HIGAvatar("AK")
            HIGSecureField("Password", text: $password)
            HIGButton("Unlock") {}
            """
        ) {
            VStack(alignment: .center, spacing: theme.spacing.section) {
                HIGPageHeader(
                    "Session locked",
                    subtitle: "Re-authenticate without leaving the admin context."
                )
                HIGCard {
                    VStack(spacing: theme.spacing.item) {
                        HIGAvatar("AK")
                        Text("Alex Kim")
                            .font(theme.typography.headline)
                            .foregroundStyle(theme.colors.labelPrimary)
                        HIGSecureField("Password", text: $password, placeholder: "Enter password")
                        HIGButton("Unlock", role: .primary) {}
                    }
                    .frame(maxWidth: .infinity)
                }
            }
        }
    }
}

#if DEBUG
#Preview("ShowcasePageLockscreenView") {
    ShowcasePreviewContainer { ShowcasePageLockscreenView() }
}
#endif
