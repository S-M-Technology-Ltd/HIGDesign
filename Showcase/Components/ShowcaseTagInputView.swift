import HIGDesign
import SwiftUI

struct ShowcaseTagInputView: View {
    @Environment(\.higTheme) private var theme
    @State private var topics = ["SwiftUI", "Design"]
    @State private var limited = ["iOS"]

    private let topicSuggestions = [
        "SwiftUI", "Design", "Accessibility", "Tokens", "Admin", "Forms", "Charts",
    ]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                ShowcaseMetadataView(component: .tagInput)

                VStack(spacing: theme.spacing.screenEdge) {
                    ShowcaseSampleView(code: """
                    HIGTagInput(
                        "Topics",
                        tags: $topics,
                        suggestions: topicSuggestions
                    )
                    """) {
                        HIGTagInput(
                            "Topics",
                            tags: $topics,
                            suggestions: topicSuggestions
                        )
                    }

                    ShowcaseSampleView(code: """
                    HIGTagInput(
                        "Platforms (max 3)",
                        tags: $limited,
                        maxTags: 3
                    )
                    """) {
                        HIGTagInput(
                            "Platforms (max 3)",
                            tags: $limited,
                            placeholder: "Add platform…",
                            maxTags: 3
                        )
                    }
                }
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle("Tag Input")
    }
}

#if DEBUG
#Preview("ShowcaseTagInputView") {
    ShowcasePreviewContainer {
        ShowcaseTagInputView()
    }
}
#endif
