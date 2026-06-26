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

                VStack(alignment: .leading, spacing: 12) {
                    Text("Heroicons")
                        .font(.headline)

                    HStack(spacing: 16) {
                        HIGHeroIcon(descriptor: HIGThemeManager.outlineIcon(from: .academicCap))
                        HIGHeroIcon(descriptor: HIGThemeManager.solidIcon(from: .academicCap), style: .accent)
                        HIGHeroIcon(.bell, variant: .outline, size: .large)
                        HIGHeroIcon(.bell, variant: .solid, style: .secondary)
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