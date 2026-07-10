import HIGThemesContract
import HIGTokensComponent
import SwiftUI

/// Page-number navigation for lists and tables (1-based pages).
///
/// Inspired by Remark Admin pagination; uses HIG-native buttons and tokens.
public struct HIGPagination: View {
    @Binding private var page: Int
    private let pageCount: Int
    private let maxVisiblePages: Int

    @Environment(\.higTheme) private var theme
    @Environment(\.isEnabled) private var isEnabled

    /// Creates a pagination control.
    /// - Parameters:
    ///   - page: Current page (1-based). Clamped into `1...pageCount` when possible.
    ///   - pageCount: Total number of pages (minimum 1).
    ///   - maxVisiblePages: Maximum numbered buttons shown (including ellipsis windows).
    public init(
        page: Binding<Int>,
        pageCount: Int,
        maxVisiblePages: Int = 7
    ) {
        _page = page
        self.pageCount = max(pageCount, 1)
        self.maxVisiblePages = max(maxVisiblePages, 3)
    }

    public var body: some View {
        let tokens = theme.pagination
        let safePage = clampedPage

        HStack(spacing: tokens.itemSpacing) {
            pageControlButton(
                systemName: "chevron.left",
                label: "Previous page",
                enabled: safePage > 1,
                tokens: tokens
            ) {
                page = safePage - 1
            }

            ForEach(visiblePages, id: \.self) { value in
                if value < 0 {
                    Text("…")
                        .font(tokens.font)
                        .foregroundStyle(theme.colors.labelSecondary)
                        .frame(minWidth: tokens.pageMinWidth, minHeight: tokens.minTapTarget)
                        .accessibilityHidden(true)
                } else {
                    pageNumberButton(value, isSelected: value == safePage, tokens: tokens)
                }
            }

            pageControlButton(
                systemName: "chevron.right",
                label: "Next page",
                enabled: safePage < pageCount,
                tokens: tokens
            ) {
                page = safePage + 1
            }
        }
        .opacity(isEnabled ? theme.opacity.full : theme.opacity.disabled)
        .accessibilityElement(children: .contain)
        .accessibilityLabel("Pagination, page \(safePage) of \(pageCount)")
        .onAppear { normalizePage() }
        .onChange(of: pageCount) { _, _ in normalizePage() }
    }

    private var clampedPage: Int {
        min(max(page, 1), pageCount)
    }

    /// Negative sentinel values represent ellipsis slots.
    private var visiblePages: [Int] {
        guard pageCount <= maxVisiblePages else {
            return windowedPages()
        }
        return Array(1...pageCount)
    }

    private func windowedPages() -> [Int] {
        let current = clampedPage
        var pages: [Int] = [1]
        let side = max((maxVisiblePages - 3) / 2, 1)
        var start = max(2, current - side)
        var end = min(pageCount - 1, current + side)

        if current - side < 2 {
            end = min(pageCount - 1, end + (2 - start))
            start = 2
        }
        if current + side > pageCount - 1 {
            start = max(2, start - (current + side - (pageCount - 1)))
            end = pageCount - 1
        }

        if start > 2 {
            pages.append(-1)
        }
        if start <= end {
            pages.append(contentsOf: start...end)
        }
        if end < pageCount - 1 {
            pages.append(-2)
        }
        pages.append(pageCount)
        return pages
    }

    private func pageNumberButton(
        _ value: Int,
        isSelected: Bool,
        tokens: any HIGPaginationTokens
    ) -> some View {
        Button {
            page = value
        } label: {
            Text("\(value)")
                .font(tokens.font)
                .foregroundStyle(isSelected ? theme.colors.labelOnAccent : theme.colors.labelPrimary)
                .frame(minWidth: tokens.pageMinWidth, minHeight: tokens.minTapTarget)
                .background(
                    RoundedRectangle(cornerRadius: tokens.cornerRadius, style: .continuous)
                        .fill(isSelected ? theme.colors.accent : theme.colors.fillPrimary)
                )
                .overlay {
                    RoundedRectangle(cornerRadius: tokens.cornerRadius, style: .continuous)
                        .strokeBorder(theme.colors.separator, lineWidth: isSelected ? 0 : tokens.borderWidth)
                }
        }
        .buttonStyle(.plain)
        .disabled(!isEnabled || isSelected)
        .accessibilityLabel("Page \(value)")
        .accessibilityAddTraits(isSelected ? .isSelected : [])
    }

    private func pageControlButton(
        systemName: String,
        label: String,
        enabled: Bool,
        tokens: any HIGPaginationTokens,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            Image(systemName: systemName)
                .font(tokens.font)
                .foregroundStyle(theme.colors.labelPrimary)
                .frame(width: tokens.minTapTarget, height: tokens.minTapTarget)
                .background(
                    RoundedRectangle(cornerRadius: tokens.cornerRadius, style: .continuous)
                        .fill(theme.colors.fillPrimary)
                )
                .overlay {
                    RoundedRectangle(cornerRadius: tokens.cornerRadius, style: .continuous)
                        .strokeBorder(theme.colors.separator, lineWidth: tokens.borderWidth)
                }
        }
        .buttonStyle(.plain)
        .disabled(!isEnabled || !enabled)
        .opacity(enabled ? theme.opacity.full : theme.opacity.disabled)
        .accessibilityLabel(label)
    }

    private func normalizePage() {
        let next = clampedPage
        if page != next {
            page = next
        }
    }
}

#if DEBUG
#Preview("HIGPagination") {
    @Previewable @State var page = 3

    HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        HIGPagination(page: $page, pageCount: 12)
            .padding()
    }
}
#endif
