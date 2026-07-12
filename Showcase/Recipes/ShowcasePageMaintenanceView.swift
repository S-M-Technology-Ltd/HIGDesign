import HIGDesign
import SwiftUI

struct ShowcasePageMaintenanceView: View {
    @Environment(\.higTheme) private var theme

    var body: some View {
        ShowcaseRecipeLayoutView(
            component: .pageMaintenance,
            code: """
            HIGEmptyState(
                "Under maintenance",
                message: "…",
                systemImage: "wrench.and.screwdriver"
            )
            """
        ) {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                HIGPageHeader(
                    "Maintenance",
                    subtitle: "Temporary unavailability messaging for deploy windows."
                )
                HIGEmptyState(
                    "Under maintenance",
                    message: "We are upgrading the admin console. Please check back shortly.",
                    systemImage: "wrench.and.screwdriver"
                ) {
                    HIGButton("Status page", role: .secondary) {}
                }
                .background(theme.colors.backgroundSecondary)
                .clipShape(RoundedRectangle(cornerRadius: theme.card.cornerRadius, style: .continuous))
            }
        }
    }
}

#if DEBUG
#Preview("ShowcasePageMaintenanceView") {
    ShowcasePreviewContainer { ShowcasePageMaintenanceView() }
}
#endif
