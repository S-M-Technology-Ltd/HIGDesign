import HIGPlatform
import HIGThemesContract
import HIGTokensComponent
import SwiftUI

/// A labeled radio group for mutually exclusive choices.
public struct HIGRadio<Value: Hashable & Sendable>: View {
    private let label: String
    @Binding private var selection: Value
    private let options: [HIGRadioOption<Value>]

    @Environment(\.higTheme) private var theme
    @Environment(\.isEnabled) private var isEnabled

    public init(
        _ label: String,
        selection: Binding<Value>,
        options: [HIGRadioOption<Value>]
    ) {
        self.label = label
        _selection = selection
        self.options = options
    }

    public var body: some View {
        let tokens = theme.radio
        let capabilities = HIGPlatformCapabilities.current
        let minHeight = max(tokens.minHeight, capabilities.minimumTouchTarget)

        VStack(alignment: .leading, spacing: theme.spacing.compactItem) {
            Text(label)
                .font(theme.typography.caption)
                .foregroundStyle(theme.colors.labelSecondary)

            VStack(alignment: .leading, spacing: tokens.optionSpacing) {
                ForEach(options) { option in
                    radioRow(option, font: tokens.font, minHeight: minHeight)
                }
            }
        }
        .accessibilityElement(children: .contain)
        .accessibilityLabel(label)
    }

    private func radioRow(
        _ option: HIGRadioOption<Value>,
        font: Font,
        minHeight: CGFloat
    ) -> some View {
        Button {
            selection = option.value
        } label: {
            HStack(spacing: theme.spacing.item) {
                Image(systemName: selection == option.value ? "largecircle.fill.circle" : "circle")
                    .foregroundStyle(selection == option.value ? theme.colors.accent : theme.colors.labelSecondary)
                Text(option.label)
                    .font(font)
                    .foregroundStyle(theme.colors.labelPrimary)
                Spacer(minLength: 0)
            }
            .frame(minHeight: minHeight, alignment: .leading)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .opacity(isEnabled ? 1 : 0.55)
        .accessibilityLabel(option.label)
        .accessibilityAddTraits(selection == option.value ? .isSelected : [])
    }
}

#if DEBUG
private enum HIGRadioPreviewPlan: String, Hashable, Sendable {
    case monthly
    case yearly
}

#Preview("HIGRadio") {
    @Previewable @State var plan = HIGRadioPreviewPlan.monthly

    HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        HIGRadio(
            "Billing",
            selection: $plan,
            options: [
                HIGRadioOption(value: HIGRadioPreviewPlan.monthly, label: "Monthly"),
                HIGRadioOption(value: HIGRadioPreviewPlan.yearly, label: "Yearly"),
            ]
        )
        .padding()
    }
}
#endif