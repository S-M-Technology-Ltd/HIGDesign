import HIGDesign
import SwiftUI

struct ShowcaseTagView: View {
    @State private var activeTags = ["Design", "SwiftUI", "Beta"]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                ShowcaseMetadataView(component: .tag)

                HStack(spacing: 12) {
                    HIGTag("Design")
                    HIGTag("SwiftUI", style: .accent)
                    HIGTag("Beta", style: .outline)
                }

                VStack(alignment: .leading, spacing: 12) {
                    Text("Removable filters")
                        .font(.caption)
                        .foregroundStyle(.secondary)

                    HStack(spacing: 12) {
                        ForEach(activeTags, id: \.self) { tag in
                            HIGRemovableTag(tag, style: .outline) {
                                activeTags.removeAll { $0 == tag }
                            }
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
    ShowcaseTagView()
}
#endif