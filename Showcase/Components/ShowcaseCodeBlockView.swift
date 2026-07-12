import HIGDesign
import SwiftUI

struct ShowcaseCodeBlockView: View {
    @Environment(\.higTheme) private var theme

    private let sample = """
    import HIGDesign

    struct ContentView: View {
        var body: some View {
            HIGThemeableView(theme: HIGSystemTheme()) {
                HIGButton("Save") {}
            }
        }
    }
    """

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                ShowcaseMetadataView(component: .codeBlock)

                VStack(spacing: theme.spacing.screenEdge) {
                    ShowcaseSampleView(code: """
                    HIGCodeBlock(sample, language: "swift")
                    """) {
                        HIGCodeBlock(sample, language: "swift")
                    }

                    ShowcaseSampleView(code: """
                    HIGCodeBlock("npm install higdesign", language: "bash", showsShareButton: false)
                    """) {
                        HIGCodeBlock(
                            "npm install higdesign",
                            language: "bash",
                            showsShareButton: false
                        )
                    }
                }
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle("Code Block")
    }
}

#if DEBUG
#Preview("ShowcaseCodeBlockView") {
    ShowcasePreviewContainer {
        ShowcaseCodeBlockView()
    }
}
#endif
