import HIGDesign
import SwiftUI

struct ShowcaseButtonView: View {
    @Environment(\.higTheme) private var theme
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                ShowcaseMetadataView(component: .button)

                VStack(spacing: theme.spacing.item) {
                    ShowcaseSampleView(code: "HIGButton(\"Continue\", role: .primary) {}") {
                        HIGButton("Continue", role: .primary) {}
                    }
                    ShowcaseSampleView(code: "HIGButton(\"Learn More\", role: .secondary) {}") {
                        HIGButton("Learn More", role: .secondary) {}
                    }
                    ShowcaseSampleView(code: "HIGButton(\"Delete Account\", role: .destructive) {}") {
                        HIGButton("Delete Account", role: .destructive) {}
                    }
                    ShowcaseSampleView(code: "HIGButton(\"Share\", systemImage: \"square.and.arrow.up\", role: .secondary) {}") {
                        HIGButton("Share", systemImage: "square.and.arrow.up", role: .secondary) {}
                    }
                    ShowcaseSampleView(code: "HIGButton(\"Edit Photo\", systemImage: \"crop\", role: .secondary, style: .glass) {}") {
                        HIGButton("Edit Photo", systemImage: "crop", role: .secondary, style: .glass) {}
                    }
                    ShowcaseSampleView(code: "HIGButton(\"Continue\", systemImage: \"arrow.right\", role: .primary, style: .glass) {}") {
                        HIGButton("Continue", systemImage: "arrow.right", role: .primary, style: .glass) {}
                    }
                    ShowcaseSampleView(code: "HIGButton(\"Skip\", role: .borderless) {}") {
                        HIGButton("Skip", role: .borderless) {}
                    }
                    ShowcaseSampleView(code: "HIGButton(\"Saving\", role: .primary, isLoading: true) {}") {
                        HIGButton("Saving", role: .primary, isLoading: true) {}
                    }
                }
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle("Button")
    }
}

#if DEBUG
#Preview("ShowcaseButtonView") {
    ShowcasePreviewContainer {
        ShowcaseButtonView()
    }
}
#endif