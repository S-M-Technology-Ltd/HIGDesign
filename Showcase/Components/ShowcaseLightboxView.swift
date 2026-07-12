import HIGDesign
import SwiftUI

private struct ShowcaseLightboxItem: Identifiable, Hashable {
    let id: String
    let symbol: String
    let caption: String
}

struct ShowcaseLightboxView: View {
    @Environment(\.higTheme) private var theme
    @State private var selection = "dash"
    @State private var isPresented = false
    @State private var emptySelection = "none"

    private let items: [ShowcaseLightboxItem] = [
        .init(id: "dash", symbol: "square.grid.2x2", caption: "Dashboard"),
        .init(id: "analytics", symbol: "chart.bar", caption: "Analytics"),
        .init(id: "team", symbol: "person.3", caption: "Team"),
    ]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                ShowcaseMetadataView(component: .lightbox)

                VStack(spacing: theme.spacing.screenEdge) {
                    ShowcaseSampleView(code: """
                    HIGLightbox(
                        items,
                        selection: $selection,
                        title: "Gallery",
                        onDismiss: { /* close */ }
                    ) { item in
                        // media content
                    }
                    """) {
                        HIGLightbox(
                            items,
                            selection: $selection,
                            title: "Gallery",
                            onDismiss: {}
                        ) { item in
                            mediaContent(item)
                        }
                        .frame(minHeight: 360)
                        .clipShape(RoundedRectangle(cornerRadius: theme.card.cornerRadius, style: .continuous))
                    }

                    ShowcaseSampleView(code: """
                    // Present with sheet (macOS) or fullScreenCover (iOS)
                    HIGLightbox(
                        items,
                        selection: $selection,
                        title: "Gallery",
                        onDismiss: { isPresented = false }
                    ) { item in
                        // media content
                    }
                    """) {
                        VStack(alignment: .leading, spacing: theme.spacing.item) {
                            HIGButton("Present lightbox", role: .secondary) {
                                isPresented = true
                            }
                        }
                        .sheet(isPresented: $isPresented) {
                            HIGLightbox(
                                items,
                                selection: $selection,
                                title: "Gallery",
                                onDismiss: { isPresented = false }
                            ) { item in
                                mediaContent(item)
                            }
                            #if os(macOS)
                            .frame(minWidth: 480, minHeight: 360)
                            #endif
                        }
                    }

                    ShowcaseSampleView(code: """
                    HIGLightbox(
                        [],
                        selection: $emptySelection,
                        emptyMessage: "No media yet",
                        onDismiss: {}
                    ) { _ in EmptyView() }
                    """) {
                        HIGLightbox(
                            [ShowcaseLightboxItem](),
                            selection: $emptySelection,
                            emptyMessage: "No media yet",
                            onDismiss: {}
                        ) { _ in
                            EmptyView()
                        }
                        .frame(minHeight: 220)
                        .clipShape(RoundedRectangle(cornerRadius: theme.card.cornerRadius, style: .continuous))
                    }
                }
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle("Lightbox")
    }

    private func mediaContent(_ item: ShowcaseLightboxItem) -> some View {
        VStack(spacing: theme.spacing.item) {
            Image(systemName: item.symbol)
                .font(theme.typography.largeTitle)
                .foregroundStyle(theme.colors.accent)
            Text(item.caption)
                .font(theme.typography.headline)
                .foregroundStyle(theme.colors.labelPrimary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#if DEBUG
#Preview("ShowcaseLightboxView") {
    ShowcasePreviewContainer {
        ShowcaseLightboxView()
    }
}
#endif
