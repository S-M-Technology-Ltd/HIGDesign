import HIGPlatform
import HIGThemesContract
import HIGTokensComponent
import HIGTokensRaw
import SwiftUI

/// A themed social / account action button for sign-in and share surfaces.
///
/// Inspired by Remark Admin social buttons; uses SF Symbols and HIG semantic
/// colors (not third-party brand palettes). Metrics resolve from ``HIGTheme/socialButton``.
public struct HIGSocialButton: View {
    private let network: HIGSocialNetwork
    private let title: String?
    private let style: HIGSocialButtonStyle
    private let action: () -> Void

    @Environment(\.higTheme) private var theme
    @Environment(\.isEnabled) private var isEnabled

    /// Creates a social button.
    /// - Parameters:
    ///   - network: Account or service network.
    ///   - title: Optional title override; defaults to ``HIGSocialNetwork/defaultTitle``.
    ///   - style: Visual presentation.
    ///   - action: Tap handler.
    public init(
        _ network: HIGSocialNetwork,
        title: String? = nil,
        style: HIGSocialButtonStyle = .filled,
        action: @escaping () -> Void
    ) {
        self.network = network
        self.title = title
        self.style = style
        self.action = action
    }

    public var body: some View {
        let tokens = theme.socialButton
        let capabilities = HIGPlatformCapabilities.current
        let minHeight = max(tokens.minHeight, capabilities.minimumTouchTarget)
        let iconOnlySide = max(tokens.iconOnlySize, capabilities.minimumTouchTarget)
        let resolvedTitle = title ?? network.defaultTitle

        Button(action: action) {
            switch style {
            case .iconOnly:
                Image(systemName: network.systemImage)
                    .font(.system(size: tokens.iconPointSize, weight: .semibold))
                    .foregroundStyle(foregroundColor)
                    .frame(width: iconOnlySide, height: iconOnlySide)
                    .background(backgroundColor)
                    .clipShape(Circle())
            case .filled:
                labelContent(tokens: tokens, title: resolvedTitle, minHeight: minHeight)
                    .foregroundStyle(foregroundColor)
                    .background(backgroundColor)
                    .clipShape(
                        RoundedRectangle(cornerRadius: tokens.cornerRadius, style: .continuous)
                    )
            case .bordered:
                labelContent(tokens: tokens, title: resolvedTitle, minHeight: minHeight)
                    .foregroundStyle(foregroundColor)
                    .background(backgroundColor)
                    .clipShape(
                        RoundedRectangle(cornerRadius: tokens.cornerRadius, style: .continuous)
                    )
                    .overlay {
                        RoundedRectangle(cornerRadius: tokens.cornerRadius, style: .continuous)
                            .strokeBorder(theme.colors.separator, lineWidth: tokens.borderWidth)
                    }
            }
        }
        .buttonStyle(.plain)
        .disabled(!isEnabled)
        .opacity(isEnabled ? theme.opacity.full : theme.opacity.disabled)
        .accessibilityLabel(style == .iconOnly ? network.accessibilityName : resolvedTitle)
        .accessibilityAddTraits(.isButton)
    }

    private func labelContent(
        tokens: any HIGSocialButtonTokens,
        title: String,
        minHeight: CGFloat
    ) -> some View {
        HStack(spacing: tokens.iconTitleSpacing) {
            Image(systemName: network.systemImage)
                .font(.system(size: tokens.iconPointSize, weight: .semibold))
            Text(title)
                .font(tokens.font)
                .lineLimit(1)
        }
        .frame(maxWidth: .infinity)
        .frame(minHeight: minHeight)
        .padding(.horizontal, tokens.horizontalPadding)
    }

    private var foregroundColor: Color {
        switch style {
        case .filled:
            theme.colors.labelOnAccent
        case .bordered, .iconOnly:
            theme.colors.labelPrimary
        }
    }

    private var backgroundColor: Color {
        switch style {
        case .filled:
            theme.colors.accent
        case .bordered:
            theme.colors.backgroundSecondary
        case .iconOnly:
            theme.colors.fillPrimary
        }
    }
}

#if DEBUG
#Preview("HIGSocialButton") {
    HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        VStack(spacing: HIGSpacing.md.rawValue) {
            HIGSocialButton(.apple) {}
            HIGSocialButton(.google, style: .bordered) {}
            HStack(spacing: HIGSpacing.sm.rawValue) {
                HIGSocialButton(.gitHub, style: .iconOnly) {}
                HIGSocialButton(.email, style: .iconOnly) {}
                HIGSocialButton(.website, style: .iconOnly) {}
            }
        }
        .padding()
    }
}
#endif
