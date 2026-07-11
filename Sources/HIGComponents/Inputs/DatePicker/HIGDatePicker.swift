import HIGPlatform
import HIGThemesContract
import SwiftUI

/// A labeled date picker styled with HIG semantic tokens.
///
/// Wraps SwiftUI ``DatePicker`` with date components only. Use ``HIGTimePicker`` for time.
public struct HIGDatePicker: View {
    private let label: String
    @Binding private var selection: Date
    private let range: ClosedRange<Date>?

    @Environment(\.higTheme) private var theme
    @Environment(\.isEnabled) private var isEnabled

    /// Creates a date picker.
    /// - Parameters:
    ///   - label: Caption above the control.
    ///   - selection: Bound date value.
    ///   - in: Optional inclusive date range.
    public init(
        _ label: String,
        selection: Binding<Date>,
        in range: ClosedRange<Date>? = nil
    ) {
        self.label = label
        _selection = selection
        self.range = range
    }

    public var body: some View {
        let tokens = theme.datePicker
        let capabilities = HIGPlatformCapabilities.current
        let minHeight = max(tokens.minHeight, capabilities.minimumTouchTarget)

        VStack(alignment: .leading, spacing: theme.spacing.compactItem) {
            Text(label)
                .font(theme.typography.caption)
                .foregroundStyle(theme.colors.labelSecondary)

            datePickerControl
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
    private var datePickerControl: some View {
        if let range {
            styledDatePicker(
                DatePicker(
                    label,
                    selection: $selection,
                    in: range,
                    displayedComponents: .date
                )
            )
        } else {
            styledDatePicker(
                DatePicker(
                    label,
                    selection: $selection,
                    displayedComponents: .date
                )
            )
        }
    }

    @ViewBuilder
    private func styledDatePicker<Content: View>(_ picker: Content) -> some View {
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
#Preview("HIGDatePicker") {
    @Previewable @State var date = Date()

    HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        HIGDatePicker("Start date", selection: $date)
            .padding()
    }
}
#endif
