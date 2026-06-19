import HIGDesign
import SwiftUI

struct ShowcaseTagView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                ShowcaseMetadataView(component: .tag)

                HStack(spacing: 12) {
                    HIGTag("Design")
                    HIGTag("SwiftUI", style: .accent)
                    HIGTag("Beta", style: .outline)
                }
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle("Tag")
    }
}

#if DEBUG
#Preview("ShowcaseTagView") {
    ShowcaseTagView()
}
#endif