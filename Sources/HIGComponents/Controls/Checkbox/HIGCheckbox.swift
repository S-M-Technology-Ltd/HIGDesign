import HIGPlatform
import HIGThemesContract
import SwiftUI

/// A labeled checkbox control styled with HIG semantic tokens.
public struct HIGCheckbox: View {
    private let label: String
    @Binding private var isOn: Bool

    @Environment(\.higTheme) private var theme
    @Environment(\.isEnabled) private var isEnabled

    public init(_ label: String, isOn: Binding<Bool>) {
        self.label = label
        _isOn = isOn
    }

    public var body: some View {
        let tokens = theme.checkbox
        let capabilities = HIGPlatformCapabilities.current
        let minHeight = max(tokens.minHeight, capabilities.minimumTouchTarget)

        Button {
            isOn.toggle()
        } label: {
            HStack(spacing: theme.spacing.item) {
                Image(systemName: isOn ? "checkmark.square.fill" : "square")
                    .foregroundStyle(isOn ? theme.colors.accent : theme.colors.labelSecondary)
                Text(label)
                    .font(tokens.font)
                    .foregroundStyle(theme.colors.labelPrimary)
                Spacer(minLength: 0)
            }
            .frame(minHeight: minHeight, alignment: .leading)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .opacity(isEnabled ? 1 : 0.55)
        .accessibilityLabel(label)
        .accessibilityAddTraits(isOn ? .isSelected : [])
    }
}

#if DEBUG
#Preview("HIGCheckbox") {
    @Previewable @State var rememberMe = true

    HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        HIGCheckbox("Remember me", isOn: $rememberMe)
            .padding()
    }
}
#endif