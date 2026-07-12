import HIGDesign
import SwiftUI

struct ShowcasePageErrorsView: View {
    @Environment(\.higTheme) private var theme
    @State private var code = "404"

    var body: some View {
        ShowcaseRecipeLayoutView(
            component: .pageErrors,
            code: """
            HIGEmptyState(
                "404",
                message: "Page not found",
                systemImage: "exclamationmark.triangle"
            ) { HIGButton("Go home") {} }
            """
        ) {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                HIGPageHeader(
                    "Error pages",
                    subtitle: "Covers error-400 through error-503 with one empty-state pattern."
                )
                HIGSegmentedControl(
                    "Status",
                    selection: $code,
                    options: [
                        HIGRadioOption(value: "400", label: "400"),
                        HIGRadioOption(value: "403", label: "403"),
                        HIGRadioOption(value: "404", label: "404"),
                        HIGRadioOption(value: "500", label: "500"),
                        HIGRadioOption(value: "503", label: "503"),
                    ]
                )
                HIGEmptyState(
                    code,
                    message: message(for: code),
                    systemImage: "exclamationmark.triangle"
                ) {
                    HIGButton("Go home", role: .primary) {}
                }
                .background(theme.colors.backgroundSecondary)
                .clipShape(RoundedRectangle(cornerRadius: theme.card.cornerRadius, style: .continuous))
            }
        }
    }

    private func message(for code: String) -> String {
        switch code {
        case "400": "Bad request — check the form and try again."
        case "403": "You do not have permission to view this resource."
        case "500": "Something went wrong on our side."
        case "503": "Service temporarily unavailable. Try again soon."
        default: "We could not find that page."
        }
    }
}

#if DEBUG
#Preview("ShowcasePageErrorsView") {
    ShowcasePreviewContainer { ShowcasePageErrorsView() }
}
#endif
