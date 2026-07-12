import HIGDesign
import SwiftUI

struct ShowcasePageCodeEditorView: View {
    @Environment(\.higTheme) private var theme

    private let sample = """
    struct ContentView: View {
        var body: some View {
            HIGThemeableView(theme: HIGSystemTheme()) {
                Text("Hello")
            }
        }
    }
    """

    var body: some View {
        ShowcaseRecipeLayoutView(
            component: .pageCodeEditor,
            code: """
            HIGPageHeader("Code editor")
            HIGCodeBlock(sample, language: "swift")
            """
        ) {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                HIGPageHeader(
                    "Code editor",
                    subtitle: "Monospaced code surface for admin docs and snippets."
                )
                HIGCodeBlock(sample, language: "swift")
                Text("For rich HTML editing, see Long Text Editor on supported platforms.")
                    .font(theme.typography.caption)
                    .foregroundStyle(theme.colors.labelSecondary)
            }
        }
    }
}

#if DEBUG
#Preview("ShowcasePageCodeEditorView") {
    ShowcasePreviewContainer { ShowcasePageCodeEditorView() }
}
#endif
