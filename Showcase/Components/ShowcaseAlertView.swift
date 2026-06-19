import HIGDesign
import SwiftUI

struct ShowcaseAlertView: View {
    @State private var isPresented = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                ShowcaseMetadataView(component: .alert)

                HIGAlertBanner(
                    "Backup restored",
                    message: "Your documents are available on this device again.",
                    style: .info
                )

                HIGAlertBanner(
                    "Storage almost full",
                    message: "Remove older items to keep syncing.",
                    style: .warning,
                    actionTitle: "Manage"
                )

                HIGAlert(
                    "Delete Item?",
                    message: "This action cannot be undone.",
                    primaryButtonTitle: "Delete",
                    primaryButtonRole: .destructive,
                    secondaryButtonTitle: "Cancel",
                    secondaryButtonRole: .cancel
                )

                HIGButton("Present Native Alert", role: .destructive) {
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