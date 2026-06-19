import HIGThemesContract
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

    @Environment(\.higTheme) private var theme

    public init(_ title: String, action: @escaping () -> Void) {
        self.title = title
        self.action = action
    }

    public var body: some View {
        Button(title, action: action)
            .font(theme.toolbar.actionFont)
            .accessibilityLabel(title)
    }
}

/// An icon toolbar action with native button semantics.
public struct HIGToolbarIconAction: View {
    private let systemImage: String
    private let accessibilityLabel: String
    private let action: () -> Void

    @Environment(\.higTheme) private var theme

    public init(
        _ systemImage: String,
        accessibilityLabel: String,
        action: @escaping () -> Void
    ) {
        self.systemImage = systemImage
        self.accessibilityLabel = accessibilityLabel
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            Image(systemName: systemImage)
                .font(theme.toolbar.actionFont)
        }
        .accessibilityLabel(accessibilityLabel)
    }
}

#if DEBUG
#Preview("HIGToolbarTextAction") {
    HIGToolbarTextAction("Add") {}
}

#Preview("HIGToolbarIconAction") {
    HIGToolbarIconAction("plus", accessibilityLabel: "Add") {}
}
#endif