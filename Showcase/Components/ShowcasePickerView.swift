import HIGDesign
import SwiftUI

private enum ShowcaseSortOrder: String, Hashable, Sendable {
    case recent
    case title
    case author
}

struct ShowcasePickerView: View {
    @Environment(\.higTheme) private var theme
    @State private var sort = ShowcaseSortOrder.recent

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                ShowcaseMetadataView(component: .picker)

                ShowcaseSampleView(code: """
                HIGPicker(
                    "Sort By",
                    selection: $sort,
                    options: [
                        HIGRadioOption(value: .recent, label: "Recently Added"),
                        HIGRadioOption(value: .title, label: "Title"),
                        HIGRadioOption(value: .author, label: "Author"),
                    ]
                )
                """) {
                    HIGPicker(
                        "Sort By",
                        selection: $sort,
                        options: [
                            HIGRadioOption(value: ShowcaseSortOrder.recent, label: "Recently Added"),
                            HIGRadioOption(value: ShowcaseSortOrder.title, label: "Title"),
                            HIGRadioOption(value: ShowcaseSortOrder.author, label: "Author"),
                        ]
                    )
                }
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle("Picker")
    }
}

#if DEBUG
#Preview("ShowcasePickerView") {
    ShowcasePreviewContainer {
        ShowcasePickerView()
    }
}
#endif