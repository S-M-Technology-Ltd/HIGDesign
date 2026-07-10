import HIGDesign
import SwiftUI

struct ShowcaseTooltipView: View {
    @Environment(\.higTheme) private var theme

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                ShowcaseMetadataView(component: .tooltip)

                VStack(spacing: theme.spacing.screenEdge) {
                    ShowcaseSampleView(code: """
                    HIGButton("Save", role: .primary) {}
                        .higTooltip("Save changes before leaving.")
                    """) {
                        HIGButton("Save", role: .primary) {}
                            .higTooltip("Save changes before leaving this page.")
                    }

                    ShowcaseSampleView(code: """
                    HIGTooltipLabel("Visible themed tooltip label")
                    """) {
                        HIGTooltipLabel("Save changes before leaving this page.")
                    }
                }
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle("Tooltip")
    }
}

#if DEBUG
#Preview("ShowcaseTooltipView") {
    ShowcasePreviewContainer {
        ShowcaseTooltipView()
    }
}
#endif
