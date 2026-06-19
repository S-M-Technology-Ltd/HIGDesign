import HIGDesign
import SwiftUI

struct ShowcaseButtonView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                ShowcaseMetadataView(component: .button)

                VStack(spacing: 12) {
                    HIGButton("Continue", role: .primary) {}
                    HIGButton("Learn More", role: .secondary) {}
                    HIGButton("Delete Account", role: .destructive) {}
                    HIGButton("Skip", role: .borderless) {}
                    HIGButton("Saving", role: .primary, isLoading: true) {}
                }
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle("Button")
    }
}

#if DEBUG
#Preview("ShowcaseButtonView") {
    ShowcaseButtonView()
}
#endif