import HIGDesign
import SwiftUI

struct ShowcaseImageOverlayView: View {
    @Environment(\.higTheme) private var theme

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                ShowcaseMetadataView(component: .imageOverlay)

                VStack(spacing: theme.spacing.screenEdge) {
                    ShowcaseSampleView(code: """
                    HIGImageOverlay(
                        "Coastline",
                        subtitle: "Featured gallery item",
                        edge: .bottom
                    ) { media }
                    """) {
                        HIGImageOverlay(
                            "Coastline",
                            subtitle: "Featured gallery item",
                            edge: .bottom
                        ) {
                            mediaStandIn
                        }
                    }

                    ShowcaseSampleView(code: """
                    HIGImageOverlay(
                        "Summit",
                        edge: .top
                    ) { media }
                    """) {
                        HIGImageOverlay(
                            "Summit",
                            subtitle: "Top-aligned caption",
                            edge: .top
                        ) {
                            mediaStandIn
                        }
                    }

                    ShowcaseSampleView(code: """
                    HIGImageOverlay(edge: .center) {
                        media
                    } panel: {
                        Image(systemName: "play.circle.fill")
                    }
                    """) {
                        HIGImageOverlay(edge: .center, showsScrim: true) {
                            mediaStandIn
                        } panel: {
                            Image(systemName: "play.circle.fill")
                                .font(.system(size: HIGSpacing.massive.rawValue))
                                .foregroundStyle(theme.colors.labelOnAccent)
                                .accessibilityLabel("Play")
                        }
                    }
                }
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle("Image Overlay")
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
#Preview("ShowcaseImageOverlayView") {
    ShowcasePreviewContainer {
        ShowcaseImageOverlayView()
    }
}
#endif
