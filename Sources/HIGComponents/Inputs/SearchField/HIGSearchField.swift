import HIGPlatform
import HIGThemesContract
import SwiftUI

/// A search field with icon affordance and HIG text-field styling.
public struct HIGSearchField: View {
    private let label: String
    private let placeholder: String
    @Binding private var text: String

    @Environment(\.higTheme) private var theme
    @Environment(\.isEnabled) private var isEnabled

    public init(
        _ label: String,
        text: Binding<String>,
        placeholder: String = "Search"
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

            HStack(spacing: theme.spacing.item) {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(theme.colors.labelSecondary)
                    .accessibilityHidden(true)

                TextField(placeholder, text: $text)
                    .font(tokens.font)
                    .textFieldStyle(.plain)
                    #if os(iOS) || os(visionOS)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    #endif
            }
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
#Preview("HIGSearchField") {
    @Previewable @State var query = ""

    HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        HIGSearchField("Search", text: $query, placeholder: "Search library")
            .padding()
    }
}
#endif