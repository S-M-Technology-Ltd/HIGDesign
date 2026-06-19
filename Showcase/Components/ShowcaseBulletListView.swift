import HIGDesign
import SwiftUI

struct ShowcaseBulletListView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                ShowcaseMetadataView(component: .bulletList)

                HIGBulletList([
                    "Use system colors and SF Symbols first.",
                    "Support Dynamic Type in every component.",
                    "Document platform-specific behavior.",
                ])
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle("Bullet List")
    }
}

#if DEBUG
#Preview("ShowcaseBulletListView") {
    ShowcaseBulletListView()
}
#endif