import HIGPlatform
import HIGThemesContract
import SwiftUI

/// A tag chip with a remove affordance for filter and selection flows.
public struct HIGRemovableTag: View {
    private let text: String
    private let style: HIGTagStyle
    private let onRemove: () -> Void

    @Environment(\.higTheme) private var theme
    @Environment(\.isEnabled) private var isEnabled

    public init(
        _ text: String,
        style: HIGTagStyle = .neutral,
        onRemove: @escaping () -> Void
    ) {
        self.text = text
        self.style = style
        self.onRemove = onRemove
    }

    public var body: some View {
        let tokens = theme.tag
        let capabilities = HIGPlatformCapabilities.current
        let removeTarget = max(tokens.removeButtonSize, capabilities.minimumTouchTarget)

        HStack(spacing: tokens.removeSpacing) {
            Text(text)
                .font(tokens.font)
                .foregroundStyle(foregroundColor)

            Button(action: onRemove) {
                Image(systemName: "xmark")
                    .font(.caption2.weight(.bold))
                    .foregroundStyle(removeIconColor)
                    .frame(width: removeTarget, height: removeTarget)
            }
            .buttonStyle(.plain)
            .accessibilityLabel("Remove \(text)")
        }
        .padding(.leading, tokens.horizontalPadding)
        .padding(.trailing, tokens.removeTrailingPadding)
        .padding(.vertical, tokens.verticalPadding)
        .background(backgroundColor)
        .overlay {
            if style == .outline {
                Capsule()
                    .strokeBorder(theme.colors.separator, lineWidth: 1)
            }
        }
        .clipShape(Capsule())
        .opacity(isEnabled ? 1 : 0.55)
        .accessibilityElement(children: .combine)
        .accessibilityLabel("Tag \(text)")
    }

    private var foregroundColor: Color {
        switch style {
        case .neutral:
            theme.colors.labelPrimary
        case .accent:
            Color.white
        case .outline:
            theme.colors.accent
        }
    }

    private var removeIconColor: Color {
        switch style {
        case .neutral, .outline:
            theme.colors.labelSecondary
        case .accent:
            Color.white.opacity(0.9)
        }
    }

    private var backgroundColor: Color {
        switch style {
        case .neutral:
            theme.colors.fillPrimary
        case .accent:
            theme.colors.accent
        case .outline:
            .clear
        }
    }
}

#if DEBUG
#Preview("HIGRemovableTag") {
    HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        HStack(spacing: 12) {
            HIGRemovableTag("Design") {}
            HIGRemovableTag("SwiftUI", style: .accent) {}
            HIGRemovableTag("Beta", style: .outline) {}
        }
        .padding()
    }
}
#endif