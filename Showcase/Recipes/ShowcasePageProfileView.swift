import HIGDesign
import SwiftUI

struct ShowcasePageProfileView: View {
    @Environment(\.higTheme) private var theme
    @State private var name = "Alex Kim"
    @State private var title = "Product Manager"
    @State private var bio = "Ships HIG-native admin surfaces across Apple platforms."

    var body: some View {
        ShowcaseRecipeLayoutView(
            component: .pageProfile,
            code: """
            HIGCover("Alex Kim", subtitle: "…")
            HIGPanel("About") { HIGTextEditor(…) }
            """
        ) {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                HIGCover(
                    name,
                    subtitle: title,
                    style: .accent
                )
                HIGPanel("Profile", description: "Covers profile / profile-v2 / profile-v3.") {
                    VStack(alignment: .leading, spacing: theme.spacing.item) {
                        HStack(spacing: theme.spacing.item) {
                            HIGAvatar("AK", status: .online)
                            VStack(alignment: .leading, spacing: theme.spacing.compactItem) {
                                Text(name)
                                    .font(theme.typography.headline)
                                    .foregroundStyle(theme.colors.labelPrimary)
                                Text(title)
                                    .font(theme.typography.caption)
                                    .foregroundStyle(theme.colors.labelSecondary)
                            }
                            Spacer(minLength: theme.spacing.item)
                            HIGButton("Edit", role: .secondary) {}
                        }
                        HIGTextField("Display name", text: $name)
                        HIGTextField("Title", text: $title)
                        HIGTextEditor("Bio", text: $bio)
                    }
                }
            }
        }
    }
}

#if DEBUG
#Preview("ShowcasePageProfileView") {
    ShowcasePreviewContainer { ShowcasePageProfileView() }
}
#endif
