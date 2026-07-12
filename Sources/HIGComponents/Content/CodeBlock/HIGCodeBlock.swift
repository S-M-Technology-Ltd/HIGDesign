import HIGPlatform
import HIGThemesContract
import HIGTokensComponent
import SwiftUI

/// A themed monospaced code surface for docs, API samples, and admin demos.
///
/// Displays plain text (no third-party syntax highlighter). Optional language label
/// and share/copy affordance via SwiftUI ``ShareLink``.
public struct HIGCodeBlock: View {
    private let code: String
    private let language: String?
    private let showsShareButton: Bool

    @Environment(\.higTheme) private var theme
    @Environment(\.isEnabled) private var isEnabled

    /// Creates a code block.
    /// - Parameters:
    ///   - code: Source text to display.
    ///   - language: Optional language caption (for example `"swift"`).
    ///   - showsShareButton: When `true`, shows a share control for the code string.
    public init(
        _ code: String,
        language: String? = nil,
        showsShareButton: Bool = true
    ) {
        self.code = code
        self.language = language
        self.showsShareButton = showsShareButton
    }

    public var body: some View {
        let tokens = theme.codeBlock
        let capabilities = HIGPlatformCapabilities.current
        let minHeight = max(tokens.minHeight, capabilities.minimumTouchTarget)

        VStack(alignment: .leading, spacing: tokens.headerSpacing) {
            if showsHeader {
                headerRow(tokens: tokens, minTarget: capabilities.minimumTouchTarget)
            }

            ScrollView([.horizontal, .vertical], showsIndicators: true) {
                codeText(tokens: tokens)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(minHeight: minHeight, maxHeight: tokens.maxHeight, alignment: .topLeading)
        }
        .padding(.horizontal, tokens.horizontalPadding)
        .padding(.vertical, tokens.verticalPadding)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(theme.colors.backgroundSecondary)
        .clipShape(RoundedRectangle(cornerRadius: tokens.cornerRadius, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: tokens.cornerRadius, style: .continuous)
                .strokeBorder(theme.colors.separator, lineWidth: tokens.borderWidth)
        }
        .opacity(isEnabled ? theme.opacity.full : theme.opacity.disabled)
        .accessibilityElement(children: .combine)
        .accessibilityLabel(accessibilityLabelText)
        .accessibilityValue(code)
    }

    private var showsHeader: Bool {
        language != nil || showsShareButton
    }

    private func headerRow(tokens: any HIGCodeBlockTokens, minTarget: CGFloat) -> some View {
        HStack(spacing: theme.spacing.compactItem) {
            if let language {
                Text(language)
                    .font(tokens.languageFont)
                    .foregroundStyle(theme.colors.labelSecondary)
                    .textCase(.uppercase)
            }

            Spacer(minLength: 0)

            #if os(iOS) || os(macOS) || os(visionOS) || os(watchOS)
            if showsShareButton {
                ShareLink(item: code) {
                    Image(systemName: "square.and.arrow.up")
                        .font(.body.weight(.medium))
                        .foregroundStyle(theme.colors.accent)
                        .frame(width: minTarget, height: minTarget)
                        .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
                .disabled(!isEnabled || code.isEmpty)
                .accessibilityLabel("Share code")
            }
            #endif
        }
    }

    @ViewBuilder
    private func codeText(tokens: any HIGCodeBlockTokens) -> some View {
        let text = Text(code)
            .font(tokens.font)
            .foregroundStyle(theme.colors.labelPrimary)
        #if os(iOS) || os(macOS) || os(visionOS)
        text.textSelection(.enabled)
        #else
        text
        #endif
    }

    private var accessibilityLabelText: String {
        if let language {
            "Code block, \(language)"
        } else {
            "Code block"
        }
    }
}

#if DEBUG
#Preview("HIGCodeBlock") {
    HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        HIGCodeBlock(
            """
            let theme = HIGSystemTheme()
            HIGThemeableView(theme: theme) {
                HIGButton("Save") {}
            }
            """,
            language: "swift"
        )
        .padding()
    }
}
#endif
