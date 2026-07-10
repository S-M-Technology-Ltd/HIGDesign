import HIGDesign
import SwiftUI

struct ShowcaseModalView: View {
    @Environment(\.higTheme) private var theme
    @State private var isPresented = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                ShowcaseMetadataView(component: .modal)

                VStack(spacing: theme.spacing.screenEdge) {
                    ShowcaseSampleView(code: """
                    HIGModal(
                        title: "Edit project",
                        message: "Update display name.",
                        onDismiss: { /* close */ }
                    ) {
                        Text("Body")
                    } footer: {
                        HIGButton("Save", role: .primary) {}
                    }
                    """) {
                        HIGModal(
                            title: "Edit project",
                            message: "Update the display name and owners.",
                            onDismiss: {}
                        ) {
                            Text("Form fields go here.")
                                .font(theme.typography.body)
                                .foregroundStyle(theme.colors.labelSecondary)
                        } footer: {
                            HIGButton("Save", role: .primary) {}
                        }
                    }

                    ShowcaseSampleView(code: """
                    .sheet(isPresented: $isPresented) {
                        HIGModal(title: "Sheet", onDismiss: {
                            isPresented = false
                        }) {
                            Text("Native sheet + HIGModal chrome")
                        }
                        .padding()
                    }
                    """) {
                        VStack(alignment: .leading, spacing: theme.spacing.item) {
                            HIGButton("Present sheet", role: .secondary) {
                                isPresented = true
                            }
                        }
                        .sheet(isPresented: $isPresented) {
                            HIGModal(
                                title: "Sheet",
                                message: "Native sheet presentation with HIG modal chrome.",
                                onDismiss: { isPresented = false }
                            ) {
                                Text("Sheet body content.")
                                    .font(theme.typography.body)
                                    .foregroundStyle(theme.colors.labelSecondary)
                            } footer: {
                                HIGButton("Done", role: .primary) {
                                    isPresented = false
                                }
                            }
                            .padding(theme.spacing.screenEdge)
                            #if os(macOS)
                            .frame(minWidth: 360)
                            #endif
                        }
                    }
                }
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle("Modal")
    }
}

#if DEBUG
#Preview("ShowcaseModalView") {
    ShowcasePreviewContainer {
        ShowcaseModalView()
    }
}
#endif
