import HIGPlatform
import HIGThemesContract
import SwiftUI

/// A labeled menu picker for choosing one value from a list.
public struct HIGPicker<Value: Hashable & Sendable>: View {
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
        let tokens = theme.picker
        let capabilities = HIGPlatformCapabilities.current
        let minHeight = max(tokens.minHeight, capabilities.minimumTouchTarget)

        VStack(alignment: .leading, spacing: theme.spacing.compactItem) {
            Text(label)
                .font(theme.typography.caption)
                .foregroundStyle(theme.colors.labelSecondary)

            pickerControl
            .font(tokens.font)
            .frame(minHeight: minHeight, alignment: .leading)
            .foregroundStyle(theme.colors.labelPrimary)
            .opacity(isEnabled ? theme.opacity.full : theme.opacity.disabled)
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel(label)
    }

    @ViewBuilder
    private var pickerControl: some View {
        Picker(label, selection: $selection) {
            ForEach(options) { option in
                Text(option.label).tag(option.value)
            }
        }
        #if os(watchOS)
        .pickerStyle(.navigationLink)
        #elseif os(tvOS)
        .pickerStyle(.automatic)
        #else
        .pickerStyle(.menu)
        #endif
    }
}

#if DEBUG
private enum HIGPickerPreviewSort: String, Hashable, Sendable {
    case recent
    case title
}

#Preview("HIGPicker") {
    @Previewable @State var sort = HIGPickerPreviewSort.recent

    HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        HIGPicker(
            "Sort By",
            selection: $sort,
            options: [
                HIGRadioOption(value: HIGPickerPreviewSort.recent, label: "Recently Added"),
                HIGRadioOption(value: HIGPickerPreviewSort.title, label: "Title"),
            ]
        )
        .padding()
    }
}
#endif