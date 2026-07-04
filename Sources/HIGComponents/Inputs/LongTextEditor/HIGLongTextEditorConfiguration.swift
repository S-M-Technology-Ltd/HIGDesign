import Foundation

/// Formatting toolbar visibility for ``HIGLongTextEditor``.
public enum HIGLongTextEditorToolbarPlacement: String, Sendable, Equatable {
    case none
    case accessory
    case inline
}

/// Configuration for ``HIGLongTextEditor``.
public struct HIGLongTextEditorConfiguration: Equatable, Sendable {
    public var spellCheckEnabled: Bool
    public var autoCorrectEnabled: Bool
    public var isScrollable: Bool
    public var toolbarPlacement: HIGLongTextEditorToolbarPlacement

    public init(
        spellCheckEnabled: Bool = true,
        autoCorrectEnabled: Bool = true,
        isScrollable: Bool = false,
        toolbarPlacement: HIGLongTextEditorToolbarPlacement = .inline
    ) {
        self.spellCheckEnabled = spellCheckEnabled
        self.autoCorrectEnabled = autoCorrectEnabled
        self.isScrollable = isScrollable
        self.toolbarPlacement = toolbarPlacement
    }
}