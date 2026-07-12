import HIGDesign
import SwiftUI

struct ShowcaseRatingView: View {
    @Environment(\.higTheme) private var theme
    @State private var editableRating = 3

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                ShowcaseMetadataView(component: .rating)

                VStack(spacing: theme.spacing.screenEdge) {
                    ShowcaseSampleView(code: """
                    HIGRating(value: 4, label: "4.0")
                    """) {
                        HIGRating(value: 4, label: "4.0")
                    }

                    ShowcaseSampleView(code: """
                    HIGRating(value: $rating, label: "Tap to rate")
                    """) {
                        VStack(alignment: .leading, spacing: theme.spacing.item) {
                            HIGRating(value: $editableRating, label: "Tap to rate")
                            Text("Current value: \(editableRating)")
                                .font(theme.typography.caption)
                                .foregroundStyle(theme.colors.labelSecondary)
                        }
                    }

                    ShowcaseSampleView(code: """
                    HIGRating(value: 0, maxValue: 5, label: "Unrated")
                    """) {
                        HIGRating(value: 0, maxValue: 5, label: "Unrated")
                    }
                }
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle("Rating")
    }
}

#if DEBUG
#Preview("ShowcaseRatingView") {
    ShowcasePreviewContainer {
        ShowcaseRatingView()
    }
}
#endif
