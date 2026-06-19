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
                .higNavigationBarTitle("Inbox", displayMode: .large)
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