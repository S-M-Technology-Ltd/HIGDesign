import HIGPlatform
import HIGThemesContract
import SwiftUI

/// A labeled slider for selecting a value within a bounded range.
public struct HIGSlider: View {
    private let label: String
    @Binding private var value: Double
    private let range: ClosedRange<Double>
    private let step: Double?

    @Environment(\.higTheme) private var theme
    @Environment(\.isEnabled) private var isEnabled

    public init(
        _ label: String,
        value: Binding<Double>,
        in range: ClosedRange<Double>,
        step: Double? = nil
    ) {
        self.label = label
        _value = value
        self.range = range
        self.step = step
    }

    public var body: some View {
        let tokens = theme.slider
        let capabilities = HIGPlatformCapabilities.current
        let minHeight = max(tokens.minHeight, capabilities.minimumTouchTarget)

        VStack(alignment: .leading, spacing: theme.spacing.compactItem) {
            HStack {
                Text(label)
                    .font(tokens.font)
                    .foregroundStyle(theme.colors.labelPrimary)
                Spacer()
                Text(formattedValue)
                    .font(theme.typography.caption)
                    .foregroundStyle(theme.colors.labelSecondary)
                    .monospacedDigit()
            }

            sliderControl
                .tint(theme.colors.accent)
                .frame(minHeight: minHeight)
        }
        .opacity(isEnabled ? theme.opacity.full : theme.opacity.disabled)
        .accessibilityElement(children: .combine)
        .accessibilityLabel(label)
        .accessibilityValue(formattedValue)
    }

    @ViewBuilder
    private var sliderControl: some View {
        #if os(tvOS) || os(watchOS)
        HStack(spacing: theme.spacing.item) {
            Button("Decrease") {
                adjustValue(by: -(step ?? 1))
            }
            .buttonStyle(.bordered)

            Button("Increase") {
                adjustValue(by: step ?? 1)
            }
            .buttonStyle(.bordered)
        }
        #else
        if let step {
            Slider(value: $value, in: range, step: step)
        } else {
            Slider(value: $value, in: range)
        }
        #endif
    }

    private var formattedValue: String {
        if value.rounded() == value {
            String(Int(value))
        } else {
            String(format: "%.1f", value)
        }
    }

    private func adjustValue(by delta: Double) {
        let next = min(max(value + delta, range.lowerBound), range.upperBound)
        value = next
    }
}

#if DEBUG
#Preview("HIGSlider") {
    @Previewable @State var volume = 60.0

    HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        HIGSlider("Volume", value: $volume, in: 0 ... 100, step: 1)
            .padding()
    }
}
#endif