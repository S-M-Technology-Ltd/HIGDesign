import HIGDesign
import SwiftUI

struct ShowcaseProgressView: View {
    @State private var progress = 0.35

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                ShowcaseMetadataView(component: .progressView)

                VStack(alignment: .leading, spacing: 16) {
                    HIGProgressView("Preparing download")
                    HIGProgressView("Installing update", value: progress)
                    HIGButton("Increase Progress", role: .secondary) {
                        progress = min(progress + 0.1, 1)
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
    ShowcaseProgressView()
}
#endif