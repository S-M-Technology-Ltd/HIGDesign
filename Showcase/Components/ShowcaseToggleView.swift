import HIGDesign
import SwiftUI

struct ShowcaseToggleView: View {
    @State private var notificationsEnabled = true
    @State private var analyticsEnabled = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                ShowcaseMetadataView(component: .toggle)

                VStack(spacing: 12) {
                    HIGToggle("Notifications", isOn: $notificationsEnabled)
                    HIGToggle("Share analytics", isOn: $analyticsEnabled)
                }
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle("Toggle")
    }
}

#if DEBUG
#Preview("ShowcaseToggleView") {
    ShowcaseToggleView()
}
#endif