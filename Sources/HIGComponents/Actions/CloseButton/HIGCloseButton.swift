import HIGThemesContract
import HIGTokensComponent
import SwiftUI

/// A standard dismiss control for modals, sheets, and panels.
public struct HIGCloseButton: View {
    private let accessibilityLabelText: String
    private let action: () -> Void

    @Environment(\.higTheme) private var theme
    @Environment(\.isEnabled) private var isEnabled

    /// Creates a close button.
    /// - Parameters:
    ///   - accessibilityLabel: VoiceOver label (defaults to "Close").
    ///   - action: Invoked when the control is activated.
    public init(
        accessibilityLabel accessibilityLabelText: String = "Close",
        action: @escaping () -> Void
    ) {
        self.accessibilityLabelText = accessibilityLabelText
        self.action = action
    }

    public var body: some View {
        let tokens = theme.closeButton

        Button(action: action) {
            Image(systemName: "xmark")
                .font(.system(size: tokens.iconPointSize, weight: .semibold))
                .foregroundStyle(theme.colors.labelSecondary)
                .frame(width: tokens.minTapTarget, height: tokens.minTapTarget)
                .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .disabled(!isEnabled)
        .opacity(isEnabled ? theme.opacity.full : theme.opacity.disabled)
        .accessibilityLabel(accessibilityLabelText)
        .accessibilityAddTraits(.isButton)
    }
}

#if DEBUG
#Preview("HIGCloseButton") {
    HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        HIGCloseButton {}
            .padding()
    }
}
#endif
