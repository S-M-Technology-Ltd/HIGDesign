import HIGDesign
import SwiftUI

struct ShowcaseBadgeView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                ShowcaseMetadataView(component: .badge)

                HStack(spacing: 12) {
                    HIGBadge("New")
                    HIGBadge("3", style: .accent)
                    HIGBadge("!", style: .destructive)
                }
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle("Badge")
    }
}

#if DEBUG
#Preview("ShowcaseBadgeView") {
    ShowcaseBadgeView()
}
#endif