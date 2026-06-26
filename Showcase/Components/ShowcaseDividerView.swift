import HIGDesign
import SwiftUI

struct ShowcaseDividerView: View {
    @Environment(\.higTheme) private var theme
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                ShowcaseMetadataView(component: .divider)

                ShowcaseSampleView(code: "HIGDivider()") {
                    VStack(alignment: .leading, spacing: theme.spacing.item) {
                        Text("Account")
                            .font(theme.typography.headline)
                        Text("Manage profile and security settings.")
                            .foregroundStyle(theme.colors.labelSecondary)
                        HIGDivider()
                        Text("Preferences")
                            .font(theme.typography.headline)
                        Text("Theme, accessibility, and notification defaults.")
                            .foregroundStyle(theme.colors.labelSecondary)
                    }
                }
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle("Divider")
    }
}

#if DEBUG
#Preview("ShowcaseDividerView") {
    ShowcasePreviewContainer {
        ShowcaseDividerView()
    }
}
#endif