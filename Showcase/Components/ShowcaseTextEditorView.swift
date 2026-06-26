import HIGDesign
import SwiftUI

struct ShowcaseTextEditorView: View {
    @Environment(\.higTheme) private var theme
    @State private var notes = "Add release notes here."
    @State private var feedback = ""

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                ShowcaseMetadataView(component: .textEditor)

                VStack(spacing: theme.spacing.screenEdge) {
                    ShowcaseSampleView(code: "HIGTextEditor(\"Notes\", text: $notes)") {
                        HIGTextEditor("Notes", text: $notes)
                    }
                    ShowcaseSampleView(code: "HIGTextEditor(\"Feedback\", text: $feedback)") {
                        HIGTextEditor("Feedback", text: $feedback)
                    }
                }
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle("Text Editor")
    }
}

#if DEBUG
#Preview("ShowcaseTextEditorView") {
    ShowcasePreviewContainer {
        ShowcaseTextEditorView()
    }
}
#endif