import HIGThemesContract
import HIGTokensComponent
import SwiftUI

/// A vertical activity timeline with markers, connectors, titles, and optional detail.
///
/// Inspired by Remark Admin timelines; HIG-native chrome via ``HIGTheme/timeline``.
public struct HIGTimeline: View {
    private let items: [HIGTimelineItem]

    @Environment(\.higTheme) private var theme

    public init(items: [HIGTimelineItem]) {
        self.items = items
    }

    public var body: some View {
        let tokens = theme.timeline

        VStack(alignment: .leading, spacing: 0) {
            ForEach(Array(items.enumerated()), id: \.element.id) { index, item in
                timelineRow(
                    item: item,
                    isLast: index == items.count - 1,
                    tokens: tokens
                )
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .accessibilityElement(children: .contain)
        .accessibilityLabel("Timeline, \(items.count) events")
    }

    private func timelineRow(
        item: HIGTimelineItem,
        isLast: Bool,
        tokens: any HIGTimelineTokens
    ) -> some View {
        HStack(alignment: .top, spacing: tokens.contentLeadingPadding) {
            marker(for: item, tokens: tokens)
                .frame(width: tokens.markerSize)

            VStack(alignment: .leading, spacing: tokens.labelSpacing) {
                HStack(alignment: .firstTextBaseline, spacing: theme.spacing.item) {
                    Text(item.title)
                        .font(tokens.titleFont)
                        .foregroundStyle(theme.colors.labelPrimary)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    if let timestamp = item.timestamp {
                        Text(timestamp)
                            .font(tokens.timestampFont)
                            .foregroundStyle(theme.colors.labelSecondary)
                    }
                }

                if let detail = item.detail {
                    Text(detail)
                        .font(tokens.detailFont)
                        .foregroundStyle(theme.colors.labelSecondary)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
            .padding(.bottom, isLast ? 0 : tokens.itemSpacing)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .background(alignment: .topLeading) {
            if !isLast {
                Rectangle()
                    .fill(theme.colors.separator)
                    .frame(width: tokens.connectorWidth)
                    .padding(.leading, (tokens.markerSize - tokens.connectorWidth) / 2)
                    .padding(.top, tokens.markerSize)
                    .frame(maxHeight: .infinity, alignment: .top)
            }
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel(accessibilityLabel(for: item))
    }

    private func marker(for item: HIGTimelineItem, tokens: any HIGTimelineTokens) -> some View {
        ZStack {
            Circle()
                .fill(theme.colors.backgroundSecondary)
                .frame(width: tokens.markerSize, height: tokens.markerSize)
                .overlay {
                    Circle()
                        .strokeBorder(theme.colors.accent, lineWidth: tokens.connectorWidth)
                }

            if let systemImage = item.systemImage {
                Image(systemName: systemImage)
                    .font(.system(size: tokens.markerIconPointSize, weight: .semibold))
                    .foregroundStyle(theme.colors.accent)
            } else {
                Circle()
                    .fill(theme.colors.accent)
                    .frame(
                        width: tokens.markerSize / 2,
                        height: tokens.markerSize / 2
                    )
            }
        }
        .accessibilityHidden(true)
    }

    private func accessibilityLabel(for item: HIGTimelineItem) -> String {
        var parts = [item.title]
        if let timestamp = item.timestamp {
            parts.append(timestamp)
        }
        if let detail = item.detail {
            parts.append(detail)
        }
        return parts.joined(separator: ", ")
    }
}

#if DEBUG
#Preview("HIGTimeline") {
    HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        HIGTimeline(
            items: [
                HIGTimelineItem(
                    id: "1",
                    title: "Order placed",
                    detail: "Customer submitted checkout.",
                    timestamp: "9:41 AM",
                    systemImage: "cart"
                ),
                HIGTimelineItem(
                    id: "2",
                    title: "Payment captured",
                    detail: "Visa ending 4242",
                    timestamp: "9:42 AM",
                    systemImage: "creditcard"
                ),
                HIGTimelineItem(
                    id: "3",
                    title: "Fulfilled",
                    timestamp: "Today"
                ),
            ]
        )
        .padding()
    }
}
#endif
