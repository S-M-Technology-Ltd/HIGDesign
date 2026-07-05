#if canImport(WebKit) && (os(iOS) || os(macOS) || os(visionOS))
import HIGThemesContract
import HIGTokensComponent
import SwiftUI

struct LongTextEditorToolbarView: View {
    @ObservedObject var textAttributes: HIGLongTextAttributes

    @Environment(\.higTheme) private var theme

    var body: some View {
        let tokens = theme.longTextEditor

        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: tokens.toolbarActionSpacing) {
                toolbarButton("Bold", systemImage: "bold", isActive: textAttributes.hasBold) {
                    textAttributes.bold()
                }
                toolbarButton("Italic", systemImage: "italic", isActive: textAttributes.hasItalic) {
                    textAttributes.italic()
                }
                toolbarButton("Underline", systemImage: "underline", isActive: textAttributes.hasUnderline) {
                    textAttributes.underline()
                }
                toolbarButton("Strikethrough", systemImage: "strikethrough", isActive: textAttributes.hasStrikethrough) {
                    textAttributes.strikethrough()
                }
                toolbarButton("Bullet List", systemImage: "list.bullet", isActive: textAttributes.hasUnorderedList) {
                    textAttributes.unorderedList()
                }
                toolbarButton("Numbered List", systemImage: "list.number", isActive: textAttributes.hasOrderedList) {
                    textAttributes.orderedList()
                }
                toolbarButton("Undo", systemImage: "arrow.uturn.backward", isActive: false) {
                    textAttributes.undo()
                }
                toolbarButton("Redo", systemImage: "arrow.uturn.forward", isActive: false) {
                    textAttributes.redo()
                }
            }
            .padding(.horizontal, theme.spacing.screenEdge)
        }
        .frame(height: tokens.toolbarHeight)
        .background(theme.colors.backgroundSecondary)
    }

    private func toolbarButton(
        _ label: String,
        systemImage: String,
        isActive: Bool,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            Image(systemName: systemImage)
                .font(theme.typography.body)
                .foregroundStyle(isActive ? theme.colors.accent : theme.colors.labelPrimary)
                .frame(minWidth: theme.longTextEditor.toolbarHeight, minHeight: theme.longTextEditor.toolbarHeight)
        }
        .buttonStyle(.plain)
        .accessibilityLabel(label)
    }
}
#endif