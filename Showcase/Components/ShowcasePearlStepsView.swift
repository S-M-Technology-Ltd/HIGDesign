import HIGDesign
import SwiftUI

struct ShowcasePearlStepsView: View {
    @Environment(\.higTheme) private var theme
    @State private var index = 2

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                ShowcaseMetadataView(component: .pearlSteps)

                VStack(spacing: theme.spacing.screenEdge) {
                    ShowcaseSampleView(code: """
                    HIGPearlSteps(
                        count: 5,
                        currentIndex: index,
                        onSelect: { index = $0 }
                    )
                    """) {
                        VStack(alignment: .leading, spacing: theme.spacing.item) {
                            HIGPearlSteps(
                                count: 5,
                                currentIndex: index,
                                onSelect: { index = $0 }
                            )
                            Text("Pearl \(index + 1) of 5")
                                .font(theme.typography.caption)
                                .foregroundStyle(theme.colors.labelSecondary)
                        }
                    }

                    ShowcaseSampleView(code: """
                    HIGPearlSteps(count: 3, currentIndex: 0)
                    """) {
                        HIGPearlSteps(count: 3, currentIndex: 0)
                    }
                }
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle("Pearl Steps")
    }
}

#if DEBUG
#Preview("ShowcasePearlStepsView") {
    ShowcasePreviewContainer {
        ShowcasePearlStepsView()
    }
}
#endif
