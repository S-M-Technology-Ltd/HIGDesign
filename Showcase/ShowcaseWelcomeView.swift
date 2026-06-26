import HIGDesign
import SwiftUI

struct ShowcaseWelcomeView: View {
    var body: some View {
        ContentUnavailableView(
            "Select a Component",
            systemImage: "square.grid.2x2",
            description: Text("Choose a HIGDesign component to inspect roles, tokens, and accessibility behavior.")
        )
    }
}

#if DEBUG
#Preview("ShowcaseWelcomeView") {
    ShowcasePreviewContainer(includeNavigationStack: false) {
        ShowcaseWelcomeView()
    }
}
#endif