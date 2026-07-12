import HIGDesign
import SwiftUI

struct ShowcasePageEmailTemplatesView: View {
    @Environment(\.higTheme) private var theme

    var body: some View {
        ShowcaseRecipeLayoutView(
            component: .pageEmailTemplates,
            code: """
            HIGPageHeader("Email templates")
            HIGPanel("Welcome") { … }
            HIGPanel("News") { … }
            """
        ) {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                HIGPageHeader(
                    "Email templates",
                    subtitle: "Layout recipes for welcome, news, post, articles, and thumbnail emails."
                )
                HIGPanelGroup {
                    HIGPanel("Welcome", description: "email-welcome") {
                        emailBody(
                            title: "Welcome to HIG Admin",
                            body: "Confirm your email to finish setup.",
                            cta: "Confirm email"
                        )
                    }
                    HIGPanel("News", description: "email-news") {
                        emailBody(
                            title: "Weekly digest",
                            body: "Highlights from your dashboards and teams.",
                            cta: "Read digest"
                        )
                    }
                    HIGPanel("Post", description: "email-post") {
                        emailBody(
                            title: "New article",
                            body: "A teammate published “Shipping Wave 9 recipes”.",
                            cta: "Open article"
                        )
                    }
                }
                Text("Articles and thumbnail variants reuse the same panel + CTA pattern.")
                    .font(theme.typography.caption)
                    .foregroundStyle(theme.colors.labelSecondary)
            }
        }
    }

    private func emailBody(title: String, body: String, cta: String) -> some View {
        VStack(alignment: .leading, spacing: theme.spacing.item) {
            Text(title)
                .font(theme.typography.headline)
                .foregroundStyle(theme.colors.labelPrimary)
            Text(body)
                .font(theme.typography.body)
                .foregroundStyle(theme.colors.labelSecondary)
            HIGButton(cta, role: .primary) {}
        }
    }
}

#if DEBUG
#Preview("ShowcasePageEmailTemplatesView") {
    ShowcasePreviewContainer { ShowcasePageEmailTemplatesView() }
}
#endif
