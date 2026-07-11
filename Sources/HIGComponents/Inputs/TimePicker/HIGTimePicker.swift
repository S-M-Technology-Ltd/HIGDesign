import HIGPlatform
import HIGThemesContract
import SwiftUI

/// A labeled time picker styled with HIG semantic tokens.
///
/// Wraps SwiftUI ``DatePicker`` with hour and minute components. Use ``HIGDatePicker`` for dates.
public struct HIGTimePicker: View {
    private let label: String
    @Binding private var selection: Date

    @Environment(\.higTheme) private var theme
    @Environment(\.isEnabled) private var isEnabled

    /// Creates a time picker.
    /// - Parameters:
    ///   - label: Caption above the control.
    ///   - selection: Bound date value (time components are used).
    public init(
        _ label: String,
        selection: Binding<Date>
    ) {
        self.label = label
        _selection = selection
    }

    public var body: some View {
        let tokens = theme.timePicker
        let capabilities = HIGPlatformCapabilities.current
        let minHeight = max(tokens.minHeight, capabilities.minimumTouchTarget)

        VStack(alignment: .leading, spacing: theme.spacing.compactItem) {
            Text(label)
                .font(theme.typography.caption)
                .foregroundStyle(theme.colors.labelSecondary)

            styledTimePicker
                .font(tokens.font)
                .frame(minHeight: minHeight, alignment: .leading)
                .labelsHidden()
                .tint(theme.colors.accent)
                .opacity(isEnabled ? theme.opacity.full : theme.opacity.disabled)
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel(label)
    }

    @ViewBuilder
    private var styledTimePicker: some View {
        let picker = DatePicker(
            label,
            selection: $selection,
            displayedComponents: .hourAndMinute
        )
        #if os(iOS) || os(visionOS)
        picker.datePickerStyle(.compact)
        #elseif os(macOS)
        picker.datePickerStyle(.field)
        #else
        picker.datePickerStyle(.automatic)
        #endif
    }
}

#if DEBUG
#Preview("HIGTimePicker") {
    @Previewable @State var time = Date()

    HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        HIGTimePicker("Start time", selection: $time)
            .padding()
    }
}
#endif
