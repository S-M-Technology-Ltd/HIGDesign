import HIGDesign
import SwiftUI

struct ShowcaseLinkView: View {
    @Environment(\.higTheme) private var theme
    private let higURL = URL(string: "https://developer.apple.com/design/human-interface-guidelines/")!

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                ShowcaseMetadataView(component: .link)

                VStack(spacing: theme.spacing.screenEdge) {
                    ShowcaseSampleView(code: "HIGLink(\"Human Interface Guidelines\", url: higURL)") {
                        HIGLink("Human Interface Guidelines", url: higURL)
                    }
                    ShowcaseSampleView(code: "HIGLink(\"SwiftUI Documentation\", url: swiftUIURL)") {
                        HIGLink("SwiftUI Documentation", url: URL(string: "https://developer.apple.com/documentation/swiftui")!)
                    }
                }
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle("Link")
    }
}

#if DEBUG
#Preview("ShowcaseLinkView") {
    ShowcasePreviewContainer {
        ShowcaseLinkView()
    }
}
#endif