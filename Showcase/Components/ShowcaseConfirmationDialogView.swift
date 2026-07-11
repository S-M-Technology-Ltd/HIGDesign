import HIGDesign
import SwiftUI

struct ShowcaseConfirmationDialogView: View {
    @Environment(\.higTheme) private var theme
    @State private var isPresented = false
    @State private var lastAction = "None"

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                ShowcaseMetadataView(component: .confirmationDialog)

                VStack(spacing: theme.spacing.screenEdge) {
                    ShowcaseSampleView(code: """
                    HIGButton("Delete item", role: .destructive) {
                        isPresented = true
                    }
                    .higConfirmationDialog(
                        "Delete this item?",
                        isPresented: $isPresented,
                        message: "This cannot be undone.",
                        primaryButtonTitle: "Delete",
                        primaryButtonRole: .destructive,
                        secondaryButtonTitle: "Cancel",
                        secondaryButtonRole: .cancel
                    )
                    """) {
                        VStack(alignment: .leading, spacing: theme.spacing.item) {
                            HIGButton("Delete item", role: .destructive) {
                                isPresented = true
                            }
                            Text("Last action: \(lastAction)")
                                .font(theme.typography.caption)
                                .foregroundStyle(theme.colors.labelSecondary)
                        }
                        .higConfirmationDialog(
                            "Delete this item?",
                            isPresented: $isPresented,
                            message: "This cannot be undone.",
                            primaryButtonTitle: "Delete",
                            primaryButtonRole: .destructive,
                            primaryAction: { lastAction = "Deleted" },
                            secondaryButtonTitle: "Cancel",
                            secondaryButtonRole: .cancel,
                            secondaryAction: { lastAction = "Cancelled" }
                        )
                    }
                }
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle("Confirmation Dialog")
    }
}

#if DEBUG
#Preview("ShowcaseConfirmationDialogView") {
    ShowcasePreviewContainer {
        ShowcaseConfirmationDialogView()
    }
}
#endif
