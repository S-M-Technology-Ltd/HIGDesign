import SwiftUI

public extension View {
    /// Applies a HIG-aligned toolbar using native SwiftUI toolbar placements.
    func higToolbar<Content: ToolbarContent>(
        @ToolbarContentBuilder _ content: () -> Content
    ) -> some View {
        toolbar(content: content)
    }
}

/// A text toolbar action with native button semantics.
public struct HIGToolbarTextAction: View {
    private let title: String
    private let action: () -> Void

    public init(_ title: String, action: @escaping () -> Void) {
        self.title = title
        self.action = action
    }

    public var body: some View {
        Button(title, action: action)
    }
}

#if DEBUG
#Preview("HIGToolbarTextAction") {
    HIGToolbarTextAction("Add") {}
}
#endif