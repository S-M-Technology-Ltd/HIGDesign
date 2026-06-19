import HIGDesign
import SwiftUI

private enum ShowcaseSortOrder: String, Hashable, Sendable {
    case recent
    case title
    case author
}

struct ShowcasePickerView: View {
    @State private var sort = ShowcaseSortOrder.recent

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                ShowcaseMetadataView(component: .picker)

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
            .higPadding(.screenEdge)
        }
        .navigationTitle("Picker")
    }
}

#if DEBUG
#Preview("ShowcasePickerView") {
    ShowcasePickerView()
}
#endif