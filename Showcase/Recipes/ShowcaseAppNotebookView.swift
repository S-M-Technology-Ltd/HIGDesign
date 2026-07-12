import HIGDesign
import SwiftUI

struct ShowcaseAppNotebookView: View {
    @Environment(\.higTheme) private var theme
    @State private var note = "Meeting notes\n\n- Ship Wave 9 app recipes\n- Keep MapKit as composition only\n- Track pages in Wave 9.2"

    var body: some View {
        ShowcaseRecipeLayoutView(
            component: .appNotebook,
            code: """
            HIGPageHeader("Notebook")
            HIGListGroup { /* note titles */ }
            HIGTextEditor(text: $note)
            """
        ) {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                HIGPageHeader(
                    "Notebook",
                    subtitle: "Note list plus multi-line editor for admin jotting."
                )
                HIGListGroup(header: "Notes") {
                    HIGListGroupRow("Meeting notes", subtitle: "Today", systemImage: "note.text", isSelected: true) {}
                    HIGDivider()
                    HIGListGroupRow("Release checklist", subtitle: "Yesterday", systemImage: "note.text") {}
                    HIGDivider()
                    HIGListGroupRow("Ideas", subtitle: "Last week", systemImage: "note.text") {}
                }
                HIGTextEditor("Body", text: $note)
            }
        }
    }
}

#if DEBUG
#Preview("ShowcaseAppNotebookView") {
    ShowcasePreviewContainer {
        ShowcaseAppNotebookView()
    }
}
#endif
