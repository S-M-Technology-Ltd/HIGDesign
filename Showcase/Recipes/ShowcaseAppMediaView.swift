import HIGDesign
import SwiftUI

struct ShowcaseAppMediaView: View {
    @Environment(\.higTheme) private var theme

    var body: some View {
        ShowcaseRecipeLayoutView(
            component: .appMedia,
            code: """
            HIGPageHeader("Media library")
            HIGDashboardGrid {
                HIGImageFrame(aspect: .square) { … }
            }
            """
        ) {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                HIGPageHeader(
                    "Media library",
                    subtitle: "Grid of themed frames; pair with HIGLightbox for full-screen review."
                )
                HIGDashboardGrid {
                    mediaTile(title: "Hero", systemImage: "photo")
                    mediaTile(title: "Product", systemImage: "cube.box")
                    mediaTile(title: "Team", systemImage: "person.3")
                    mediaTile(title: "Office", systemImage: "building.2")
                }
            }
        }
    }

    private func mediaTile(title: String, systemImage: String) -> some View {
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
#Preview("ShowcaseAppMediaView") {
    ShowcasePreviewContainer {
        ShowcaseAppMediaView()
    }
}
#endif
