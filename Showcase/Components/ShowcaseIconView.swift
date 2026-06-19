import HIGDesign
import SwiftUI

struct ShowcaseIconView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                ShowcaseMetadataView(component: .icon)

                VStack(alignment: .leading, spacing: 20) {
                    HStack(spacing: 16) {
                        HIGIcon("bell", size: .small)
                        HIGIcon("star.fill", style: .accent)
                        HIGIcon("folder", size: .large, style: .secondary)
                    }

                    HStack(spacing: 16) {
                        HIGIcon("checkmark.circle.fill", style: .accent)
                        HIGIcon("exclamationmark.triangle.fill", style: .primary)
                        HIGIcon("info.circle", style: .secondary)
                    }
                }
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle("Icon")
    }
}

#if DEBUG
#Preview("ShowcaseIconView") {
    ShowcaseIconView()
}
#endif