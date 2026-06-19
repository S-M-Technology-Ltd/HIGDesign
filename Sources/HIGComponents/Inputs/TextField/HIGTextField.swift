import HIGPlatform
import HIGThemesContract
import SwiftUI

/// A single-line text input styled with HIG semantic tokens and theme colors.
public struct HIGTextField: View {
    private let label: String
    private let placeholder: String
    @Binding private var text: String

    @Environment(\.higTheme) private var theme
    @Environment(\.isEnabled) private var isEnabled

    public init(
        _ label: String,
        text: Binding<String>,
        placeholder: String = ""
    ) {
        self.label = label
        _text = text
        self.placeholder = placeholder
    }

    public var body: some View {
        let tokens = theme.textField
        let capabilities = HIGPlatformCapabilities.current
        let minHeight = max(tokens.minHeight, capabilities.minimumTouchTarget)

        VStack(alignment: .leading, spacing: theme.spacing.compactItem) {
            Text(label)
                .font(theme.typography.caption)
                .foregroundStyle(theme.colors.labelSecondary)

            TextField(placeholder, text: $text)
                .font(tokens.font)
                .textFieldStyle(.plain)
                .padding(.horizontal, tokens.horizontalPadding)
                .frame(minHeight: minHeight)
                .background(theme.colors.backgroundSecondary)
                .clipShape(RoundedRectangle(cornerRadius: tokens.cornerRadius, style: .continuous))
                .overlay {
                    RoundedRectangle(cornerRadius: tokens.cornerRadius, style: .continuous)
                        .strokeBorder(theme.colors.separator, lineWidth: tokens.borderWidth)
                }
                .foregroundStyle(theme.colors.labelPrimary)
                .opacity(isEnabled ? 1 : 0.55)
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel(label)
        .accessibilityValue(text.isEmpty ? placeholder : text)
    }
}

#if DEBUG
import HIGTokensComponent
import HIGTokensSemantic

private struct HIGTextFieldPreviewTheme: HIGTheme {
    let name = "Preview"
    let colors: any HIGColorSemanticTokens = HIGSystemColorSemanticTokens()
    let typography: any HIGTypographySemanticTokens = HIGSystemTypographySemanticTokens()
    let spacing: any HIGSpacingSemanticTokens = HIGSystemSpacingSemanticTokens()
    let button: any HIGButtonTokens = HIGSystemButtonTokens()
    let textField: any HIGTextFieldTokens = HIGSystemTextFieldTokens()
    let toggle: any HIGToggleTokens = HIGSystemToggleTokens()
}

#Preview("HIGTextField") {
    @Previewable @State var name = ""

    HIGThemeableView(theme: HIGTextFieldPreviewTheme()) {
        HIGTextField("Full name", text: $name, placeholder: "Enter your name")
            .padding()
    }
}
#endif