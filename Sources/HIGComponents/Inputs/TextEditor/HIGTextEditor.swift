import HIGPlatform
import HIGThemesContract
import HIGTokensComponent
import SwiftUI

/// A multi-line text editor styled with HIG semantic tokens.
public struct HIGTextEditor: View {
    private let label: String
    @Binding private var text: String

    @Environment(\.higTheme) private var theme
    @Environment(\.isEnabled) private var isEnabled

    public init(_ label: String, text: Binding<String>) {
        self.label = label
        _text = text
    }

    public var body: some View {
        let tokens = theme.textEditor
        let capabilities = HIGPlatformCapabilities.current
        let minHeight = max(tokens.minHeight, capabilities.minimumTouchTarget)

        VStack(alignment: .leading, spacing: theme.spacing.compactItem) {
            Text(label)
                .font(theme.typography.caption)
                .foregroundStyle(theme.colors.labelSecondary)

            styledEditor(tokens: tokens, minHeight: minHeight)
                .opacity(isEnabled ? theme.opacity.full : theme.opacity.disabled)
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel(label)
    }

    @ViewBuilder
    private func styledEditor(tokens: any HIGTextEditorTokens, minHeight: CGFloat) -> some View {
        #if os(tvOS) || os(watchOS)
        TextField("", text: $text, axis: .vertical)
            .font(tokens.font)
            .lineLimit(3 ... 8)
            .padding(.horizontal, tokens.horizontalPadding)
            .padding(.vertical, tokens.verticalPadding)
            .frame(minHeight: minHeight, alignment: .topLeading)
            .foregroundStyle(theme.colors.labelPrimary)
            .background(theme.colors.backgroundSecondary)
            .clipShape(RoundedRectangle(cornerRadius: tokens.cornerRadius, style: .continuous))
            .overlay {
                RoundedRectangle(cornerRadius: tokens.cornerRadius, style: .continuous)
                    .strokeBorder(theme.colors.separator, lineWidth: tokens.borderWidth)
            }
        #else
        let editor = TextEditor(text: $text)
            .font(tokens.font)
            .padding(.horizontal, tokens.horizontalPadding)
            .padding(.vertical, tokens.verticalPadding)
            .frame(minHeight: minHeight)
            .foregroundStyle(theme.colors.labelPrimary)

        #if os(iOS) || os(macOS) || os(visionOS)
        editor
            .scrollContentBackground(.hidden)
            .background(theme.colors.backgroundSecondary)
            .clipShape(RoundedRectangle(cornerRadius: tokens.cornerRadius, style: .continuous))
            .overlay {
                RoundedRectangle(cornerRadius: tokens.cornerRadius, style: .continuous)
                    .strokeBorder(theme.colors.separator, lineWidth: tokens.borderWidth)
            }
        #else
        editor
            .background(theme.colors.backgroundSecondary)
            .clipShape(RoundedRectangle(cornerRadius: tokens.cornerRadius, style: .continuous))
        #endif
        #endif
    }
}

#if DEBUG
#Preview("HIGTextEditor") {
    @Previewable @State var notes = "Add release notes here."

    HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        HIGTextEditor("Notes", text: $notes)
            .padding()
    }
}
#endif