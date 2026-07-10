import HIGDesign
import SwiftUI

struct ShowcaseStatusIndicatorView: View {
    @Environment(\.higTheme) private var theme

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                ShowcaseMetadataView(component: .statusIndicator)

                VStack(spacing: theme.spacing.screenEdge) {
                    ShowcaseSampleView(code: """
                    HStack {
                        ForEach(HIGStatusKind.allCases, id: \\.self) { kind in
                            HIGStatusIndicator(kind)
                        }
                    }
                    """) {
                        HStack(spacing: theme.spacing.item) {
                            ForEach(HIGStatusKind.allCases, id: \.self) { kind in
                                VStack(spacing: theme.spacing.compactItem) {
                                    HIGStatusIndicator(kind)
                                    Text(kind.accessibilityLabel)
                                        .font(theme.typography.caption)
                                        .foregroundStyle(theme.colors.labelSecondary)
                                }
                            }
                        }
                    }

                    ShowcaseSampleView(code: """
                    HIGAvatar("AR", status: .online)
                    HIGAvatar("", systemImage: "person.fill", status: .busy)
                    """) {
                        HStack(spacing: theme.spacing.item) {
                            HIGAvatar("AR", status: .online)
                            HIGAvatar("JD", status: .away)
                            HIGAvatar("", systemImage: "person.fill", status: .busy)
                            HIGAvatar("ZZ", status: .offline)
                        }
                    }
                }
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle("Status Indicator")
    }
}

#if DEBUG
#Preview("ShowcaseStatusIndicatorView") {
    ShowcasePreviewContainer {
        ShowcaseStatusIndicatorView()
    }
}
#endif
