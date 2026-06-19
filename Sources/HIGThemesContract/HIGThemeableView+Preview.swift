#if DEBUG
import SwiftUI

#Preview("HIGThemeableView — Container") {
    HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        Text("Themed content")
            .padding()
    }
}
#endif