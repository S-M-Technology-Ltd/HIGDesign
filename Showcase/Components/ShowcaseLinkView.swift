import HIGDesign
import SwiftUI

struct ShowcaseLinkView: View {
    private let higURL = URL(string: "https://developer.apple.com/design/human-interface-guidelines/")!

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                ShowcaseMetadataView(component: .link)

                VStack(alignment: .leading, spacing: 16) {
                    HIGLink("Human Interface Guidelines", url: higURL)
                    HIGLink("SwiftUI Documentation", url: URL(string: "https://developer.apple.com/documentation/swiftui")!)
                }
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle("Link")
    }
}

#if DEBUG
#Preview("ShowcaseLinkView") {
    ShowcaseLinkView()
}
#endif