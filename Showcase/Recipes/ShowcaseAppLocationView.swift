import HIGDesign
import SwiftUI

struct ShowcaseAppLocationView: View {
    @Environment(\.higTheme) private var theme

    var body: some View {
        ShowcaseRecipeLayoutView(
            component: .appLocation,
            code: """
            HIGPageHeader("Locations")
            HIGListGroup { HIGListGroupRow("Apple Park", …) }
            // Pair with Showcase Map recipe for MapKit
            """
        ) {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                HIGPageHeader(
                    "Locations",
                    subtitle: "Site directory recipe. Pair with the Map catalog entry for MapKit."
                )
                HIGListGroup(header: "Sites", footer: "Open Map for an annotated MapKit surface.") {
                    HIGListGroupRow(
                        "Apple Park",
                        subtitle: "Cupertino HQ",
                        systemImage: "mappin.circle",
                        showsChevron: true
                    ) {}
                    HIGDivider()
                    HIGListGroupRow(
                        "1 Infinite Loop",
                        subtitle: "Historic campus",
                        systemImage: "mappin.circle",
                        showsChevron: true
                    ) {}
                    HIGDivider()
                    HIGListGroupRow(
                        "Union Square",
                        subtitle: "San Francisco store",
                        systemImage: "mappin.circle",
                        showsChevron: true
                    ) {}
                }
                HIGEmptyState(
                    "Map lives in the Map recipe",
                    message: "Compose MapKit with HIGWidget and HIGPanel as shown under Map.",
                    systemImage: "map"
                )
                .background(theme.colors.backgroundSecondary)
                .clipShape(RoundedRectangle(cornerRadius: theme.card.cornerRadius, style: .continuous))
            }
        }
    }
}

#if DEBUG
#Preview("ShowcaseAppLocationView") {
    ShowcasePreviewContainer {
        ShowcaseAppLocationView()
    }
}
#endif
