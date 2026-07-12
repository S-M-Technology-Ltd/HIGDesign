import HIGDesign
import SwiftUI
import UniformTypeIdentifiers

struct ShowcaseDropZoneView: View {
    @Environment(\.higTheme) private var theme
    @State private var multiURLs: [URL] = []
    @State private var singleURL: [URL] = []

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                ShowcaseMetadataView(component: .dropZone)

                VStack(spacing: theme.spacing.screenEdge) {
                    ShowcaseSampleView(code: """
                    HIGDropZone(
                        urls: $files,
                        allowedContentTypes: [.image, .pdf]
                    )
                    """) {
                        HIGDropZone(
                            urls: $multiURLs,
                            allowedContentTypes: [.image, .pdf, .plainText]
                        )
                    }

                    ShowcaseSampleView(code: """
                    HIGDropZone(
                        "Attach document",
                        urls: $file,
                        message: "PDF only",
                        browseLabel: "Browse",
                        allowedContentTypes: [.pdf],
                        allowsMultipleSelection: false
                    )
                    """) {
                        HIGDropZone(
                            "Attach document",
                            urls: $singleURL,
                            message: "PDF only",
                            browseLabel: "Browse",
                            allowedContentTypes: [.pdf],
                            allowsMultipleSelection: false
                        )
                    }
                }
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle("Drop Zone")
    }
}

#if DEBUG
#Preview("ShowcaseDropZoneView") {
    ShowcasePreviewContainer {
        ShowcaseDropZoneView()
    }
}
#endif
