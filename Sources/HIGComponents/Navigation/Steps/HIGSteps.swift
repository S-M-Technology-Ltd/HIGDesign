import HIGThemesContract
import HIGTokensComponent
import SwiftUI

/// Multi-step process indicator with numbered markers, connectors, and labels.
///
/// Inspired by Remark Admin steps; HIG-native styling via ``HIGTheme/steps``.
public struct HIGSteps: View {
    private let items: [HIGStepsItem]
    private let currentIndex: Int
    private let axis: HIGStepsAxis
    private let onSelect: ((Int) -> Void)?

    @Environment(\.higTheme) private var theme
    @Environment(\.isEnabled) private var isEnabled

    /// Creates a steps indicator.
    /// - Parameters:
    ///   - items: Ordered process steps.
    ///   - currentIndex: Zero-based index of the active step.
    ///   - axis: Horizontal or vertical layout.
    ///   - onSelect: Optional handler when a completed or current step is tapped.
    public init(
        items: [HIGStepsItem],
        currentIndex: Int,
        axis: HIGStepsAxis = .horizontal,
        onSelect: ((Int) -> Void)? = nil
    ) {
        self.items = items
        self.currentIndex = currentIndex
        self.axis = axis
        self.onSelect = onSelect
    }

    public var body: some View {
        let tokens = theme.steps
        let safeIndex = clampedIndex

        Group {
            switch axis {
            case .horizontal:
                ViewThatFits(in: .horizontal) {
                    horizontalTrail(tokens: tokens, safeIndex: safeIndex)
                    verticalTrail(tokens: tokens, safeIndex: safeIndex)
                }
            case .vertical:
                verticalTrail(tokens: tokens, safeIndex: safeIndex)
            }
        }
        .opacity(isEnabled ? theme.opacity.full : theme.opacity.disabled)
        .accessibilityElement(children: .contain)
        .accessibilityLabel(accessibilityLabel(safeIndex: safeIndex))
    }

    private var clampedIndex: Int {
        guard !items.isEmpty else { return 0 }
        return min(max(currentIndex, 0), items.count - 1)
    }

    private func accessibilityLabel(safeIndex: Int) -> String {
        guard !items.isEmpty else { return "Steps" }
        let title = items[safeIndex].title
        return "Step \(safeIndex + 1) of \(items.count), \(title)"
    }

    private func horizontalTrail(tokens: any HIGStepsTokens, safeIndex: Int) -> some View {
        HStack(alignment: .top, spacing: tokens.itemSpacing) {
            ForEach(Array(items.enumerated()), id: \.element.id) { index, item in
                if index > 0 {
                    connector(tokens: tokens, completed: index <= safeIndex, axis: .horizontal)
                }
                stepCell(index: index, item: item, safeIndex: safeIndex, tokens: tokens, axis: .horizontal)
            }
        }
    }

