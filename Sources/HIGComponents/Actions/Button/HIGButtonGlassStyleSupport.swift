import HIGTokensSemantic
import SwiftUI

enum HIGButtonGlassStyleSupport {
    @MainActor
    static func apply<Content: View>(
        to content: Content,
        role: HIGButtonRole,
        controlSize: ControlSize,
        usesTitleAndIcon: Bool
    ) -> AnyView {
        if #available(iOS 26.0, macOS 26.0, *) {
            return AnyView(
                content
                    .modifier(HIGButtonNativeGlassStyleModifier(role: role))
                    .controlSize(controlSize)
                    .buttonBorderShape(.capsule)
                    .modifier(HIGButtonGlassLabelStyleModifier(usesTitleAndIcon: usesTitleAndIcon))
            )
        }

        return AnyView(
            content
                .modifier(HIGButtonNativeGlassFallbackStyleModifier(role: role))
                .controlSize(controlSize)
                .buttonBorderShape(.capsule)
                .modifier(HIGButtonGlassLabelStyleModifier(usesTitleAndIcon: usesTitleAndIcon))
        )
    }

    static func controlSize(for size: HIGButtonSize) -> ControlSize {
        switch size {
        case .small: .small
        case .medium: .regular
        case .large: .large
        }
    }

    static func tintColor(role: HIGButtonRole, colors: any HIGColorSemanticTokens) -> Color {
        switch role {
        case .primary, .secondary, .borderless:
            colors.accent
        case .destructive:
            colors.destructive
        }
    }
}

@available(iOS 26.0, macOS 26.0, *)
private struct HIGButtonNativeGlassStyleModifier: ViewModifier {
    let role: HIGButtonRole

    @MainActor
    func body(content: Content) -> some View {
        switch role {
        case .primary:
            content.buttonStyle(.glassProminent)
        case .secondary, .destructive, .borderless:
            content.buttonStyle(.glass)
        }
    }
}

private struct HIGButtonNativeGlassFallbackStyleModifier: ViewModifier {
    let role: HIGButtonRole

    @MainActor
    func body(content: Content) -> some View {
        switch role {
        case .primary:
            content.buttonStyle(.borderedProminent)
        case .borderless:
            content.buttonStyle(.borderless)
        case .secondary, .destructive:
            content.buttonStyle(.bordered)
        }
    }
}

private struct HIGButtonGlassLabelStyleModifier: ViewModifier {
    let usesTitleAndIcon: Bool

    @MainActor
    func body(content: Content) -> some View {
        if usesTitleAndIcon {
            content.labelStyle(.titleAndIcon)
        } else {
            content.labelStyle(.titleOnly)
        }
    }
}