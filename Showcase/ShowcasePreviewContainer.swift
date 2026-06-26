import HIGDesign
import SwiftUI

#if DEBUG
/// Wraps showcase Xcode previews in a deterministic `HIGThemeableView` container.
struct ShowcasePreviewContainer<Content: View>: View {
    var includeNavigationStack = true
    var theme: any HIGTheme = HIGSystemTheme()
    @ViewBuilder var content: () -> Content

    var body: some View {
        HIGThemeableView(theme: theme) {
            if includeNavigationStack {
                NavigationStack {
                    content()
                }
            } else {
                content()
            }
        }
    }
}
#endif