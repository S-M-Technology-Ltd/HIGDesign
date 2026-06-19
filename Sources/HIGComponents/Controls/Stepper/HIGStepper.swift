import HIGPlatform
import HIGThemesContract
import HIGTokensComponent
import SwiftUI

/// A labeled stepper for incrementing and decrementing integer values.
public struct HIGStepper: View {
    private let label: String
    @Binding private var value: Int
    private let range: ClosedRange<Int>

    @Environment(\.higTheme) private var theme
    @Environment(\.isEnabled) private var isEnabled

    public init(_ label: String, value: Binding<Int>, in range: ClosedRange<Int>) {
        self.label = label
        _value = value
        self.range = range
    }

    public var body: some View {
        let tokens = theme.stepper
        let capabilities = HIGPlatformCapabilities.current
        let minHeight = max(tokens.minHeight, capabilities.minimumTouchTarget)

        VStack(alignment: .leading, spacing: theme.spacing.compactItem) {
            Text(label)
                .font(theme.typography.caption)
                .foregroundStyle(theme.colors.labelSecondary)

            stepperControl(tokens: tokens, minHeight: minHeight)
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel(label)
        .accessibilityValue(String(value))
    }

    @ViewBuilder
    private func stepperControl(tokens: any HIGStepperTokens, minHeight: CGFloat) -> some View {
        #if os(tvOS) || os(watchOS)
        HStack(spacing: theme.spacing.item) {
            Button("Decrease") {
                value = max(value - 1, range.lowerBound)
            }
            .buttonStyle(.bordered)

            Text("\(value)")
                .font(tokens.font)
                .monospacedDigit()
                .frame(minWidth: 32)

            Button("Increase") {
                value = min(value + 1, range.upperBound)
            }
            .buttonStyle(.bordered)
        }
        .frame(minHeight: minHeight, alignment: .leading)
        #else
        Stepper(value: $value, in: range) {
            Text("\(value)")
                .font(tokens.font)
                .foregroundStyle(theme.colors.labelPrimary)
                .monospacedDigit()
        }
        .frame(minHeight: minHeight, alignment: .leading)
        #endif
    }
}

#if DEBUG
#Preview("HIGStepper") {
    @Previewable @State var quantity = 2

    HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        HIGStepper("Quantity", value: $quantity, in: 1 ... 10)
            .padding()
    }
}
#endif