import HIGFoundations
import SwiftUI

public struct HIGThemeableView<Content: View>: View {
    private let theme: any HIGTheme
    private let content: () -> Content

    public init(theme: any HIGTheme, @ViewBuilder content: @escaping () -> Content) {
        self.theme = theme
        self.content = content
    }

    public var body: some View {
        HIGThemeRegistrationBridge(theme: theme) {
            content()
                .environment(\.higThemeStorage, theme)
                .modifier(HIGSizeClassModifier())
        }
    }
}

private struct HIGSizeClassModifier: ViewModifier {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @Environment(\.verticalSizeClass) private var verticalSizeClass

    func body(content: Content) -> some View {
        content
            .environment(
                \.higHorizontalSizeClass,
                mapSizeClass(horizontalSizeClass)
            )
            .environment(
                \.higVerticalSizeClass,
                mapSizeClass(verticalSizeClass)
            )
    }

    private func mapSizeClass(_ sizeClass: UserInterfaceSizeClass?) -> HIGUserInterfaceSizeClass {
        sizeClass == .compact ? .compact : .regular
    }
}