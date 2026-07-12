import HIGPlatform
import HIGThemesContract
import HIGTokensComponent
import HIGTokensRaw
import SwiftUI

/// A paged content carousel for admin hero banners and media sequences.
///
/// Uses SwiftUI ``TabView`` paging where available, with themed page indicators.
/// Optional auto-advance respects Reduce Motion.
public struct HIGCarousel<Data: RandomAccessCollection, Content: View>: View
where Data.Element: Identifiable, Data.Element.ID: Hashable {
    private let data: Data
    @Binding private var selection: Data.Element.ID
    private let showsPageIndicators: Bool
    private let autoAdvanceInterval: TimeInterval?
    private let content: (Data.Element) -> Content

    @Environment(\.higTheme) private var theme
    @Environment(\.isEnabled) private var isEnabled
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    /// Creates a carousel.
    /// - Parameters:
    ///   - data: Ordered pages (must be non-empty for meaningful paging).
    ///   - selection: Bound identity of the visible page.
    ///   - showsPageIndicators: When `true`, shows themed page dots under the pages.
    ///   - autoAdvanceInterval: Optional seconds between auto advances; ignored when Reduce Motion is on.
    ///   - content: Page content builder.
    public init(
        _ data: Data,
        selection: Binding<Data.Element.ID>,
        showsPageIndicators: Bool = true,
        autoAdvanceInterval: TimeInterval? = nil,
        @ViewBuilder content: @escaping (Data.Element) -> Content
    ) {
        self.data = data
        _selection = selection
        self.showsPageIndicators = showsPageIndicators
        self.autoAdvanceInterval = autoAdvanceInterval
        self.content = content
    }

    public var body: some View {
        let tokens = theme.carousel
        let capabilities = HIGPlatformCapabilities.current
        let minHeight = max(tokens.minHeight, capabilities.minimumTouchTarget * 2)
        let pages = Array(data)

        VStack(spacing: tokens.stackSpacing) {
            pagedContent(pages: pages, tokens: tokens, minHeight: minHeight)

            if showsPageIndicators, pages.count > 1 {
                pageIndicators(pages: pages, tokens: tokens, minTarget: capabilities.minimumTouchTarget)
            }
        }
        .opacity(isEnabled ? theme.opacity.full : theme.opacity.disabled)
        .accessibilityElement(children: .contain)
        .accessibilityLabel("Carousel")
        .accessibilityValue(accessibilityValue(pages: pages))
        .task(id: autoAdvanceTaskID(pages: pages)) {
            await runAutoAdvance(pages: pages)
        }
    }

    @ViewBuilder
    private func pagedContent(
        pages: [Data.Element],
        tokens: any HIGCarouselTokens,
        minHeight: CGFloat
    ) -> some View {
        Group {
            if pages.isEmpty {
                Color.clear
                    .frame(maxWidth: .infinity, minHeight: minHeight)
            } else {
                TabView(selection: $selection) {
                    ForEach(pages) { page in
                        content(page)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .padding(tokens.contentPadding)
                            .tag(page.id)
                    }
                }
                #if os(iOS) || os(tvOS) || os(visionOS) || os(watchOS)
                .tabViewStyle(.page(indexDisplayMode: .never))
                #endif
                .frame(maxWidth: .infinity, minHeight: minHeight)
            }
        }
        .background(theme.colors.backgroundSecondary)
        .clipShape(RoundedRectangle(cornerRadius: tokens.cornerRadius, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: tokens.cornerRadius, style: .continuous)
                .strokeBorder(theme.colors.separator, lineWidth: tokens.borderWidth)
        }
    }

    private func pageIndicators(
        pages: [Data.Element],
        tokens: any HIGCarouselTokens,
        minTarget: CGFloat
    ) -> some View {
        HStack(spacing: tokens.indicatorSpacing) {
            ForEach(pages) { page in
                Button {
                    selection = page.id
                } label: {
                    Circle()
                        .fill(page.id == selection ? theme.colors.accent : theme.colors.separator)
                        .frame(width: tokens.indicatorSize, height: tokens.indicatorSize)
                        .frame(width: minTarget, height: minTarget)
                        .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
                .disabled(!isEnabled)
                .accessibilityLabel("Page \(pageIndex(of: page.id, in: pages) + 1)")
                .accessibilityAddTraits(page.id == selection ? .isSelected : [])
            }
        }
        .accessibilityElement(children: .contain)
    }

    private func accessibilityValue(pages: [Data.Element]) -> String {
        guard !pages.isEmpty else { return "Empty" }
        let index = pageIndex(of: selection, in: pages) + 1
        return "Page \(index) of \(pages.count)"
    }

    private func pageIndex(of id: Data.Element.ID, in pages: [Data.Element]) -> Int {
        pages.firstIndex(where: { $0.id == id }) ?? 0
    }

    private func autoAdvanceTaskID(pages: [Data.Element]) -> String {
        let interval = autoAdvanceInterval.map { String($0) } ?? "nil"
        return "\(pages.count)-\(interval)-\(reduceMotion)"
    }

    private func runAutoAdvance(pages: [Data.Element]) async {
        guard pages.count > 1,
              let interval = autoAdvanceInterval,
              interval > 0,
              !reduceMotion,
              isEnabled
        else { return }

        while !Task.isCancelled {
            do {
                try await Task.sleep(for: .seconds(interval))
            } catch {
                return
            }
            guard !Task.isCancelled else { return }
            advance(pages: pages)
        }
    }

    private func advance(pages: [Data.Element]) {
        guard let current = pages.firstIndex(where: { $0.id == selection }) else {
            if let first = pages.first {
                selection = first.id
            }
            return
        }
        let next = pages[(current + 1) % pages.count]
        selection = next.id
    }
}

#if DEBUG
private struct HIGCarouselPreviewPage: Identifiable, Hashable {
    let id: String
    let title: String
    let symbol: String
}

#Preview("HIGCarousel") {
    @Previewable @State var selection = "one"

    let pages = [
        HIGCarouselPreviewPage(id: "one", title: "Dashboard", symbol: "square.grid.2x2"),
        HIGCarouselPreviewPage(id: "two", title: "Analytics", symbol: "chart.bar"),
        HIGCarouselPreviewPage(id: "three", title: "Team", symbol: "person.3"),
    ]

    HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        HIGCarousel(pages, selection: $selection) { page in
            VStack(spacing: HIGSpacing.md.rawValue) {
                Image(systemName: page.symbol)
                    .font(.largeTitle)
                Text(page.title)
                    .font(.title2)
            }
        }
        .padding()
    }
}
#endif
