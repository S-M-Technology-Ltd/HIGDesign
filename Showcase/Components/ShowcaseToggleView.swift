import HIGDesign
import SwiftUI

struct ShowcaseToggleView: View {
    @Environment(\.higTheme) private var theme
    @State private var notificationsEnabled = true
    @State private var analyticsEnabled = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                ShowcaseMetadataView(component: .toggle)

                VStack(spacing: theme.spacing.item) {
                    ShowcaseSampleView(code: "HIGToggle(\"Notifications\", isOn: $notificationsEnabled)") {
                        HIGToggle("Notifications", isOn: $notificationsEnabled)
                    }
                    ShowcaseSampleView(code: "HIGToggle(\"Share analytics\", isOn: $analyticsEnabled)") {
                        HIGToggle("Share analytics", isOn: $analyticsEnabled)
                    }
                }
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle("Toggle")
    }
}

#if DEBUG
#Preview("ShowcaseToggleView") {
    ShowcasePreviewContainer {
        ShowcaseToggleView()
    }
}
#endif