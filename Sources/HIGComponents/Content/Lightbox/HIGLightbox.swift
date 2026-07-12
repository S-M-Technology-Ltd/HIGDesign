import HIGPlatform
import HIGThemesContract
import HIGTokensComponent
import HIGTokensRaw
import SwiftUI

/// A themed full-screen media gallery chrome for admin lightboxes.
///
/// Present with native `.fullScreenCover` / `.sheet`. ``HIGLightbox`` provides the
/// dimmed surface, close control, page counter, previous/next navigation, and a
/// content slot for each identifiable item. Reuses paging ideas from ``HIGCarousel``
/// without auto-advance (lightbox is user-driven).
public struct HIGLightbox<Data: RandomAccessCollection, Content: View>: View
where Data.Element: Identifiable, Data.Element.ID: Hashable {
    private let data: Data
    @Binding private var selection: Data.Element.ID
    private let title: String?
    private let emptyMessage: String
    private let onDismiss: () -> Void
    private let content: (Data.Element) -> Content

    @Environment(\.higTheme) private var theme
    @Environment(\.isEnabled) private var isEnabled

    /// Creates a lightbox gallery.
    /// - Parameters:
    ///   - data: Ordered media items.
    ///   - selection: Bound identity of the visible item.
    ///   - title: Optional gallery title in the chrome header.
    ///   - emptyMessage: Shown when `data` is empty.
    ///   - onDismiss: Invoked by the close control.
    ///   - content: Builder for the focused item body (typically image or media).
    public init(
        _ data: Data,
        selection: Binding<Data.Element.ID>,
        title: String? = nil,
        emptyMessage: String = "No media",
        onDismiss: @escaping () -> Void,
        @ViewBuilder content: @escaping (Data.Element) -> Content
    ) {
        self.data = data
        _selection = selection
        self.title = title
        self.emptyMessage = emptyMessage
        self.onDismiss = onDismiss
        self.content = content
    }

    public var body: some View {
        let tokens = theme.lightbox
        let capabilities = HIGPlatformCapabilities.current
        let minTarget = max(tokens.controlSize, capabilities.minimumTouchTarget)
        let pages = Array(data)
        let chromeLabel = theme.colors.backgroundPrimary

        ZStack {
            theme.colors.labelPrimary.opacity(theme.opacity.disabled)
                .ignoresSafeArea()
                .accessibilityHidden(true)

            VStack(spacing: tokens.stackSpacing) {
                header(tokens: tokens, pages: pages, chromeLabel: chromeLabel)

                Group {
                    if pages.isEmpty {
                        Text(emptyMessage)
                            .font(tokens.emptyFont)
                            .foregroundStyle(chromeLabel)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .accessibilityLabel(emptyMessage)
                    } else {
                        mediaStage(pages: pages, tokens: tokens, minTarget: minTarget)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)

                if pages.count > 1 {
                    footerControls(pages: pages, tokens: tokens, minTarget: minTarget, chromeLabel: chromeLabel)
                }
            }
            .padding(tokens.contentPadding)
        }
        .opacity(isEnabled ? theme.opacity.full : theme.opacity.disabled)
        .accessibilityElement(children: .contain)
        .accessibilityLabel(accessibilityLabelText)
        .accessibilityValue(accessibilityValue(pages: pages))
    }

    private func header(
        tokens: any HIGLightboxTokens,
        pages: [Data.Element],
        chromeLabel: Color
    ) -> some View {
        HStack(alignment: .center, spacing: tokens.chromeSpacing) {
            VStack(alignment: .leading, spacing: tokens.chromeSpacing) {
                if let title {
                    Text(title)
                        .font(tokens.titleFont)
                        .foregroundStyle(chromeLabel)
                        .accessibilityAddTraits(.isHeader)
                }
                if !pages.isEmpty {
                    Text(counterText(pages: pages))
                        .font(tokens.counterFont)
                        .foregroundStyle(chromeLabel.opacity(theme.opacity.pressedSecondary))
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            HIGCloseButton(action: onDismiss)
        }
    }

    private func mediaStage(
        pages: [Data.Element],
        tokens: any HIGLightboxTokens,
        minTarget: CGFloat
    ) -> some View {
        let minHeight = max(tokens.minMediaHeight, minTarget * 3)

        return Group {
            if let current = pages.first(where: { $0.id == selection }) ?? pages.first {
                content(current)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .frame(minHeight: minHeight)
                    .padding(tokens.contentPadding)
                    .background(theme.colors.backgroundSecondary)
                    .clipShape(RoundedRectangle(cornerRadius: tokens.cornerRadius, style: .continuous))
                    .overlay {
                        RoundedRectangle(cornerRadius: tokens.cornerRadius, style: .continuous)
                            .strokeBorder(theme.colors.separator, lineWidth: tokens.borderWidth)
                    }
            }
        }
    }

    private func footerControls(
        pages: [Data.Element],
        tokens: any HIGLightboxTokens,
        minTarget: CGFloat,
        chromeLabel: Color
    ) -> some View {
        HStack(spacing: tokens.chromeSpacing) {
            navButton(
                systemName: "chevron.left",
                label: "Previous",
                enabled: canGoPrevious(pages: pages),
                minTarget: minTarget,
                chromeLabel: chromeLabel
            ) {
                goPrevious(pages: pages)
            }

            Spacer(minLength: 0)

            pageIndicators(pages: pages, tokens: tokens, minTarget: minTarget, chromeLabel: chromeLabel)

            Spacer(minLength: 0)

            navButton(
                systemName: "chevron.right",
                label: "Next",
                enabled: canGoNext(pages: pages),
                minTarget: minTarget,
                chromeLabel: chromeLabel
            ) {
                goNext(pages: pages)
            }
        }
    }

    private func pageIndicators(
        pages: [Data.Element],
        tokens: any HIGLightboxTokens,
        minTarget: CGFloat,
        chromeLabel: Color
    ) -> some View {
        HStack(spacing: tokens.indicatorSpacing) {
            ForEach(pages) { page in
                Button {
                    selection = page.id
                } label: {
                    Circle()
                        .fill(page.id == selection ? theme.colors.accent : chromeLabel.opacity(theme.opacity.disabled))
                        .frame(width: tokens.indicatorSize, height: tokens.indicatorSize)
                        .frame(width: minTarget, height: minTarget)
                        .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
                .disabled(!isEnabled)
                .accessibilityLabel("Item \(pageIndex(of: page.id, in: pages) + 1)")
                .accessibilityAddTraits(page.id == selection ? .isSelected : [])
            }
        }
        .accessibilityElement(children: .contain)
    }

    private func navButton(
        systemName: String,
        label: String,
        enabled: Bool,
        minTarget: CGFloat,
        chromeLabel: Color,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            Image(systemName: systemName)
                .font(.body.weight(.semibold))
                .foregroundStyle(chromeLabel)
                .frame(width: minTarget, height: minTarget)
                .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .disabled(!isEnabled || !enabled)
        .opacity((isEnabled && enabled) ? theme.opacity.full : theme.opacity.disabled)
        .accessibilityLabel(label)
    }

    private var accessibilityLabelText: String {
        title ?? "Lightbox"
    }

    private func accessibilityValue(pages: [Data.Element]) -> String {
        guard !pages.isEmpty else { return emptyMessage }
        return counterText(pages: pages)
    }

    private func counterText(pages: [Data.Element]) -> String {
        let index = pageIndex(of: selection, in: pages) + 1
        return "\(index) of \(pages.count)"
    }

    private func pageIndex(of id: Data.Element.ID, in pages: [Data.Element]) -> Int {
        pages.firstIndex(where: { $0.id == id }) ?? 0
    }

    private func canGoPrevious(pages: [Data.Element]) -> Bool {
        pageIndex(of: selection, in: pages) > 0
    }

    private func canGoNext(pages: [Data.Element]) -> Bool {
        let index = pageIndex(of: selection, in: pages)
        return index + 1 < pages.count
    }

    private func goPrevious(pages: [Data.Element]) {
        let index = pageIndex(of: selection, in: pages)
        guard index > 0 else { return }
        selection = pages[index - 1].id
    }

    private func goNext(pages: [Data.Element]) {
        let index = pageIndex(of: selection, in: pages)
        guard index + 1 < pages.count else { return }
        selection = pages[index + 1].id
    }
}

#if DEBUG
private struct HIGLightboxPreviewItem: Identifiable, Hashable {
    let id: String
    let symbol: String
    let caption: String
}

#Preview("HIGLightbox") {
    @Previewable @State var selection = "one"

    let items = [
        HIGLightboxPreviewItem(id: "one", symbol: "photo", caption: "Dashboard screenshot"),
        HIGLightboxPreviewItem(id: "two", symbol: "chart.bar", caption: "Analytics"),
        HIGLightboxPreviewItem(id: "three", symbol: "person.3", caption: "Team"),
    ]

    HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        HIGLightbox(items, selection: $selection, title: "Gallery", onDismiss: {}) { item in
            VStack(spacing: HIGSpacing.md.rawValue) {
                Image(systemName: item.symbol)
                    .font(.largeTitle)
                Text(item.caption)
                    .font(.body)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}
#endif
