import HIGDesign
import SwiftUI

struct ShowcaseInputGroupView: View {
    @Environment(\.higTheme) private var theme
    @State private var amount = "120"
    @State private var email = ""

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                ShowcaseMetadataView(component: .inputGroup)

                VStack(spacing: theme.spacing.screenEdge) {
                    ShowcaseSampleView(code: """
                    HIGInputGroup(label: "Amount") {
                        Text("$")
                    } field: {
                        TextField("0.00", text: $amount)
                            .textFieldStyle(.plain)
                    } trailing: {
                        Text("USD")
                    }
                    """) {
                        HIGInputGroup(label: "Amount") {
                            Text("$")
                                .font(theme.typography.body.weight(.semibold))
                        } field: {
                            TextField("0.00", text: $amount)
                                .textFieldStyle(.plain)
                        } trailing: {
                            Text("USD")
                                .font(theme.typography.caption)
                        }
                    }

                    ShowcaseSampleView(code: """
                    HIGInputGroup(
                        label: "Email",
                        message: "Enter a valid email.",
                        messageKind: .error,
                        showsErrorBorder: true
                    ) {
                        Image(systemName: "envelope")
                    } field: {
                        TextField("name@example.com", text: $email)
                            .textFieldStyle(.plain)
                    }
                    """) {
                        HIGInputGroup(
                            label: "Email",
                            message: "Enter a valid email address.",
                            messageKind: .error,
                            showsErrorBorder: true
                        ) {
                            Image(systemName: "envelope")
                        } field: {
                            TextField("name@example.com", text: $email)
                                .textFieldStyle(.plain)
                        }
                    }
                }
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle("Input Group")
    }
}

#if DEBUG
#Preview("ShowcaseInputGroupView") {
    ShowcasePreviewContainer {
        ShowcaseInputGroupView()
    }
}
#endif
