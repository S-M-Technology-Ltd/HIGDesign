import HIGThemesContract
import SwiftUI

/// A screen container that applies HIG-aligned toolbar items using native placements.
public struct HIGToolbar<Content: View, ToolbarItems: ToolbarContent>: View {
    private let content: Content
    private let toolbarItems: ToolbarItems

    public init(
        @ViewBuilder content: () -> Content,
        @ToolbarContentBuilder toolbar: () -> ToolbarItems
    ) {
        self.content = content()
        self.toolbarItems = toolbar()
    }

    public var body: some View {
        content.toolbar(content: { toolbarItems })
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

private struct HIGToolbarPreviewView: View {
    var body: some View {
        NavigationStack {
            HIGToolbar {
                Text("Document content")
                    .padding()
            } toolbar: {
                ToolbarItem(placement: .cancellationAction) {
                    HIGToolbarTextAction("Close") {}
                }
                ToolbarItem(placement: .primaryAction) {
                    HIGToolbarIconAction("plus", accessibilityLabel: "Add") {}
                }
            }
            .navigationTitle("Documents")
        }
    }
}

#Preview("HIGToolbarPreviewView") {
    HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        HIGToolbarPreviewView()
    }
}
#endif