//  Portions adapted from Infomaniak swift-rich-html-editor (Apache 2.0).

import SwiftUI

#if canImport(UIKit)
public typealias HIGLongTextPlatformViewRepresentable = UIViewRepresentable
#elseif canImport(AppKit)
public typealias HIGLongTextPlatformViewRepresentable = NSViewRepresentable
#endif

#if canImport(WebKit) && (os(iOS) || os(macOS) || os(visionOS))
struct HIGLongTextEditorRepresentable: HIGLongTextPlatformViewRepresentable {
    #if canImport(UIKit)
    @Environment(\.editorScrollable) private var isEditorScrollable
    #endif
    #if canImport(UIKit) && !os(visionOS)
    @Environment(\.editorInputAccessoryView) private var editorInputAccessoryView
    #endif

    @Environment(\.editorCSS) var editorCSS
    @Environment(\.onEditorLoaded) var onEditorLoaded
    @Environment(\.onCaretPositionChange) var onCaretPositionChange
    @Environment(\.onJavaScriptFunctionFail) var onJavaScriptFunctionFail
    @Environment(\.introspectEditor) var introspectEditor
    @Environment(\.handleLinkOpening) var handleLinkOpening

    @Binding var html: String
    var selection: Binding<String>?

    @ObservedObject var textAttributes: HIGLongTextAttributes
    let spellCheckEnabled: Bool
    let autoCorrectEnabled: Bool

    init(
        html: Binding<String>,
        selection: Binding<String>? = nil,
        textAttributes: HIGLongTextAttributes,
        spellCheckEnabled: Bool = true,
        autoCorrectEnabled: Bool = true
    ) {
        _html = html
        self.selection = selection
        _textAttributes = ObservedObject(wrappedValue: textAttributes)
        self.spellCheckEnabled = spellCheckEnabled
        self.autoCorrectEnabled = autoCorrectEnabled
    }

    private func createPlatformView(context: Context) -> HIGLongTextEditorView {
        let editorView = HIGLongTextEditorView()
        editorView.delegate = context.coordinator
        editorView.html = html
        editorView.spellCheckEnabled = spellCheckEnabled
        editorView.autoCorrectEnabled = autoCorrectEnabled

        if let css = editorCSS {
            editorView.injectAdditionalCSS(css)
        }
        introspectEditor?(editorView)

        textAttributes.editor = editorView

        return editorView
    }

    private func updatePlatformView(_ editorView: HIGLongTextEditorView) {
        if editorView.html != html {
            editorView.html = html
        }

        if editorView.spellCheckEnabled != spellCheckEnabled {
            editorView.spellCheckEnabled = spellCheckEnabled
        }

        if editorView.autoCorrectEnabled != autoCorrectEnabled {
            editorView.autoCorrectEnabled = autoCorrectEnabled
        }

        #if canImport(UIKit)
        if editorView.isScrollEnabled != isEditorScrollable {
            editorView.isScrollEnabled = isEditorScrollable
        }
        #endif
        #if canImport(UIKit) && !os(visionOS)
        if editorView.inputAccessoryView != editorInputAccessoryView {
            editorView.inputAccessoryView = editorInputAccessoryView
        }
        #endif
    }

    @available(iOS 16.0, macOS 13.0, *)
    private func sizeThatFits(_ proposal: ProposedViewSize, editor: HIGLongTextEditorView, context: Context) -> CGSize? {
        proposal.replacingUnspecifiedDimensions(by: editor.intrinsicContentSize)
    }

    func makeCoordinator() -> HIGLongTextEditorCoordinator {
        HIGLongTextEditorCoordinator(parent: self)
    }

    func makeUIView(context: Context) -> HIGLongTextEditorView {
        createPlatformView(context: context)
    }

    func updateUIView(_ editorView: HIGLongTextEditorView, context: Context) {
        updatePlatformView(editorView)
    }

    @available(iOS 16.0, macOS 13.0, *)
    func sizeThatFits(_ proposal: ProposedViewSize, uiView: HIGLongTextEditorView, context: Context) -> CGSize? {
        sizeThatFits(proposal, editor: uiView, context: context)
    }

    func makeNSView(context: Context) -> HIGLongTextEditorView {
        createPlatformView(context: context)
    }

    func updateNSView(_ editorView: HIGLongTextEditorView, context: Context) {
        updatePlatformView(editorView)
    }

    @available(iOS 16.0, macOS 13.0, visionOS 1.0, *)
    func sizeThatFits(_ proposal: ProposedViewSize, nsView: HIGLongTextEditorView, context: Context) -> CGSize? {
        sizeThatFits(proposal, editor: nsView, context: context)
    }
}
#endif