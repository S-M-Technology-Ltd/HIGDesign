import HIGPlatform
import HIGThemesContract
import HIGTokensComponent
import HIGTokensRaw
import SwiftUI

/// A themed circular swatch picker for mutually exclusive color choices.
///
/// Inspired by Remark Admin color selectors; metrics resolve from ``HIGTheme/colorSelector``.
public struct HIGColorSelector<Value: Hashable & Sendable>: View {
    private let label: String?
    private let options: [HIGColorOption<Value>]
    @Binding private var selection: Value

    @Environment(\.higTheme) private var theme
    @Environment(\.isEnabled) private var isEnabled

    /// Creates a color selector.
    /// - Parameters:
    ///   - label: Optional group caption above the swatches.
    ///   - selection: Bound selected value.
    ///   - options: Available color options.
    public init(
        _ label: String? = nil,
        selection: Binding<Value>,
        options: [HIGColorOption<Value>]
    ) {
        self.label = label
        _selection = selection
        self.options = options
    }

    public var body: some View {
        let tokens = theme.colorSelector
        let capabilities = HIGPlatformCapabilities.current
        let target = max(tokens.minTapTarget, capabilities.minimumTouchTarget)

        VStack(alignment: .leading, spacing: tokens.labelSpacing) {
            if let label {
                Text(label)
                    .font(tokens.labelFont)
                    .foregroundStyle(theme.colors.labelSecondary)
            }

            FlowLayout(spacing: tokens.swatchSpacing) {
                ForEach(options) { option in
                    swatchButton(option, tokens: tokens, target: target)
                }
            }
        }
        .opacity(isEnabled ? theme.opacity.full : theme.opacity.disabled)
        .accessibilityElement(children: .contain)
        .accessibilityLabel(label ?? "Color selector")
    }

    private func swatchButton(
        _ option: HIGColorOption<Value>,
        tokens: any HIGColorSelectorTokens,
        target: CGFloat
    ) -> some View {
        let isSelected = selection == option.value

        return Button {
            selection = option.value
        } label: {
            ZStack {
                Circle()
                    .fill(option.color)
                    .frame(width: tokens.swatchSize, height: tokens.swatchSize)
                    .overlay {
                        Circle()
                            .strokeBorder(
                                theme.colors.separator,
                                lineWidth: tokens.selectionRingWidth
                            )
                    }
                    .overlay {
                        if isSelected {
                            Circle()
                                .strokeBorder(
                                    theme.colors.accent,
                                    lineWidth: tokens.selectionRingWidth
                                )
                                .padding(-tokens.selectionRingInset)
                        }
                    }
                    .overlay {
                        if isSelected {
                            ZStack {
                                Circle()
                                    .fill(theme.colors.labelPrimary)
                                    .frame(
                                        width: tokens.checkmarkPointSize + HIGSpacing.xxs.rawValue * 2,
                                        height: tokens.checkmarkPointSize + HIGSpacing.xxs.rawValue * 2
                                    )
                                Image(systemName: "checkmark")
                                    .font(.system(size: tokens.checkmarkPointSize, weight: .bold))
                                    .foregroundStyle(theme.colors.backgroundPrimary)
                            }
                            .accessibilityHidden(true)
                        }
                    }
            }
            .frame(width: target, height: target)
            .contentShape(Circle())
        }
        .buttonStyle(.plain)
        .disabled(!isEnabled)
        .accessibilityLabel(option.label)
        .accessibilityAddTraits(isSelected ? .isSelected : [])
        .accessibilityValue(isSelected ? "Selected" : "Not selected")
    }
}

/// Simple wrapping horizontal layout for swatches.
private struct FlowLayout: Layout {
    var spacing: CGFloat

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let maxWidth = proposal.width ?? .infinity
        var x: CGFloat = 0
        var y: CGFloat = 0
        var rowHeight: CGFloat = 0
        var width: CGFloat = 0

        for subview in subviews {
            let size = subview.sizeThatFits(.unspecified)
            if x + size.width > maxWidth, x > 0 {
                x = 0
                y += rowHeight + spacing
                rowHeight = 0
            }
            rowHeight = max(rowHeight, size.height)
            x += size.width + spacing
            width = max(width, x - spacing)
        }

        return CGSize(width: width, height: y + rowHeight)
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        var x = bounds.minX
        var y = bounds.minY
        var rowHeight: CGFloat = 0

        for subview in subviews {
            let size = subview.sizeThatFits(.unspecified)
            if x + size.width > bounds.maxX, x > bounds.minX {
                x = bounds.minX
                y += rowHeight + spacing
                rowHeight = 0
            }
            subview.place(
                at: CGPoint(x: x, y: y),
                proposal: ProposedViewSize(width: size.width, height: size.height)
            )
            rowHeight = max(rowHeight, size.height)
            x += size.width + spacing
        }
    }
}

#if DEBUG
private enum HIGColorSelectorPreviewSwatch: String, Hashable, Sendable {
    case blue
    case green
    case red
    case purple
}

#Preview("HIGColorSelector") {
    struct HIGColorSelectorPreviewHostView: View {
        @State private var selection = HIGColorSelectorPreviewSwatch.blue
        @Environment(\.higTheme) private var theme

        var body: some View {
            HIGColorSelector(
                "Accent color",
                selection: $selection,
                options: [
                    HIGColorOption(value: .blue, color: theme.colors.accent, label: "Blue"),
                    HIGColorOption(value: .green, color: theme.colors.warning, label: "Green"),
                    HIGColorOption(value: .red, color: theme.colors.destructive, label: "Red"),
                    HIGColorOption(value: .purple, color: theme.colors.fillPrimary, label: "Fill")
                ]
            )
            .padding()
        }
    }

    return HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        HIGColorSelectorPreviewHostView()
    }
}
#endif