    private func verticalTrail(tokens: any HIGStepsTokens, safeIndex: Int) -> some View {
        VStack(alignment: .leading, spacing: tokens.itemSpacing) {
            ForEach(Array(items.enumerated()), id: \.element.id) { index, item in
                HStack(alignment: .top, spacing: tokens.itemSpacing) {
                    VStack(spacing: 0) {
                        indicator(index: index, safeIndex: safeIndex, tokens: tokens)
                        if index < items.count - 1 {
                            connector(tokens: tokens, completed: index < safeIndex, axis: .vertical)
                        }
                    }
                    stepLabelsInteractive(
                        index: index,
                        item: item,
                        safeIndex: safeIndex,
                        tokens: tokens
                    )
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, (tokens.minTapTarget - tokens.indicatorSize) / 2)
                }
            }
        }
    }

    @ViewBuilder
    private func stepLabelsInteractive(
        index: Int,
        item: HIGStepsItem,
        safeIndex: Int,
        tokens: any HIGStepsTokens
    ) -> some View {
        let body = labels(item: item, index: index, safeIndex: safeIndex, tokens: tokens)
        if let onSelect, index <= safeIndex, isEnabled {
            Button {
                onSelect(index)
            } label: {
                body
            }
            .buttonStyle(.plain)
            .accessibilityLabel("Step \(index + 1), \(item.title)")
        } else {
            body
                .accessibilityElement(children: .combine)
                .accessibilityLabel("Step \(index + 1), \(item.title)")
                .accessibilityValue(statusLabel(index: index, safeIndex: safeIndex))
        }
    }

    @ViewBuilder
    private func stepCell(
        index: Int,
        item: HIGStepsItem,
        safeIndex: Int,
        tokens: any HIGStepsTokens,
        axis: HIGStepsAxis
    ) -> some View {
        let content = VStack(alignment: axis == .horizontal ? .center : .leading, spacing: tokens.labelSpacing) {
            indicator(index: index, safeIndex: safeIndex, tokens: tokens)
            labels(item: item, index: index, safeIndex: safeIndex, tokens: tokens)
        }
        .frame(maxWidth: axis == .horizontal ? .infinity : nil)

        if let onSelect, index <= safeIndex, isEnabled {
            Button {
                onSelect(index)
            } label: {
                content
            }
            .buttonStyle(.plain)
            .accessibilityLabel("Step \(index + 1), \(item.title)")
            .accessibilityHint(index == safeIndex ? "Current step" : "Go to completed step")
        } else {
            content
                .accessibilityElement(children: .combine)
                .accessibilityLabel("Step \(index + 1), \(item.title)")
                .accessibilityValue(statusLabel(index: index, safeIndex: safeIndex))
        }
    }

    private func labels(
        item: HIGStepsItem,
        index: Int,
        safeIndex: Int,
        tokens: any HIGStepsTokens
    ) -> some View {
        let isCurrent = index == safeIndex
        let isCompleted = index < safeIndex

        return VStack(alignment: .leading, spacing: tokens.labelSpacing) {
            Text(item.title)
                .font(tokens.titleFont)
                .foregroundStyle(
                    isCurrent || isCompleted ? theme.colors.labelPrimary : theme.colors.labelSecondary
                )
                .multilineTextAlignment(.leading)
            if let detail = item.detail {
                Text(detail)
                    .font(tokens.detailFont)
                    .foregroundStyle(theme.colors.labelSecondary)
                    .multilineTextAlignment(.leading)
            }
        }
    }

    private func indicator(index: Int, safeIndex: Int, tokens: any HIGStepsTokens) -> some View {
        let isCurrent = index == safeIndex
        let isCompleted = index < safeIndex
        let fill = isCompleted || isCurrent ? theme.colors.accent : theme.colors.fillPrimary
        let foreground = isCompleted || isCurrent ? theme.colors.labelOnAccent : theme.colors.labelSecondary

        return ZStack {
            Circle()
                .fill(fill)
                .frame(width: tokens.indicatorSize, height: tokens.indicatorSize)
                .overlay {
                    Circle()
                        .strokeBorder(
                            isCurrent || isCompleted ? theme.colors.accent : theme.colors.separator,
                            lineWidth: tokens.connectorThickness
                        )
                }

            if isCompleted {
                Image(systemName: "checkmark")
                    .font(tokens.indexFont)
                    .foregroundStyle(foreground)
            } else {
                Text("\(index + 1)")
                    .font(tokens.indexFont)
                    .foregroundStyle(foreground)
            }
        }
        .frame(width: tokens.minTapTarget, height: tokens.minTapTarget)
        .accessibilityHidden(true)
    }

    private func connector(
        tokens: any HIGStepsTokens,
        completed: Bool,
        axis: Axis
    ) -> some View {
        let color = completed ? theme.colors.accent : theme.colors.separator
        return Group {
            switch axis {
            case .horizontal:
                Rectangle()
                    .fill(color)
                    .frame(height: tokens.connectorThickness)
                    .frame(maxWidth: .infinity)
                    .padding(.top, (tokens.minTapTarget - tokens.connectorThickness) / 2)
            case .vertical:
                Rectangle()
                    .fill(color)
                    .frame(width: tokens.connectorThickness)
                    .frame(minHeight: tokens.itemSpacing + tokens.indicatorSize)
            }
        }
        .accessibilityHidden(true)
    }

    private func statusLabel(index: Int, safeIndex: Int) -> String {
        if index < safeIndex { return "Completed" }
        if index == safeIndex { return "Current" }
        return "Upcoming"
    }
}

#if DEBUG
#Preview("HIGSteps — Horizontal") {
    HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        HIGSteps(
            items: [
                HIGStepsItem("Account", detail: "Basics"),
                HIGStepsItem("Profile", detail: "Details"),
                HIGStepsItem("Review", detail: "Confirm"),
            ],
            currentIndex: 1
        )
        .padding()
    }
}

#Preview("HIGSteps — Vertical") {
    HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        HIGSteps(
            items: [
                HIGStepsItem("Cart"),
                HIGStepsItem("Shipping"),
                HIGStepsItem("Payment"),
            ],
            currentIndex: 0,
            axis: .vertical
        )
        .padding()
    }
}
#endif
