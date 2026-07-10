import HIGDesign
import SwiftUI

struct ShowcaseStepsView: View {
    @Environment(\.higTheme) private var theme
    @State private var index = 1

    private let items = [
        HIGStepsItem(id: "account", title: "Account", detail: "Basics"),
        HIGStepsItem(id: "profile", title: "Profile", detail: "Details"),
        HIGStepsItem(id: "review", title: "Review", detail: "Confirm"),
    ]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                ShowcaseMetadataView(component: .steps)

                VStack(spacing: theme.spacing.screenEdge) {
                    ShowcaseSampleView(code: """
                    HIGSteps(
                        items: items,
                        currentIndex: index,
                        onSelect: { index = $0 }
                    )
                    """) {
                        VStack(alignment: .leading, spacing: theme.spacing.item) {
                            HIGSteps(
                                items: items,
                                currentIndex: index,
                                onSelect: { index = $0 }
                            )
                            Text("Current index: \(index)")
                                .font(theme.typography.caption)
                                .foregroundStyle(theme.colors.labelSecondary)
                        }
                    }

                    ShowcaseSampleView(code: """
                    HIGSteps(items: items, currentIndex: 0, axis: .vertical)
                    """) {
                        HIGSteps(items: items, currentIndex: 0, axis: .vertical)
                    }
                }
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle("Steps")
    }
}

#if DEBUG
#Preview("ShowcaseStepsView") {
    ShowcasePreviewContainer {
        ShowcaseStepsView()
    }
}
#endif
