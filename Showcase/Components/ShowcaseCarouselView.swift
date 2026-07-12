import HIGDesign
import SwiftUI

private struct ShowcaseCarouselPage: Identifiable, Hashable {
    let id: String
    let title: String
    let message: String
    let systemImage: String
}

struct ShowcaseCarouselView: View {
    @Environment(\.higTheme) private var theme
    @State private var selection = "dashboard"
    @State private var autoSelection = "one"

    private let pages: [ShowcaseCarouselPage] = [
        .init(id: "dashboard", title: "Dashboard", message: "Overview metrics and panels.", systemImage: "square.grid.2x2"),
        .init(id: "analytics", title: "Analytics", message: "Traffic and conversion trends.", systemImage: "chart.bar"),
        .init(id: "team", title: "Team", message: "Members and roles.", systemImage: "person.3"),
    ]

    private let autoPages: [ShowcaseCarouselPage] = [
        .init(id: "one", title: "Slide 1", message: "Auto-advances when motion is allowed.", systemImage: "1.circle"),
        .init(id: "two", title: "Slide 2", message: "Respects Reduce Motion.", systemImage: "2.circle"),
        .init(id: "three", title: "Slide 3", message: "Tap indicators to jump.", systemImage: "3.circle"),
    ]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: theme.spacing.section) {
                ShowcaseMetadataView(component: .carousel)

                VStack(spacing: theme.spacing.screenEdge) {
                    ShowcaseSampleView(code: """
                    HIGCarousel(pages, selection: $selection) { page in
                        // page content
                    }
                    """) {
                        HIGCarousel(pages, selection: $selection) { page in
                            pageContent(page)
                        }
                    }

                    ShowcaseSampleView(code: """
                    HIGCarousel(
                        autoPages,
                        selection: $autoSelection,
                        autoAdvanceInterval: 3
                    ) { page in
                        // page content
                    }
                    """) {
                        HIGCarousel(
                            autoPages,
                            selection: $autoSelection,
                            autoAdvanceInterval: 3
                        ) { page in
                            pageContent(page)
                        }
                    }
                }
            }
            .higPadding(.screenEdge)
        }
        .navigationTitle("Carousel")
    }

    private func pageContent(_ page: ShowcaseCarouselPage) -> some View {
        VStack(spacing: theme.spacing.item) {
            Image(systemName: page.systemImage)
                .font(theme.typography.title)
                .foregroundStyle(theme.colors.accent)
            Text(page.title)
                .font(theme.typography.headline)
                .foregroundStyle(theme.colors.labelPrimary)
            Text(page.message)
                .font(theme.typography.callout)
                .foregroundStyle(theme.colors.labelSecondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#if DEBUG
#Preview("ShowcaseCarouselView") {
    ShowcasePreviewContainer {
        ShowcaseCarouselView()
    }
}
#endif
