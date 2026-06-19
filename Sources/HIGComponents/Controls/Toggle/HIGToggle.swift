import HIGPlatform
import HIGThemesContract
import SwiftUI

/// A labeled switch control styled with HIG semantic tokens.
public struct HIGToggle: View {
    private let label: String
    @Binding private var isOn: Bool

    @Environment(\.higTheme) private var theme
    @Environment(\.isEnabled) private var isEnabled

    public init(_ label: String, isOn: Binding<Bool>) {
        self.label = label
        _isOn = isOn
    }

    public var body: some View {
        let tokens = theme.toggle
        let capabilities = HIGPlatformCapabilities.current
        let minHeight = max(tokens.minHeight, capabilities.minimumTouchTarget)

        Toggle(isOn: $isOn) {
            Text(label)
                .font(tokens.font)
                .foregroundStyle(theme.colors.labelPrimary)
        }
        #if os(macOS)
        .toggleStyle(.switch)
        #endif
        .frame(minHeight: minHeight, alignment: .leading)
        .opacity(isEnabled ? 1 : 0.55)
        .accessibilityLabel(label)
    }
}

#if DEBUG
#Preview("HIGToggle") {
    @Previewable @State var notificationsEnabled = true

    HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        HIGToggle("Notifications", isOn: $notificationsEnabled)
            .padding()
    }
}
#endif