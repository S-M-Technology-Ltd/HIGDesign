import HIGPlatform
import HIGThemesContract
import HIGTokensComponent
import HIGTokensRaw
import SwiftUI

/// A themed star rating control for admin reviews and product feedback.
///
/// Supports display-only values and interactive selection via a binding.
/// Inspired by Remark Admin rating widgets; metrics resolve from ``HIGTheme/rating``.
public struct HIGRating: View {
    private let maxValue: Int
    private let label: String?
    private let isEditable: Bool
    @Binding private var value: Int

    @Environment(\.higTheme) private var theme
    @Environment(\.isEnabled) private var isEnabled

    /// Creates a display-only rating.
    /// - Parameters:
    ///   - value: Filled star count (clamped to `0...maxValue`).
    ///   - maxValue: Total star count (must be at least 1).
    ///   - label: Optional caption beside the stars.
    public init(
        value: Int,
        maxValue: Int = 5,
        label: String? = nil
    ) {
        let maxStars = max(maxValue, 1)
        self.maxValue = maxStars
        self.label = label
        self.isEditable = false
        _value = .constant(min(max(value, 0), maxStars))
    }

    /// Creates an interactive rating.
    /// - Parameters:
    ///   - value: Bound filled star count (clamped when changed).
    ///   - maxValue: Total star count (must be at least 1).
    ///   - label: Optional caption beside the stars.
    public init(
        value: Binding<Int>,
        maxValue: Int = 5,
        label: String? = nil
    ) {
        let maxStars = max(maxValue, 1)
        self.maxValue = maxStars
        self.label = label
        self.isEditable = true
        _value = value
    }

    public var body: some View {
        let tokens = theme.rating
        let capabilities = HIGPlatformCapabilities.current
        let target = max(tokens.minTapTarget, capabilities.minimumTouchTarget)
        let filled = min(max(value, 0), maxValue)

        HStack(spacing: tokens.labelSpacing) {
            HStack(spacing: tokens.starSpacing) {
                ForEach(1...maxValue, id: \.self) { index in
                    starButton(index: index, filled: filled, tokens: tokens, target: target)
                }
            }

            if let label {
                Text(label)
                    .font(tokens.labelFont)
                    .foregroundStyle(theme.colors.labelSecondary)
            }
        }
        .opacity(isEnabled ? theme.opacity.full : theme.opacity.disabled)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(accessibilityLabelText)
        .accessibilityValue("\(filled) of \(maxValue)")
        .accessibilityAdjustableAction { direction in
            guard isEditable, isEnabled else { return }
            switch direction {
            case .increment:
                value = min(filled + 1, maxValue)
            case .decrement:
                value = max(filled - 1, 0)
            @unknown default:
                break
            }
        }
    }

    @ViewBuilder
    private func starButton(
        index: Int,
        filled: Int,
        tokens: any HIGRatingTokens,
        target: CGFloat
    ) -> some View {
        let isFilled = index <= filled
        let image = Image(systemName: isFilled ? "star.fill" : "star")
            .font(.system(size: tokens.starPointSize, weight: .semibold))
            .foregroundStyle(isFilled ? theme.colors.warning : theme.colors.separator)
            .frame(width: target, height: target)
            .contentShape(Rectangle())

        if isEditable {
            Button {
                value = index
            } label: {
                image
            }
            .buttonStyle(.plain)
            .disabled(!isEnabled)
            .accessibilityHidden(true)
        } else {
            image
                .accessibilityHidden(true)
        }
    }

    private var accessibilityLabelText: String {
        if let label {
            return "\(label), Rating"
        }
        return isEditable ? "Rating" : "Rating display"
    }
}

#if DEBUG
#Preview("HIGRating") {
    struct HIGRatingPreviewHostView: View {
        @State private var rating = 3

        var body: some View {
            HIGThemeableView(theme: HIGComponentPreviewTheme()) {
                VStack(alignment: .leading, spacing: HIGSpacing.md.rawValue) {
                    HIGRating(value: 4, label: "4.0")
                    HIGRating(value: $rating, label: "Tap to rate")
                }
                .padding()
            }
        }
    }

    return HIGRatingPreviewHostView()
}
#endif
