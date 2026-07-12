import HIGDesign
import SwiftUI

/// Shared chrome for Wave 9 Showcase app/page recipes (composition only).
struct ShowcaseRecipeLayoutView<Content: View>: View {
    @Environment(\.higTheme) private var theme
    let component: ShowcaseComponent
    let code: String
    @ViewBuilder let content: () -> Content

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                ShowcaseMetadataView(component: component)

                ShowcaseSampleView(code: code) {
                    content()
                }
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle(component.title)
    }
}

#if DEBUG
#Preview("ShowcaseRecipeLayoutView") {
    ShowcasePreviewContainer {
        ShowcaseRecipeLayoutView(
            component: .appMailbox,
            code: "/* recipe */"
        ) {
            Text("Recipe body")
        }
    }
}
#endif
