#if !os(iOS) && !os(macOS) && !os(visionOS)
import HIGThemesContract
import SwiftUI

/// Rich HTML long-form text editor (WebKit platforms only).
public struct HIGLongTextEditor: View {
    private let label: String

    public init(
        _ label: String,
        html: Binding<String>,
        textAttributes: HIGLongTextAttributes,
        configuration: HIGLongTextEditorConfiguration = .init()
    ) {
        self.label = label
    }

    public var body: some View {
        ContentUnavailableView(
            label,
            systemImage: "text.alignleft",
            description: Text("HIGLongTextEditor is available on iOS, iPadOS, macOS, and visionOS.")
        )
    }
}

/// Tracks the current rich-text selection state for ``HIGLongTextEditor``.
@MainActor
public final class HIGLongTextAttributes: ObservableObject {
    @Published public private(set) var hasBold = false
    @Published public private(set) var hasItalic = false
    @Published public private(set) var hasUnderline = false
    @Published public private(set) var hasStrikethrough = false
    @Published public private(set) var hasSubscript = false
    @Published public private(set) var hasSuperscript = false
    @Published public private(set) var hasOrderedList = false
    @Published public private(set) var hasUnorderedList = false
    @Published public private(set) var hasLink = false
    @Published public private(set) var fontName = ""
    @Published public private(set) var fontSize: Int?
    @Published public private(set) var foregroundColor: Color?
    @Published public private(set) var backgroundColor: Color?

    public init() {}
}
#endif