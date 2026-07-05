import HIGDesign
import SwiftUI

struct ShowcaseLongTextEditorView: View {
    @Environment(\.higTheme) private var theme
    @State private var html = "<p>Write a long-form note with <strong>rich text</strong> formatting.</p>"
    @StateObject private var textAttributes = HIGLongTextAttributes()

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                ShowcaseMetadataView(component: .longTextEditor)

                ShowcaseSampleView(code: """
                HIGLongTextEditor("Article", html: $html, textAttributes: textAttributes)
                """) {
                    HIGLongTextEditor(
                        "Article",
                        html: $html,
                        textAttributes: textAttributes,
                        configuration: .init(toolbarPlacement: .inline)
                    )
                }

                Text("HTML Output")
                    .font(theme.typography.caption)
                    .foregroundStyle(theme.colors.labelSecondary)

                Text(html.isEmpty ? " " : html)
                    .font(theme.typography.caption)
                    .foregroundStyle(theme.colors.labelSecondary)
                    .textSelection(.enabled)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(theme.spacing.compactItem)
                    .background(theme.colors.backgroundSecondary)
                    .clipShape(RoundedRectangle(cornerRadius: theme.longTextEditor.cornerRadius, style: .continuous))
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle("Long Text Editor")
    }
}

#if DEBUG
#Preview("ShowcaseLongTextEditorView") {
    ShowcasePreviewContainer {
        ShowcaseLongTextEditorView()
    }
}
#endif