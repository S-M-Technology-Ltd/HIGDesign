import HIGDesign
import SwiftUI

struct ShowcaseBulletListView: View {
    @Environment(\.higTheme) private var theme
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                ShowcaseMetadataView(component: .bulletList)

                ShowcaseSampleView(code: """
                HIGBulletList([
                    "Use system colors and SF Symbols first.",
                    "Support Dynamic Type in every component.",
                    "Document platform-specific behavior.",
                ])
                """) {
                    HIGBulletList([
                        "Use system colors and SF Symbols first.",
                        "Support Dynamic Type in every component.",
                        "Document platform-specific behavior.",
                    ])
                }
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle("Bullet List")
    }
}

#if DEBUG
#Preview("ShowcaseBulletListView") {
    ShowcasePreviewContainer {
        ShowcaseBulletListView()
    }
}
#endif