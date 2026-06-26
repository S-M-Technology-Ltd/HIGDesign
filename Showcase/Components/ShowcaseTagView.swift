import HIGDesign
import SwiftUI

struct ShowcaseTagView: View {
    @Environment(\.higTheme) private var theme
    @State private var activeTags = ["Design", "SwiftUI", "Beta"]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                ShowcaseMetadataView(component: .tag)

                VStack(spacing: theme.spacing.item) {
                    ShowcaseSampleView(code: "HIGTag(\"Design\")") {
                        HIGTag("Design")
                    }
                    ShowcaseSampleView(code: "HIGTag(\"SwiftUI\", style: .accent)") {
                        HIGTag("SwiftUI", style: .accent)
                    }
                    ShowcaseSampleView(code: "HIGTag(\"Beta\", style: .outline)") {
                        HIGTag("Beta", style: .outline)
                    }
                    ShowcaseSampleView(code: """
                    HIGRemovableTag(tag, style: .outline) {
                        activeTags.removeAll { $0 == tag }
                    }
                    """) {
                        HIGRemovableTag("Design", style: .outline) {
                            activeTags.removeAll { $0 == "Design" }
                        }
                    }
                }
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle("Tag")
    }
}

#if DEBUG
#Preview("ShowcaseTagView") {
    ShowcasePreviewContainer {
        ShowcaseTagView()
    }
}
#endif