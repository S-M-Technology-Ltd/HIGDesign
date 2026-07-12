import HIGDesign
import SwiftUI

struct ShowcasePageProjectView: View {
    @Environment(\.higTheme) private var theme
    @State private var step = 1

    private let steps = [
        HIGStepsItem(id: "plan", title: "Plan", detail: "Scope"),
        HIGStepsItem(id: "build", title: "Build", detail: "Delivery"),
        HIGStepsItem(id: "launch", title: "Launch", detail: "Ship"),
    ]

    var body: some View {
        ShowcaseRecipeLayoutView(
            component: .pageProject,
            code: """
            HIGPageHeader("Project")
            HIGSteps(items: steps, currentIndex: step)
            HIGPanel("Summary") { … }
            """
        ) {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                HIGPageHeader(
                    "Project Alpha",
                    subtitle: "Single project detail page composition."
                ) {
                    HIGButton("Share", role: .secondary) {}
                }
                HIGSteps(items: steps, currentIndex: step, onSelect: { step = $0 })
                HIGPanel("Summary", description: "Owners and status") {
                    VStack(alignment: .leading, spacing: theme.spacing.item) {
                        HIGMediaRow("Owner", subtitle: "Alex Kim", showsBorder: false) {
                            HIGAvatar("AK")
                        } trailing: {
                            HIGBadge("Active", style: .accent)
                        }
                        HIGProgressView(value: 0.55)
                        Text("55% complete")
                            .font(theme.typography.caption)
                            .foregroundStyle(theme.colors.labelSecondary)
                    }
                }
            }
        }
    }
}

#if DEBUG
#Preview("ShowcasePageProjectView") {
    ShowcasePreviewContainer { ShowcasePageProjectView() }
}
#endif
