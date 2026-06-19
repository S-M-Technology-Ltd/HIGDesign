import HIGDesign
import SwiftUI

struct ShowcaseSearchFieldView: View {
    @State private var query = ""

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                ShowcaseMetadataView(component: .searchField)

                HIGSearchField("Library Search", text: $query, placeholder: "Search titles")
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle("Search Field")
    }
}

#if DEBUG
#Preview("ShowcaseSearchFieldView") {
    ShowcaseSearchFieldView()
}
#endif