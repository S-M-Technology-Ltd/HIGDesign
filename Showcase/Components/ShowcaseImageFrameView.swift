import HIGDesign
import SwiftUI

struct ShowcaseImageFrameView: View {
    @Environment(\.higTheme) private var theme

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                ShowcaseMetadataView(component: .imageFrame)

                VStack(spacing: theme.spacing.screenEdge) {
                    ShowcaseSampleView(code: """
                    HIGImageFrame(aspect: .widescreen) {
                        LinearGradient(…)
                    }
                    """) {
                        HIGImageFrame(aspect: .widescreen, accessibilityLabel: "Widescreen media") {
                            mediaStandIn
                        }
                    }

                    ShowcaseSampleView(code: """
                    HIGImageFrame(aspect: .square) {
                        LinearGradient(…)
                    }
                    """) {
                        HIGImageFrame(aspect: .square, accessibilityLabel: "Square media") {
                            mediaStandIn
                        }
                        .frame(maxWidth: 200)
                    }

                    ShowcaseSampleView(code: """
                    HIGImageFrame(aspect: .photo)
                    // placeholder when no media
                    """) {
                        HIGImageFrame(aspect: .photo)
                    }

                    ShowcaseSampleView(code: """
                    HIGImageFrame(aspect: .flexible) { media }
                    """) {
                        HIGImageFrame(
                            aspect: .flexible,
                            contentMode: .fit,
                            accessibilityLabel: "Flexible media"
                        ) {
                            mediaStandIn
                                .frame(height: HIGSpacing.massive.rawValue * 2)
                        }
                    }
                }
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle("Image Frame")
    }

    private var mediaStandIn: some View {
        LinearGradient(
            colors: [theme.colors.accent, theme.colors.fillPrimary],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
}

#if DEBUG
#Preview("ShowcaseImageFrameView") {
    ShowcasePreviewContainer {
        ShowcaseImageFrameView()
    }
}
#endif
