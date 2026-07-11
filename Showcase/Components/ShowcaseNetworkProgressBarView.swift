import HIGDesign
import SwiftUI

struct ShowcaseNetworkProgressBarView: View {
    @Environment(\.higTheme) private var theme
    @State private var isActive = true
    @State private var progress: Double = 0.35

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                ShowcaseMetadataView(component: .networkProgressBar)

                VStack(spacing: theme.spacing.screenEdge) {
                    ShowcaseSampleView(code: """
                    HIGNetworkProgressBar(isActive: true)
                    HIGNetworkProgressBar(isActive: true, value: 0.45)
                    """) {
                        VStack(alignment: .leading, spacing: theme.spacing.item) {
                            Text("Indeterminate")
                                .font(theme.typography.caption)
                                .foregroundStyle(theme.colors.labelSecondary)
                            HIGNetworkProgressBar(isActive: isActive)

                            Text("Determinate")
                                .font(theme.typography.caption)
                                .foregroundStyle(theme.colors.labelSecondary)
                            HIGNetworkProgressBar(isActive: isActive, value: progress)

                            HIGButton(isActive ? "Hide" : "Show", role: .secondary) {
                                isActive.toggle()
                            }
                        }
                    }
                }
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle("Network Progress Bar")
    }
}

#if DEBUG
#Preview("ShowcaseNetworkProgressBarView") {
    ShowcasePreviewContainer {
        ShowcaseNetworkProgressBarView()
    }
}
#endif
