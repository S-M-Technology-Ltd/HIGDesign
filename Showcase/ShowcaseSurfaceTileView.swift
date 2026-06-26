import HIGDesign
import SwiftUI

struct ShowcaseSurfaceTileView<Content: View>: View {
    let title: String
    let subtitle: String
    let code: String
    @ViewBuilder let content: () -> Content

    var body: some View {
        ShowcaseSampleView(
            code: code,
            title: title,
            subtitle: subtitle,
            layout: .tile,
            contentAlignment: .center,
            content: content
        )
    }
}

#if DEBUG
#Preview("ShowcaseSurfaceTileView") {
    ShowcasePreviewContainer(includeNavigationStack: false) {
        ShowcaseSurfaceTileView(
            title: "Orbital",
            subtitle: "Medium",
            code: "HIGActivityIndicator(nil, size: .medium, style: .orbital)"
        ) {
            HIGActivityIndicator(nil, size: .medium, style: .orbital)
        }
        .higPadding(.screenEdge)
    }
}
#endif