import HIGDesign
import SwiftUI

struct ShowcaseAlertView: View {
    @Environment(\.higTheme) private var theme
    @State private var isPresented = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                ShowcaseMetadataView(component: .alert)

                VStack(spacing: theme.spacing.item) {
                    ShowcaseSampleView(code: """
                    HIGAlertBanner(
                        "Backup restored",
                        message: "Your documents are available on this device again.",
                        style: .info
                    )
                    """) {
                        HIGAlertBanner(
                            "Backup restored",
                            message: "Your documents are available on this device again.",
                            style: .info
                        )
                    }

                    ShowcaseSampleView(code: """
                    HIGAlertBanner(
                        "Storage almost full",
                        message: "Remove older items to keep syncing.",
                        style: .warning,
                        actionTitle: "Manage"
                    )
                    """) {
                        HIGAlertBanner(
                            "Storage almost full",
                            message: "Remove older items to keep syncing.",
                            style: .warning,
                            actionTitle: "Manage"
                        )
                    }

                    ShowcaseSampleView(code: """
                    HIGAlert(
                        "Delete Item?",
                        message: "This action cannot be undone.",
                        primaryButtonTitle: "Delete",
                        primaryButtonRole: .destructive,
                        secondaryButtonTitle: "Cancel",
                        secondaryButtonRole: .cancel
                    )
                    """) {
                        HIGAlert(
                            "Delete Item?",
                            message: "This action cannot be undone.",
                            primaryButtonTitle: "Delete",
                            primaryButtonRole: .destructive,
                            secondaryButtonTitle: "Cancel",
                            secondaryButtonRole: .cancel
                        )
                    }

                    ShowcaseSampleView(code: """
                    HIGButton("Present Native Alert", role: .destructive) {
                        isPresented = true
                    }
                    .higAlert(
                        "Delete Item?",
                        isPresented: $isPresented,
                        message: "This action cannot be undone.",
                        primaryButtonTitle: "Delete",
                        primaryButtonRole: .destructive,
                        secondaryButtonTitle: "Cancel",
                        secondaryButtonRole: .cancel
                    )
                    """) {
                        HIGButton("Present Native Alert", role: .destructive) {
                            isPresented = true
                        }
                    }
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
    ShowcasePreviewContainer(includeNavigationStack: false) {
        NavigationStack {
            ShowcaseAlertView()
        }
    }
}
#endif