import HIGDesign
import SwiftUI

struct ShowcaseBadgeView: View {
    @Environment(\.higTheme) private var theme
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                ShowcaseMetadataView(component: .badge)

                VStack(spacing: theme.spacing.item) {
                    ShowcaseSampleView(code: "HIGBadge(\"New\")") {
                        HIGBadge("New")
                    }
                    ShowcaseSampleView(code: "HIGBadge(\"3\", style: .accent)") {
                        HIGBadge("3", style: .accent)
                    }
                    ShowcaseSampleView(code: "HIGBadge(\"OK\", style: .success)") {
                        HIGBadge("OK", style: .success)
                    }
                    ShowcaseSampleView(code: "HIGBadge(\"Soon\", style: .warning)") {
                        HIGBadge("Soon", style: .warning)
                    }
                    ShowcaseSampleView(code: "HIGBadge(\"!\", style: .destructive)") {
                        HIGBadge("!", style: .destructive)
                    }
                    ShowcaseSampleView(code: "HIGBadge(\"Info\", style: .info)") {
                        HIGBadge("Info", style: .info)
                    }
                }
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle("Badge")
    }
}

#if DEBUG
#Preview("ShowcaseBadgeView") {
    ShowcasePreviewContainer {
        ShowcaseBadgeView()
    }
}
#endif
