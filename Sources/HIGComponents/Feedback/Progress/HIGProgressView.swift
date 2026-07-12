import HIGThemesContract
import HIGTokensRaw
import SwiftUI

/// HIG-aligned progress indicator for determinate and indeterminate loading states.
public struct HIGProgressView: View {
    private let label: String?
    private let value: Double?
    private let showsPercentage: Bool

    @Environment(\.higTheme) private var theme
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    /// Creates a progress indicator.
    /// - Parameters:
    ///   - label: Optional caption above the control.
    ///   - value: Determinate progress in `0...1`. Omit for indeterminate.
    ///   - showsPercentage: When `true` and `value` is set, shows a percent caption.
    public init(
        _ label: String? = nil,
        value: Double? = nil,
        showsPercentage: Bool = false
    ) {
        self.label = label
        self.value = value
        self.showsPercentage = showsPercentage
    }

    public var body: some View {
        let tokens = theme.progress
        let clamped = value.map { min(max($0, 0), 1) }

        VStack(alignment: .leading, spacing: theme.spacing.compactItem) {
            if label != nil || (showsPercentage && clamped != nil) {
                HStack {
                    if let label {
                        Text(label)
                            .font(tokens.labelFont)
                            .foregroundStyle(theme.colors.labelSecondary)
                    }
                    Spacer(minLength: theme.spacing.compactItem)
                    if showsPercentage, let clamped {
                        Text("\(Int((clamped * 100).rounded()))%")
                            .font(tokens.labelFont)
                            .foregroundStyle(theme.colors.labelSecondary)
                            .monospacedDigit()
                            .accessibilityHidden(true)
                    }
                }
            }

            if let clamped {
                ProgressView(value: clamped)
                    .tint(theme.colors.accent)
                    .animation(reduceMotion ? nil : .default, value: clamped)
                    .accessibilityValue("\(Int((clamped * 100).rounded())) percent")
            } else {
                ProgressView()
                    .tint(theme.colors.accent)
            }
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel(label ?? "Progress")
    }
}

#if DEBUG
#Preview("HIGProgressView") {
    HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        VStack(alignment: .leading, spacing: HIGSpacing.xl.rawValue) {
            HIGProgressView("Uploading")
            HIGProgressView("Installing", value: 0.62, showsPercentage: true)
        }
        .padding()
    }
}
#endif
