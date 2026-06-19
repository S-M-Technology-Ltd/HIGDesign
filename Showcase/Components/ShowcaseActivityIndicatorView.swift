import HIGDesign
import SwiftUI

struct ShowcaseActivityIndicatorView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                ShowcaseMetadataView(component: .activityIndicator)

                VStack(alignment: .leading, spacing: 16) {
                    HIGActivityIndicator("Syncing library")
                    HIGActivityIndicator(size: .large)
                }
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle("Activity Indicator")
    }
}

#if DEBUG
#Preview("ShowcaseActivityIndicatorView") {
    ShowcaseActivityIndicatorView()
}
#endif