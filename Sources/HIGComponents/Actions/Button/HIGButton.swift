import HIGPlatform
import HIGThemesContract
import HIGTokensComponent
import HIGTokensRaw
import HIGTokensSemantic
import SwiftUI

public struct HIGButton: View {
    private let title: String
    private let systemImage: String?
    private let role: HIGButtonRole
    private let style: HIGButtonStyle
    private let size: HIGButtonSize
    private let isLoading: Bool
    private let action: () -> Void

    @Environment(\.higTheme) private var theme
    @Environment(\.isEnabled) private var isEnabled
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    public init(
        _ title: String,
        systemImage: String? = nil,
        role: HIGButtonRole = .primary,
        style: HIGButtonStyle = .standard,
        size: HIGButtonSize = .medium,
        isLoading: Bool = false,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.systemImage = systemImage
        self.role = role
        self.style = style
        self.size = size
        self.isLoading = isLoading
        self.action = action
    }

    public var body: some View {
        switch style {
        case .standard:
            standardButton
        case .glass:
            glassButton
        }
    }

    private var standardButton: some View {
        let tokens = theme.button
        let capabilities = HIGPlatformCapabilities.current
        let minHeight = max(tokens.minHeight * size.scale, capabilities.minimumTouchTarget)

        return Button(action: action) {
            buttonLabel(tokens: tokens)
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

    private var glassButton: some View {
        let tokens = theme.button
        let capabilities = HIGPlatformCapabilities.current
        let minHeight = max(tokens.minHeight * size.scale, capabilities.minimumTouchTarget)
        let usesTitleAndIcon = systemImage != nil && !isLoading

        return Button(action: action) {
            Group {
                if usesTitleAndIcon, let systemImage {
                    Label(title, systemImage: systemImage)
                } else {
                    buttonLabel(tokens: tokens)
                }
            }
            .font(tokens.font)
            .frame(maxWidth: role == .primary ? .infinity : nil)
            .frame(minHeight: minHeight)
            .padding(.horizontal, tokens.horizontalPadding * size.scale)
        }
        .modifier(
            HIGButtonGlassStyleModifier(
                role: role,
                controlSize: HIGButtonGlassStyleSupport.controlSize(for: size),
                usesTitleAndIcon: usesTitleAndIcon
            )
        )
        .tint(HIGButtonGlassStyleSupport.tintColor(role: role, colors: theme.colors))
        .disabled(isLoading || !isEnabled)
        .opacity(isEnabled && !isLoading ? theme.opacity.full : theme.opacity.disabled)
        .animation(reduceMotion ? nil : .easeInOut(duration: theme.motion.quick), value: isLoading)
        .accessibilityLabel(title)
        .accessibilityAddTraits(.isButton)
        .accessibilityHint(isLoading ? "Loading" : "")
    }

    @ViewBuilder
    private func buttonLabel(tokens: any HIGButtonTokens) -> some View {
        HIGButtonLabelView(
            title: title,
            systemImage: systemImage,
            isLoading: isLoading,
            font: tokens.font,
            labelSpacing: theme.spacing.compactItem,
            hiddenOpacity: theme.opacity.hidden,
            fullOpacity: theme.opacity.full
        )
    }
}

private struct HIGButtonGlassStyleModifier: ViewModifier {
    let role: HIGButtonRole
    let controlSize: ControlSize
    let usesTitleAndIcon: Bool

    @MainActor
    func body(content: Content) -> some View {
        HIGButtonGlassStyleSupport.apply(
            to: content,
            role: role,
            controlSize: controlSize,
            usesTitleAndIcon: usesTitleAndIcon
        )
    }
}

private struct HIGButtonLabelView: View {
    let title: String
    let systemImage: String?
    let isLoading: Bool
    let font: Font
    let labelSpacing: CGFloat
    let hiddenOpacity: CGFloat
    let fullOpacity: CGFloat

    var body: some View {
        HStack(spacing: labelSpacing) {
            if let systemImage, !isLoading {
                Image(systemName: systemImage)
            }

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
        .font(font)
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
#Preview("HIGButton — Roles") {
    HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        VStack(spacing: HIGSpacing.lg.rawValue) {
            HIGButton("Continue", systemImage: "arrow.right", role: .primary) {}
            HIGButton("Learn More", systemImage: "book", role: .secondary) {}
            HIGButton("Delete", role: .destructive) {}
            HIGButton("Skip", role: .borderless) {}
        }
        .padding()
    }
}

#Preview("HIGButton — Glass") {
    HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        VStack(spacing: HIGSpacing.lg.rawValue) {
            HIGButton("Continue", systemImage: "arrow.right", role: .primary, style: .glass) {}
            HIGButton("Edit Photo", systemImage: "crop", role: .secondary, style: .glass) {}
            HIGButton("Delete", role: .destructive, style: .glass) {}
            HIGButton("Skip", role: .borderless, style: .glass) {}
        }
        .padding()
    }
}

#Preview("HIGButtonLabelView — Loading") {
    HIGButtonLabelView(
        title: "Continue",
        systemImage: "arrow.right",
        isLoading: true,
        font: .body.weight(.semibold),
        labelSpacing: HIGSpacing.sm.rawValue,
        hiddenOpacity: HIGOpacity.hidden.rawValue,
        fullOpacity: HIGOpacity.full.rawValue
    )
    .padding()
}
#endif