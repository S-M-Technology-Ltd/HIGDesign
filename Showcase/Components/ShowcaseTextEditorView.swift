import HIGDesign
import SwiftUI

struct ShowcaseTextEditorView: View {
    @State private var notes = "Add release notes here."
    @State private var feedback = ""

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                ShowcaseMetadataView(component: .textEditor)

                VStack(spacing: 16) {
                    HIGTextEditor("Notes", text: $notes)
                    HIGTextEditor("Feedback", text: $feedback)
                }
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle("Text Editor")
    }
}

#if DEBUG
#Preview("ShowcaseTextEditorView") {
    ShowcaseTextEditorView()
}
#endif