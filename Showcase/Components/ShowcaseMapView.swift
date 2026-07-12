import HIGDesign
import SwiftUI

#if canImport(MapKit) && !os(tvOS)
import MapKit
#endif

/// Showcase recipe for admin maps: MapKit + HIG surfaces (no library `HIGMap` module).
struct ShowcaseMapView: View {
    @Environment(\.higTheme) private var theme

#if canImport(MapKit) && !os(tvOS)
    @State private var selectedSiteID: String = ShowcaseMapSite.applePark.id
    @State private var cameraPosition: MapCameraPosition = .region(ShowcaseMapSite.applePark.region)
#endif

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                ShowcaseMetadataView(component: .map)

                VStack(spacing: theme.spacing.screenEdge) {
#if canImport(MapKit) && !os(tvOS)
                    mapInWidgetSample
                    annotatedMapSample
#else
                    unsupportedPlatformSample
#endif
                }
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle("Map")
    }

#if canImport(MapKit) && !os(tvOS)
    private var mapInWidgetSample: some View {
        ShowcaseSampleView(code: """
        HIGWidget("Office map", subtitle: "MapKit recipe") {
            Map(position: $cameraPosition) {
                Marker("Apple Park", coordinate: …)
            }
        }
        """) {
            HIGWidget("Office map", subtitle: "MapKit recipe — not a HIG library component") {
                mapChrome {
                    Map(position: $cameraPosition) {
                        Marker(
                            ShowcaseMapSite.applePark.name,
                            coordinate: ShowcaseMapSite.applePark.coordinate
                        )
                        .tint(theme.colors.accent)
                    }
                    .mapStyle(.standard)
                }
            }
        }
    }

    private var annotatedMapSample: some View {
        ShowcaseSampleView(code: """
        HIGPanel("Sites") {
            Map(position: $cameraPosition) { /* markers */ }
            HIGListGroup { /* select a site */ }
        }
        """) {
            HIGPanel(
                "Sites",
                description: "Select a location to re-center the map camera."
            ) {
                VStack(alignment: .leading, spacing: theme.spacing.item) {
                    mapChrome {
                        Map(position: $cameraPosition) {
                            ForEach(ShowcaseMapSite.all) { site in
                                Marker(site.name, coordinate: site.coordinate)
                                    .tint(
                                        site.id == selectedSiteID
                                            ? theme.colors.accent
                                            : theme.colors.labelSecondary
                                    )
                            }
                        }
                        .mapStyle(.standard)
                    }

                    HIGListGroup(header: "Locations", footer: "Deterministic demo coordinates.") {
                        ForEach(Array(ShowcaseMapSite.all.enumerated()), id: \.element.id) { index, site in
                            if index > 0 {
                                HIGDivider()
                            }
                            HIGListGroupRow(
                                site.name,
                                subtitle: site.subtitle,
                                systemImage: "mappin.circle",
                                isSelected: selectedSiteID == site.id
                            ) {
                                selectedSiteID = site.id
                                cameraPosition = .region(site.region)
                            }
                        }
                    }
                }
            }
        }
    }

    private func mapChrome<Content: View>(@ViewBuilder content: () -> Content) -> some View {
        let height = HIGSpacing.massive.rawValue * 5
        let shape = RoundedRectangle(cornerRadius: theme.card.cornerRadius, style: .continuous)
        return content()
            .frame(maxWidth: .infinity, minHeight: height, maxHeight: height)
            .clipShape(shape)
            .overlay {
                shape.strokeBorder(theme.colors.separator, lineWidth: theme.card.borderWidth)
            }
            .accessibilityLabel("Map preview")
    }
#else
    private var unsupportedPlatformSample: some View {
        ShowcaseSampleView(code: """
        // MapKit map views are not available on this platform.
        // Compose Map on iOS, iPadOS, macOS, visionOS, or watchOS.
        """) {
            HIGEmptyState(
                "MapKit unavailable",
                message: "This Showcase recipe uses MapKit, which is not available on tvOS. Use the same composition pattern on supported platforms.",
                systemImage: "map"
            )
            .background(theme.colors.backgroundSecondary)
            .clipShape(RoundedRectangle(cornerRadius: theme.card.cornerRadius, style: .continuous))
        }
    }
#endif
}

#if canImport(MapKit) && !os(tvOS)
private struct ShowcaseMapSite: Identifiable, Hashable, Sendable {
    let id: String
    let name: String
    let subtitle: String
    let latitude: Double
    let longitude: Double
    let span: Double

    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }

    var region: MKCoordinateRegion {
        MKCoordinateRegion(
            center: coordinate,
            span: MKCoordinateSpan(latitudeDelta: span, longitudeDelta: span)
        )
    }

    static let applePark = ShowcaseMapSite(
        id: "apple-park",
        name: "Apple Park",
        subtitle: "Cupertino HQ",
        latitude: 37.3349,
        longitude: -122.0090,
        span: 0.02
    )

    static let infiniteLoop = ShowcaseMapSite(
        id: "infinite-loop",
        name: "1 Infinite Loop",
        subtitle: "Historic campus",
        latitude: 37.3318,
        longitude: -122.0312,
        span: 0.02
    )

    static let unionSquare = ShowcaseMapSite(
        id: "union-square",
        name: "Union Square",
        subtitle: "San Francisco store",
        latitude: 37.7880,
        longitude: -122.4075,
        span: 0.03
    )

    static let all: [ShowcaseMapSite] = [applePark, infiniteLoop, unionSquare]
}
#endif

#if DEBUG
#Preview("ShowcaseMapView") {
    ShowcasePreviewContainer {
        ShowcaseMapView()
    }
}
#endif
