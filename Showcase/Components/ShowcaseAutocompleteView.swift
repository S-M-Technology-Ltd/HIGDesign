import HIGDesign
import SwiftUI

struct ShowcaseAutocompleteView: View {
    @Environment(\.higTheme) private var theme
    @State private var city = ""
    @State private var fruit = "Ap"

    private let cities = [
        "Cupertino", "San Francisco", "Seattle", "Austin",
        "London", "Tokyo", "Berlin", "Sydney", "Toronto",
    ]

    private let fruits = [
        "Apple", "Apricot", "Banana", "Blueberry", "Cherry",
        "Grape", "Mango", "Orange", "Peach", "Pear",
    ]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                ShowcaseMetadataView(component: .autocomplete)

                VStack(spacing: theme.spacing.screenEdge) {
                    ShowcaseSampleView(code: """
                    HIGAutocomplete(
                        "City",
                        text: $city,
                        suggestions: cities
                    )
                    """) {
                        HIGAutocomplete(
                            "City",
                            text: $city,
                            suggestions: cities
                        )
                    }

                    ShowcaseSampleView(code: """
                    HIGAutocomplete(
                        "Fruit",
                        text: $fruit,
                        suggestions: fruits,
                        placeholder: "Type a fruit"
                    )
                    """) {
                        HIGAutocomplete(
                            "Fruit",
                            text: $fruit,
                            suggestions: fruits,
                            placeholder: "Type a fruit"
                        )
                    }
                }
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle("Autocomplete")
    }
}

#if DEBUG
#Preview("ShowcaseAutocompleteView") {
    ShowcasePreviewContainer {
        ShowcaseAutocompleteView()
    }
}
#endif
