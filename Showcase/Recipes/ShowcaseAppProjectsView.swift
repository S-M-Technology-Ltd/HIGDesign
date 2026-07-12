import HIGDesign
import SwiftUI

struct ShowcaseAppProjectsView: View {
    @Environment(\.higTheme) private var theme
    @State private var step = 1

    private let steps = [
        HIGStepsItem(id: "scope", title: "Scope", detail: "Goals"),
        HIGStepsItem(id: "build", title: "Build", detail: "Delivery"),
        HIGStepsItem(id: "launch", title: "Launch", detail: "Ship"),
    ]

    var body: some View {
        ShowcaseRecipeLayoutView(
            component: .appProjects,
            code: """
            HIGPageHeader("Projects")
            HIGSteps(items: steps, currentIndex: step)
            HIGCard { HIGProgressView(…) }
            """
        ) {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                HIGPageHeader(
                    "Projects",
                    subtitle: "Multi-step project trackers with cards and progress."
                )
                HIGSteps(
                    items: steps,
                    currentIndex: step,
                    onSelect: { step = $0 }
                )
                HIGCard {
                    VStack(alignment: .leading, spacing: theme.spacing.item) {
                        Text("Admin shell redesign")
                            .font(theme.typography.headline)
                            .foregroundStyle(theme.colors.labelPrimary)
                        Text("Wave 7 shell styles and dense chrome tokens.")
                            .font(theme.typography.caption)
                            .foregroundStyle(theme.colors.labelSecondary)
                        HIGProgressView(value: 0.66)
                        HStack {
                            HIGBadge("On track", style: .accent)
                            Spacer(minLength: theme.spacing.item)
                            HIGButton("Open", role: .secondary) {}
                        }
                    }
                }
                HIGCard {
                    VStack(alignment: .leading, spacing: theme.spacing.item) {
                        Text("Charts family")
                            .font(theme.typography.headline)
                            .foregroundStyle(theme.colors.labelPrimary)
                        Text("Bar, line, pie, and area for admin metrics.")
                            .font(theme.typography.caption)
                            .foregroundStyle(theme.colors.labelSecondary)
                        HIGProgressView(value: 0.9)
                    }
                }
            }
        }
    }
}

#if DEBUG
#Preview("ShowcaseAppProjectsView") {
    ShowcasePreviewContainer {
        ShowcaseAppProjectsView()
    }
}
#endif
