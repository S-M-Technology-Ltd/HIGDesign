import HIGDesign
import SwiftUI

struct ShowcaseSearchFieldView: View {
    @Environment(\.higTheme) private var theme
    @State private var query = ""

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                ShowcaseMetadataView(component: .searchField)

                ShowcaseSampleView(code: "HIGSearchField(\"Library Search\", text: $query, placeholder: \"Search titles\")") {
                    HIGSearchField("Library Search", text: $query, placeholder: "Search titles")
                }
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle("Search Field")
    }
}

#if DEBUG
#Preview("ShowcaseSearchFieldView") {
    ShowcasePreviewContainer {
        ShowcaseSearchFieldView()
    }
}
#endif