import HIGDesign
import SwiftUI

struct ShowcaseVideoPlayerView: View {
    @Environment(\.higTheme) private var theme

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                ShowcaseMetadataView(component: .videoPlayer)

                VStack(spacing: theme.spacing.screenEdge) {
                    ShowcaseSampleView(code: """
                    HIGVideoPlayer(
                        title: "Product walkthrough",
                        caption: "…"
                    )
                    """) {
                        HIGVideoPlayer(
                            title: "Product walkthrough",
                            caption: "Placeholder when no media URL is supplied."
                        )
                    }

                    ShowcaseSampleView(code: """
                    HIGVideoPlayer(
                        url: demoURL,
                        title: "Remote sample",
                        caption: "Uses a public sample stream when online."
                    )
                    """) {
                        HIGVideoPlayer(
                            url: demoURL,
                            title: "Remote sample",
                            caption: "Uses a public sample stream when online."
                        )
                    }
                }
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle("Video Player")
    }

    /// Public sample asset for live demos; safe to omit offline (shows loading chrome).
    private var demoURL: URL? {
        URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4")
    }
}

#if DEBUG
#Preview("ShowcaseVideoPlayerView") {
    ShowcasePreviewContainer {
        ShowcaseVideoPlayerView()
    }
}
#endif
