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
private struct HIGNavigationBarPreviewView: View {
    var body: some View {
        NavigationStack {
            Text("Inbox content")
                .higNavigationBar("Inbox", displayMode: .large) {
                    Button("Filter", systemImage: "line.3.horizontal.decrease.circle") {}
                } trailing: {
                    Button("Compose", systemImage: "square.and.pencil") {}
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