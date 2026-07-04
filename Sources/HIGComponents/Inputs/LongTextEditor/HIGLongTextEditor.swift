#if canImport(WebKit) && (os(iOS) || os(macOS) || os(visionOS))
import HIGPlatform
import HIGThemesContract
import HIGTokensComponent
import SwiftUI

/// Rich HTML long-form text editor inspired by Infomaniak ``swift-rich-html-editor``.
public struct HIGLongTextEditor: View {
    private let label: String
    @Binding private var html: String
    @ObservedObject private var textAttributes: HIGLongTextAttributes
    private let configuration: HIGLongTextEditorConfiguration

    @Environment(\.higTheme) private var theme
    @Environment(\.isEnabled) private var isEnabled

    public init(
        _ label: String,
        html: Binding<String>,
        textAttributes: HIGLongTextAttributes,
        configuration: HIGLongTextEditorConfiguration = .init()
    ) {
        self.label = label
        _html = html
        _textAttributes = ObservedObject(wrappedValue: textAttributes)
        self.configuration = configuration
    }

    public var body: some View {
        let tokens = theme.longTextEditor
        let capabilities = HIGPlatformCapabilities.current
        let minHeight = max(tokens.minHeight, capabilities.minimumTouchTarget)
        let editorCSS = LongTextEditorThemeSupport.editorCSS(theme: theme, tokens: tokens)

        VStack(alignment: .leading, spacing: theme.spacing.compactItem) {
            Text(label)
                .font(theme.typography.caption)
                .foregroundStyle(theme.colors.labelSecondary)

            if configuration.toolbarPlacement == .inline {
                LongTextEditorToolbarView(textAttributes: textAttributes)
            }

            styledRepresentable(
                tokens: tokens,
                minHeight: minHeight,
                editorCSS: editorCSS
            )
            .opacity(isEnabled ? theme.opacity.full : theme.opacity.disabled)
        }
        .accessibilityElement(children: .contain)
        .accessibilityLabel(label)
    }

    private func styledRepresentable(
        tokens: any HIGLongTextEditorTokens,
        minHeight: CGFloat,
        editorCSS: String
    ) -> some View {
        let editor = HIGLongTextEditorRepresentable(
            html: $html,
            textAttributes: textAttributes,
            spellCheckEnabled: configuration.spellCheckEnabled,
            autoCorrectEnabled: configuration.autoCorrectEnabled
        )
        .frame(minHeight: minHeight)
        .clipShape(RoundedRectangle(cornerRadius: tokens.cornerRadius, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: tokens.cornerRadius, style: .continuous)
                .strokeBorder(theme.colors.separator, lineWidth: tokens.borderWidth)
        }
        .editorCSS(editorCSS)

        #if canImport(UIKit)
        return AnyView(editor.editorScrollable(configuration.isScrollable))
        #else
        return AnyView(editor)
        #endif
    }
}

#if DEBUG
#Preview("HIGLongTextEditor") {
    @Previewable @State var html = "<p>Write a long-form note with <strong>rich text</strong>.</p>"
    @Previewable @StateObject var textAttributes = HIGLongTextAttributes()

    HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        HIGLongTextEditor("Article", html: $html, textAttributes: textAttributes)
            .padding()
    }
}
#endif
#endif