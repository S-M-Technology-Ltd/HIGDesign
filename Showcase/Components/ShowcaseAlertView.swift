import HIGDesign
import SwiftUI

struct ShowcaseAlertView: View {
    @State private var isPresented = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                ShowcaseMetadataView(component: .alert)

                HIGButton("Delete Item", role: .destructive) {
                    isPresented = true
                }
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle("Alert")
        .higAlert(
            "Delete Item?",
            isPresented: $isPresented,
            message: "This action cannot be undone.",
            primaryButtonTitle: "Delete",
            primaryButtonRole: .destructive,
            secondaryButtonTitle: "Cancel",
            secondaryButtonRole: .cancel
        )
    }
}

#if DEBUG
#Preview("ShowcaseAlertView") {
    NavigationStack {
        ShowcaseAlertView()
    }
}
#endif