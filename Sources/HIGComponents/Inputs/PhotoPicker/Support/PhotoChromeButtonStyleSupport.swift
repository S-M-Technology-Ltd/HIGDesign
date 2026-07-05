#if os(iOS)
import SwiftUI

/// Shared liquid-glass chrome button styling for photo picker and photo editor toolbars.
enum PhotoChromeButtonStyleSupport {
    @MainActor
    static func applyIconStyle<Content: View>(
        to content: Content,
        controlSize: ControlSize
    ) -> AnyView {
        if #available(iOS 26.0, macOS 26.0, *) {
            return AnyView(
                content
                    .buttonStyle(.glass as GlassButtonStyle)
                    .controlSize(controlSize)
                    .buttonBorderShape(.circle)
                    .labelStyle(.iconOnly)
            )
        }

        return AnyView(
            content
                .buttonStyle(.bordered)
                .controlSize(controlSize)
                .buttonBorderShape(.circle)
                .labelStyle(.iconOnly)
        )
    }

    @MainActor
    static func applyCapsuleStyle<Content: View>(
        to content: Content,
        controlSize: ControlSize,
        usesTitleAndIconLabel: Bool
    ) -> AnyView {
        if #available(iOS 26.0, macOS 26.0, *) {
            return AnyView(
                content
                    .buttonStyle(.glass as GlassButtonStyle)
                    .controlSize(controlSize)
                    .buttonBorderShape(.capsule)
                    .modifier(PhotoChromeCapsuleLabelStyleModifier(usesTitleAndIconLabel: usesTitleAndIconLabel))
            )
        }

        return AnyView(
            content
                .buttonStyle(.bordered)
                .controlSize(controlSize)
                .buttonBorderShape(.capsule)
                .modifier(PhotoChromeCapsuleLabelStyleModifier(usesTitleAndIconLabel: usesTitleAndIconLabel))
        )
    }
}

private struct PhotoChromeCapsuleLabelStyleModifier: ViewModifier {
    let usesTitleAndIconLabel: Bool

    @MainActor
    func body(content: Content) -> some View {
        if usesTitleAndIconLabel {
            content.labelStyle(.titleAndIcon)
        } else {
            content
        }
    }
}
#endif