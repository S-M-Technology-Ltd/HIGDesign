import HIGDesign
import SwiftUI

struct ShowcasePageBlankView: View {
    @Environment(\.higTheme) private var theme

    var body: some View {
        ShowcaseRecipeLayoutView(
            component: .pageBlank,
            code: """
            HIGPageHeader("Blank")
            HIGEmptyState("Start here") { HIGButton("Create") {} }
            """
        ) {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                HIGPageHeader(
                    "Blank",
                    subtitle: "Starter page chrome for new admin routes."
                )
                HIGEmptyState(
                    "Start here",
                    message: "Compose panels, tables, and forms into this shell.",
                    systemImage: "doc"
                ) {
                    HIGButton("Create", role: .primary) {}
                }
                .background(theme.colors.backgroundSecondary)
                .clipShape(RoundedRectangle(cornerRadius: theme.card.cornerRadius, style: .continuous))
            }
        }
    }
}

#if DEBUG
#Preview("ShowcasePageBlankView") {
    ShowcasePreviewContainer { ShowcasePageBlankView() }
}
#endif
