import HIGDesign
import SwiftUI

struct ShowcaseMetadataView: View {
    @Environment(\.higTheme) private var theme
    let component: ShowcaseComponent

    var body: some View {
        VStack(alignment: .leading, spacing: theme.spacing.compactItem) {
            Text(component.summary)
                .font(theme.typography.body)

            Group {
                Text("HIG: \(component.higReference)")
                Text("Platforms: \(component.platforms)")
            }
            .font(theme.typography.caption)
            .foregroundStyle(theme.colors.labelSecondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#if DEBUG
#Preview("ShowcaseMetadataView") {
    ShowcasePreviewContainer(includeNavigationStack: false) {
        ShowcaseMetadataView(component: .button)
            .higPadding(.screenEdge)
    }
}
#endif