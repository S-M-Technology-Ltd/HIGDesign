import HIGDesign
import SwiftUI

struct ShowcaseWelcomeView: View {
    var section: ShowcaseComponent.CatalogSection = .components

    var body: some View {
        ContentUnavailableView(
            section.emptySelectionTitle,
            systemImage: section.systemImage,
            description: Text(section.emptySelectionMessage)
        )
    }
}

#if DEBUG
#Preview("ShowcaseWelcomeView — Components") {
    ShowcasePreviewContainer(includeNavigationStack: false) {
        ShowcaseWelcomeView(section: .components)
    }
}

#Preview("ShowcaseWelcomeView — Pages") {
    ShowcasePreviewContainer(includeNavigationStack: false) {
        ShowcaseWelcomeView(section: .pages)
    }
}
#endif
