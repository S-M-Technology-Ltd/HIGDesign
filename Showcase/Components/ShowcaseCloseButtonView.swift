import HIGDesign
import SwiftUI

struct ShowcaseCloseButtonView: View {
    @Environment(\.higTheme) private var theme
    @State private var dismissCount = 0

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                ShowcaseMetadataView(component: .closeButton)

                VStack(spacing: theme.spacing.screenEdge) {
                    ShowcaseSampleView(code: """
                    HIGCloseButton {
                        // dismiss
                    }
                    """) {
                        HStack(spacing: theme.spacing.item) {
                            HIGCloseButton {
                                dismissCount += 1
                            }
                            Text("Dismissed \(dismissCount) times")
                                .font(theme.typography.caption)
                                .foregroundStyle(theme.colors.labelSecondary)
                        }
                    }
                }
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle("Close Button")
    }
}

#if DEBUG
#Preview("ShowcaseCloseButtonView") {
    ShowcasePreviewContainer {
        ShowcaseCloseButtonView()
    }
}
#endif
