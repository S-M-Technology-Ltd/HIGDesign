import HIGDesign
import SwiftUI

struct ShowcaseLabelView: View {
    @Environment(\.higTheme) private var theme
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                ShowcaseMetadataView(component: .label)

                VStack(spacing: theme.spacing.screenEdge) {
                    ShowcaseSampleView(code: "HIGLabel(\"Notifications\", subtitle: \"Choose alert delivery\", style: .primary)") {
                        HIGLabel("Notifications", subtitle: "Choose alert delivery", style: .primary)
                    }
                    ShowcaseSampleView(code: "HIGLabel(\"Last synced\", subtitle: \"2 minutes ago\", style: .secondary)") {
                        HIGLabel("Last synced", subtitle: "2 minutes ago", style: .secondary)
                    }
                    ShowcaseSampleView(code: "HIGLabel(\"Optional detail\", style: .caption)") {
                        HIGLabel("Optional detail", style: .caption)
                    }
                }
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle("Label")
    }
}

#if DEBUG
#Preview("ShowcaseLabelView") {
    ShowcasePreviewContainer {
        ShowcaseLabelView()
    }
}
#endif