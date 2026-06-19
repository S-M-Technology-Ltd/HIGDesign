import HIGThemesContract
import SwiftUI

/// Controls how a HIG navigation title is displayed.
public enum HIGNavigationBarDisplayMode: Sendable {
    case automatic
    case inline
    case large
}

public extension View {
    /// Applies a HIG-aligned navigation title and display mode.
    func higNavigationBarTitle(
        _ title: String,
        displayMode: HIGNavigationBarDisplayMode = .automatic
    ) -> some View {
        modifier(HIGNavigationBarTitleModifier(title: title, displayMode: displayMode))
    }

    /// Applies a composable navigation bar with optional leading and trailing actions.
    func higNavigationBar<Leading: View, Trailing: View>(
        _ title: String,
        displayMode: HIGNavigationBarDisplayMode = .automatic,
        @ViewBuilder leading: () -> Leading,
        @ViewBuilder trailing: () -> Trailing
    ) -> some View {
        modifier(
            HIGNavigationBarModifier(
                title: title,
                displayMode: displayMode,
                leading: leading(),
                trailing: trailing()
            )
        )
    }

    /// Applies a composable navigation bar with trailing actions.
    func higNavigationBar<Trailing: View>(
        _ title: String,
        displayMode: HIGNavigationBarDisplayMode = .automatic,
        @ViewBuilder trailing: () -> Trailing
    ) -> some View {
        higNavigationBar(title, displayMode: displayMode, leading: { EmptyView() }, trailing: trailing)
    }
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

private struct HIGNavigationBarModifier<Leading: View, Trailing: View>: ViewModifier {
    let title: String
    let displayMode: HIGNavigationBarDisplayMode
    let leading: Leading
    let trailing: Trailing

    func body(content: Content) -> some View {
        content
            .higNavigationBarTitle(title, displayMode: displayMode)
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

private struct HIGNavigationBarTitleModifier: ViewModifier {
    let title: String
    let displayMode: HIGNavigationBarDisplayMode

    @Environment(\.higTheme) private var theme

    func body(content: Content) -> some View {
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
            Text("Inbox content")
                .higNavigationBar("Inbox", displayMode: .large) {
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
                .padding()
        }
    }
}

#Preview("HIGNavigationBarPreviewView") {
    HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        HIGNavigationBarPreviewView()
    }
}
#endif