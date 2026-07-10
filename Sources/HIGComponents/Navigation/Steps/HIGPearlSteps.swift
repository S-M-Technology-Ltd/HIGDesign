import HIGThemesContract
import HIGTokensComponent
import SwiftUI

/// Compact pearl/dot step indicator without per-step labels.
///
/// Inspired by Remark Admin pearls; use ``HIGSteps`` when titles are required.
public struct HIGPearlSteps: View {
    private let count: Int
    private let currentIndex: Int
    private let onSelect: ((Int) -> Void)?

    @Environment(\.higTheme) private var theme
    @Environment(\.isEnabled) private var isEnabled

    /// Creates a pearl step indicator.
    /// - Parameters:
    ///   - count: Total number of pearls (minimum 1).
    ///   - currentIndex: Zero-based active pearl.
    ///   - onSelect: Optional tap handler for navigation between pearls.
    public init(
        count: Int,
        currentIndex: Int,
        onSelect: ((Int) -> Void)? = nil
    ) {
        self.count = max(count, 1)
        self.currentIndex = currentIndex
        self.onSelect = onSelect
    }

    public var body: some View {
        let tokens = theme.pearlSteps
        let safeIndex = min(max(currentIndex, 0), count - 1)

        HStack(spacing: tokens.itemSpacing) {
            ForEach(0..<count, id: \.self) { index in
                if index > 0 {
                    Rectangle()
                        .fill(index <= safeIndex ? theme.colors.accent : theme.colors.separator)
                        .frame(height: tokens.connectorThickness)
                        .frame(maxWidth: .infinity)
                        .accessibilityHidden(true)
                }
                pearl(index: index, safeIndex: safeIndex, tokens: tokens)
            }
        }
        .opacity(isEnabled ? theme.opacity.full : theme.opacity.disabled)
        .accessibilityElement(children: .contain)
        .accessibilityLabel("Step \(safeIndex + 1) of \(count)")
    }

    @ViewBuilder
    private func pearl(
        index: Int,
        safeIndex: Int,
        tokens: any HIGPearlStepsTokens
    ) -> some View {
        let isCurrent = index == safeIndex
        let isCompleted = index < safeIndex
        let size = isCurrent ? tokens.currentPearlSize : tokens.pearlSize
        let fill = (isCurrent || isCompleted) ? theme.colors.accent : theme.colors.fillPrimary

        let circle = Circle()
            .fill(fill)
            .frame(width: size, height: size)
            .overlay {
                Circle()
                    .strokeBorder(
                        isCurrent || isCompleted ? theme.colors.accent : theme.colors.separator,
                        lineWidth: tokens.connectorThickness
                    )
            }
            .frame(width: tokens.minTapTarget, height: tokens.minTapTarget)

        if let onSelect, isEnabled {
            Button {
                onSelect(index)
            } label: {
                circle
            }
            .buttonStyle(.plain)
            .accessibilityLabel("Step \(index + 1)")
            .accessibilityAddTraits(isCurrent ? [.isSelected, .isButton] : .isButton)
        } else {
            circle
                .accessibilityLabel("Step \(index + 1)")
                .accessibilityAddTraits(isCurrent ? .isSelected : [])
        }
    }
}

#if DEBUG
#Preview("HIGPearlSteps") {
    HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        HIGPearlSteps(count: 5, currentIndex: 2)
            .padding()
    }
}
#endif
