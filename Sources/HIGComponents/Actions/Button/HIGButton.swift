import HIGPlatform
import HIGThemesContract
import HIGTokensRaw
import HIGTokensSemantic
import SwiftUI

public struct HIGButton: View {
    private let title: String
    private let role: HIGButtonRole
    private let size: HIGButtonSize
    private let isLoading: Bool
    private let action: () -> Void

    @Environment(\.higTheme) private var theme
    @Environment(\.isEnabled) private var isEnabled
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    public init(
        _ title: String,
        role: HIGButtonRole = .primary,
        size: HIGButtonSize = .medium,
        isLoading: Bool = false,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.role = role
        self.size = size
        self.isLoading = isLoading
        self.action = action
    }

    public var body: some View {
        let tokens = theme.button
        let capabilities = HIGPlatformCapabilities.current
        let minHeight = max(tokens.minHeight * size.scale, capabilities.minimumTouchTarget)

        Button(action: action) {
            HIGButtonLabelView(
                title: title,
                isLoading: isLoading,
                font: tokens.font,
                hiddenOpacity: theme.opacity.hidden,
                fullOpacity: theme.opacity.full
            )
            .frame(maxWidth: role == .primary ? .infinity : nil)
            .frame(minHeight: minHeight)
            .padding(.horizontal, tokens.horizontalPadding * size.scale)
        }
        .buttonStyle(
            HIGButtonStyleView(
                role: role,
                colors: theme.colors,
                opacity: theme.opacity,
                cornerRadius: tokens.cornerRadius,
                isEnabled: isEnabled,
                isLoading: isLoading
            )
        )
        .disabled(isLoading || !isEnabled)
        .animation(reduceMotion ? nil : .easeInOut(duration: theme.motion.quick), value: isLoading)
        .accessibilityLabel(title)
        .accessibilityAddTraits(.isButton)
        .accessibilityHint(isLoading ? "Loading" : "")
    }
}

private struct HIGButtonLabelView: View {
    let title: String
    let isLoading: Bool
    let font: Font
    let hiddenOpacity: CGFloat
    let fullOpacity: CGFloat

    var body: some View {
        ZStack {
            Text(title)
                .font(font)
                .opacity(isLoading ? hiddenOpacity : fullOpacity)
            if isLoading {
                ProgressView()
                    .controlSize(.small)
            }
        }
    }
}

private struct HIGButtonStyleView: ButtonStyle {
    let role: HIGButtonRole
    let colors: any HIGColorSemanticTokens
    let opacity: any HIGOpacitySemanticTokens
    let cornerRadius: CGFloat
    let isEnabled: Bool
    let isLoading: Bool

    func makeBody(configuration: Configuration) -> some View {
        let background = backgroundColor(isPressed: configuration.isPressed)
        let foreground = foregroundColor

        configuration.label
            .foregroundStyle(foreground)
            .background(background)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
            .opacity(isEnabled && !isLoading ? opacity.full : opacity.disabled)
    }

    private var foregroundColor: Color {
        switch role {
        case .primary:
            colors.labelOnAccent
        case .secondary, .borderless:
            colors.accent
        case .destructive:
            colors.destructive
        }
    }

    private func backgroundColor(isPressed: Bool) -> Color {
        switch role {
        case .primary:
            colors.accent.opacity(isPressed ? opacity.pressedPrimary : opacity.full)
        case .secondary:
            colors.fillPrimary.opacity(isPressed ? opacity.pressedSecondary : opacity.full)
        case .destructive:
            colors.destructive.opacity(opacity.subtleFill)
        case .borderless:
            .clear
        }
    }
}

#if DEBUG
#Preview("HIGButton — Primary") {
    HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        VStack(spacing: HIGSpacing.lg.rawValue) {
            HIGButton("Continue", role: .primary) {}
            HIGButton("Cancel", role: .secondary) {}
            HIGButton("Delete", role: .destructive) {}
        }
        .padding()
    }
}

#Preview("HIGButtonLabelView — Loading") {
    HIGButtonLabelView(
        title: "Continue",
        isLoading: true,
        font: .body.weight(.semibold),
        hiddenOpacity: HIGOpacity.hidden.rawValue,
        fullOpacity: HIGOpacity.full.rawValue
    )
        .padding()
}
#endif