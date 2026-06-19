import HIGPlatform
import HIGThemesContract
import SwiftUI

/// A segmented picker for switching between a small set of related views.
public struct HIGSegmentedControl<Value: Hashable & Sendable>: View {
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
        let tokens = theme.segmentedControl
        let capabilities = HIGPlatformCapabilities.current
        let minHeight = max(tokens.minHeight, capabilities.minimumTouchTarget)

        VStack(alignment: .leading, spacing: theme.spacing.compactItem) {
            Text(label)
                .font(theme.typography.caption)
                .foregroundStyle(theme.colors.labelSecondary)

            segmentedPicker
                .frame(minHeight: minHeight)
                .font(tokens.font)
                .opacity(isEnabled ? theme.opacity.full : theme.opacity.disabled)
        }
        .accessibilityElement(children: .contain)
        .accessibilityLabel(label)
    }

    @ViewBuilder
    private var segmentedPicker: some View {
        Picker(label, selection: $selection) {
            ForEach(options) { option in
                Text(option.label).tag(option.value)
            }
        }
        #if os(iOS) || os(macOS) || os(visionOS)
        .pickerStyle(.segmented)
        #else
        .pickerStyle(.automatic)
        #endif
    }
}

#if DEBUG
private enum HIGSegmentedPreviewTab: String, Hashable, Sendable {
    case all
    case unread
}

#Preview("HIGSegmentedControl") {
    @Previewable @State var filter = HIGSegmentedPreviewTab.all

    HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        HIGSegmentedControl(
            "Inbox Filter",
            selection: $filter,
            options: [
                HIGRadioOption(value: HIGSegmentedPreviewTab.all, label: "All"),
                HIGRadioOption(value: HIGSegmentedPreviewTab.unread, label: "Unread"),
            ]
        )
        .padding()
    }
}
#endif