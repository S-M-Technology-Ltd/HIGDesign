import HIGComponents
import SwiftUI

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
        HIGNavigationBar(
            title,
            displayMode: displayMode,
            content: { self },
            leading: leading,
            trailing: trailing
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