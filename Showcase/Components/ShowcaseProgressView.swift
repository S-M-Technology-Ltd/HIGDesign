import HIGDesign
import SwiftUI

struct ShowcaseProgressView: View {
    @Environment(\.higTheme) private var theme
    @State private var progress = 0.35

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                ShowcaseMetadataView(component: .progressView)

                VStack(alignment: .leading, spacing: theme.spacing.screenEdge) {
                    ShowcaseSampleView(code: "HIGProgressView(\"Preparing download\")") {
                        HIGProgressView("Preparing download")
                    }
                    ShowcaseSampleView(code: "HIGProgressView(\"Installing update\", value: progress, showsPercentage: true)") {
                        HIGProgressView("Installing update", value: progress, showsPercentage: true)
                    }
                    ShowcaseSampleView(code: "HIGButton(\"Increase Progress\", role: .secondary) { ... }") {
                        HIGButton("Increase Progress", role: .secondary) {
                            progress = min(progress + 0.1, 1)
                        }
                    }
                }
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle("Progress View")
    }
}

#if DEBUG
#Preview("ShowcaseProgressView") {
    ShowcasePreviewContainer {
        ShowcaseProgressView()
    }
}
#endif