import HIGThemesContract
import HIGTokensComponent
import SwiftUI

/// A hierarchical navigation trail with a current (non-interactive) last segment.
///
/// Inspired by Remark Admin breadcrumbs; implemented with HIG-native labels and accent actions.
public struct HIGBreadcrumb: View {
    private let items: [HIGBreadcrumbItem]
    private let onSelect: ((HIGBreadcrumbItem) -> Void)?

    @Environment(\.higTheme) private var theme

    /// Creates a breadcrumb trail.
    /// - Parameters:
    ///   - items: Ordered segments from root to current page. The last item is current.
    ///   - onSelect: Invoked for non-current segments when tapped. Omitted items stay non-interactive.
    public init(
        items: [HIGBreadcrumbItem],
        onSelect: ((HIGBreadcrumbItem) -> Void)? = nil
    ) {
        self.items = items
        self.onSelect = onSelect
    }

    public var body: some View {
        let tokens = theme.breadcrumb

        if items.isEmpty {
            EmptyView()
        } else {
            // Prefer wrapping on narrow widths while keeping a continuous trail.
            ViewThatFits(in: .horizontal) {
                trail(tokens: tokens, axis: .horizontal)
                trail(tokens: tokens, axis: .vertical)
            }
            .accessibilityElement(children: .contain)
            .accessibilityLabel(accessibilityTrailLabel)
        }
    }

    private var accessibilityTrailLabel: String {
        "Breadcrumb: " + items.map(\.title).joined(separator: ", ")
    }

    @ViewBuilder
    private func trail(tokens: any HIGBreadcrumbTokens, axis: Axis) -> some View {
        let spacing = tokens.itemSpacing
        switch axis {
        case .horizontal:
            HStack(spacing: spacing) {
                trailContent(tokens: tokens, showSeparators: true)
            }
        case .vertical:
            VStack(alignment: .leading, spacing: spacing) {
                trailContent(tokens: tokens, showSeparators: false)
            }
        }
    }

    @ViewBuilder
    private func trailContent(tokens: any HIGBreadcrumbTokens, showSeparators: Bool) -> some View {
        ForEach(Array(items.enumerated()), id: \.element.id) { index, item in
            let isCurrent = index == items.count - 1

            if showSeparators, index > 0 {
                separator(tokens: tokens)
            }

            segment(item: item, isCurrent: isCurrent, tokens: tokens)
        }
    }

    @ViewBuilder
    private func segment(
        item: HIGBreadcrumbItem,
        isCurrent: Bool,
        tokens: any HIGBreadcrumbTokens
    ) -> some View {
        if isCurrent {
            Text(item.title)
                .font(tokens.currentFont)
                .foregroundStyle(theme.colors.labelPrimary)
                .accessibilityAddTraits(.isStaticText)
                .accessibilityLabel("Current page, \(item.title)")
        } else if let onSelect {
            Button {
                onSelect(item)
            } label: {
                Text(item.title)
                    .font(tokens.font)
                    .foregroundStyle(theme.colors.accent)
                    .frame(minHeight: tokens.minTapTarget, alignment: .center)
                    .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
            .accessibilityLabel(item.title)
            .accessibilityHint("Navigate to this level")
        } else {
            Text(item.title)
                .font(tokens.font)
                .foregroundStyle(theme.colors.labelSecondary)
                .accessibilityLabel(item.title)
        }
    }

    private func separator(tokens: any HIGBreadcrumbTokens) -> some View {
        Image(systemName: "chevron.right")
            .font(.system(size: tokens.separatorPointSize, weight: .semibold))
            .foregroundStyle(theme.colors.labelSecondary)
            .accessibilityHidden(true)
    }
}

#if DEBUG
#Preview("HIGBreadcrumb") {
    HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        HIGBreadcrumb(
            items: [
                HIGBreadcrumbItem(id: "home", title: "Home"),
                HIGBreadcrumbItem(id: "uikit", title: "UI Kit"),
                HIGBreadcrumbItem(id: "buttons", title: "Buttons"),
            ],
            onSelect: { _ in }
        )
        .padding()
    }
}
#endif
