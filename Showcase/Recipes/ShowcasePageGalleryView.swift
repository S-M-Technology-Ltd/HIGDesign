import HIGDesign
import SwiftUI

struct ShowcasePageGalleryView: View {
    @Environment(\.higTheme) private var theme

    var body: some View {
        ShowcaseRecipeLayoutView(
            component: .pageGallery,
            code: """
            HIGPageHeader("Gallery")
            HIGDashboardGrid {
                HIGImageFrame(aspect: .square) { … }
            }
            """
        ) {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                HIGPageHeader(
                    "Gallery",
                    subtitle: "Covers gallery and gallery-grid with themed image frames."
                )
                HIGDashboardGrid {
                    tile("Sunset", "photo")
                    tile("Studio", "camera")
                    tile("Office", "building.2")
                    tile("Event", "sparkles")
                    tile("Product", "cube.box")
                    tile("Team", "person.3")
                }
            }
        }
    }

    private func tile(_ title: String, _ systemImage: String) -> some View {
        VStack(alignment: .leading, spacing: theme.spacing.compactItem) {
            HIGImageFrame(aspect: .square, accessibilityLabel: title) {
                ZStack {
                    theme.colors.fillPrimary
                    Image(systemName: systemImage)
                        .font(theme.typography.headline)
                        .foregroundStyle(theme.colors.accent)
                }
            }
            Text(title)
                .font(theme.typography.caption)
                .foregroundStyle(theme.colors.labelSecondary)
        }
    }
}

#if DEBUG
#Preview("ShowcasePageGalleryView") {
    ShowcasePreviewContainer { ShowcasePageGalleryView() }
}
#endif
