import HIGDesign
import SwiftUI

struct ShowcasePageFAQView: View {
    @Environment(\.higTheme) private var theme
    @State private var expanded: Set<String> = ["tokens"]

    var body: some View {
        ShowcaseRecipeLayoutView(
            component: .pageFAQ,
            code: """
            HIGPageHeader("FAQ")
            HIGAccordion {
                HIGAccordionSection(id: "…", title: "…", expandedIDs: $expanded) { … }
            }
            """
        ) {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                HIGPageHeader(
                    "FAQ",
                    subtitle: "Expandable answers for common admin questions."
                )
                HIGAccordion {
                    HIGAccordionSection(
                        id: "tokens",
                        title: "Where do colors and spacing come from?",
                        expandedIDs: $expanded
                    ) {
                        Text("All visuals resolve from HIG design tokens via @Environment(\\.higTheme).")
                            .font(theme.typography.body)
                            .foregroundStyle(theme.colors.labelSecondary)
                    }
                    HIGAccordionSection(
                        id: "platforms",
                        title: "Which platforms are supported?",
                        expandedIDs: $expanded
                    ) {
                        Text("iOS, iPadOS, macOS, visionOS, tvOS, and watchOS with the latest three calendar years as minimum OS.")
                            .font(theme.typography.body)
                            .foregroundStyle(theme.colors.labelSecondary)
                    }
                    HIGAccordionSection(
                        id: "recipes",
                        title: "What is a Showcase recipe?",
                        expandedIDs: $expanded
                    ) {
                        Text("A composition-only demo that uses public HIG APIs without shipping a business module.")
                            .font(theme.typography.body)
                            .foregroundStyle(theme.colors.labelSecondary)
                    }
                }
            }
        }
    }
}

#if DEBUG
#Preview("ShowcasePageFAQView") {
    ShowcasePreviewContainer { ShowcasePageFAQView() }
}
#endif
