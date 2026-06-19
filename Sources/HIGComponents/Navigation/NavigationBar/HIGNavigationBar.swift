import HIGThemesContract
import SwiftUI

/// Controls how a HIG navigation title is displayed.
public enum HIGNavigationBarDisplayMode: Sendable {
    case automatic
    case inline
    case large
}

/// A composable navigation bar that applies a HIG-aligned title and toolbar actions.
public struct HIGNavigationBar<Content: View, Leading: View, Trailing: View>: View {
    private let title: String
    private let displayMode: HIGNavigationBarDisplayMode
    private let content: Content
    private let leading: Leading
    private let trailing: Trailing

    public init(
        _ title: String,
        displayMode: HIGNavigationBarDisplayMode = .automatic,
        @ViewBuilder content: () -> Content,
        @ViewBuilder leading: () -> Leading,
        @ViewBuilder trailing: () -> Trailing
    ) {
        self.title = title
        self.displayMode = displayMode
        self.content = content()
        self.leading = leading()
        self.trailing = trailing()
    }

    public var body: some View {
        content
            .modifier(HIGNavigationBarTitleModifier(title: title, displayMode: displayMode))
            .toolbar {
                #if os(macOS)
                ToolbarItemGroup(placement: .navigation) {
                    leading
                }
                ToolbarItemGroup(placement: .primaryAction) {
                    trailing
                }
                #else
                ToolbarItem(placement: .topBarLeading) {
                    leading
                }
                ToolbarItem(placement: .topBarTrailing) {
                    trailing
                }
                #endif
            }
    }
}

public extension HIGNavigationBar where Leading == EmptyView {
    /// Creates a navigation bar with trailing actions only.
    init(
        _ title: String,
        displayMode: HIGNavigationBarDisplayMode = .automatic,
        @ViewBuilder content: () -> Content,
        @ViewBuilder trailing: () -> Trailing
    ) {
        self.init(
            title,
            displayMode: displayMode,
            content: content,
            leading: { EmptyView() },
            trailing: trailing
        )
    }
}

/// Applies a HIG-aligned navigation title and display mode.
public struct HIGNavigationBarTitleModifier: ViewModifier {
    private let title: String
    private let displayMode: HIGNavigationBarDisplayMode

    public init(title: String, displayMode: HIGNavigationBarDisplayMode) {
        self.title = title
        self.displayMode = displayMode
    }

    public func body(content: Content) -> some View {
        content
            .navigationTitle(title)
            #if os(iOS) || os(visionOS)
            .navigationBarTitleDisplayMode(swiftUIMode)
            #endif
    }

    #if os(iOS) || os(visionOS)
    private var swiftUIMode: NavigationBarItem.TitleDisplayMode {
        switch displayMode {
        case .automatic:
            .automatic
        case .inline:
            .inline
        case .large:
            .large
        }
    }
    #endif
}

/// A text navigation bar action with native button semantics.
public struct HIGNavigationBarTextAction: View {
    private let title: String
    private let action: () -> Void

    @Environment(\.higTheme) private var theme

    public init(_ title: String, action: @escaping () -> Void) {
        self.title = title
        self.action = action
    }

    public var body: some View {
        Button(title, action: action)
            .font(theme.navigationBar.actionFont)
            .accessibilityLabel(title)
    }
}

/// An icon navigation bar action with native button semantics.
public struct HIGNavigationBarIconAction: View {
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
                .font(theme.navigationBar.actionFont)
        }
        .accessibilityLabel(accessibilityLabel)
    }
}

#if DEBUG
#Preview("HIGNavigationBarTextAction") {
    HIGNavigationBarTextAction("Filter") {}
}

#Preview("HIGNavigationBarIconAction") {
    HIGNavigationBarIconAction("square.and.pencil", accessibilityLabel: "Compose") {}
}

private struct HIGNavigationBarPreviewView: View {
    var body: some View {
        NavigationStack {
            HIGNavigationBar("Inbox", displayMode: .large) {
                Text("Inbox content")
                    .padding()
            } leading: {
                HIGNavigationBarIconAction(
                    "line.3.horizontal.decrease.circle",
                    accessibilityLabel: "Filter"
                ) {}
            } trailing: {
                HIGNavigationBarIconAction(
                    "square.and.pencil",
                    accessibilityLabel: "Compose"
                ) {}
            }
        }
    }
}

#Preview("HIGNavigationBarPreviewView") {
    HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        HIGNavigationBarPreviewView()
    }
}
#endif