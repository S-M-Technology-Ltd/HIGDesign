import HIGComponents
import HIGThemesContract
import SwiftUI

extension View {
    /// Presents a themed popover with ``HIGPopoverContainer`` chrome.
    public func higPopover<PopoverContent: View>(
        isPresented: Binding<Bool>,
        attachmentAnchor: PopoverAttachmentAnchor = .rect(.bounds),
        arrowEdge: Edge = .top,
        @ViewBuilder content: @escaping () -> PopoverContent
    ) -> some View {
        modifier(
            HIGPopoverModifier(
                isPresented: isPresented,
                attachmentAnchor: attachmentAnchor,
                arrowEdge: arrowEdge,
                popoverContent: content
            )
        )
    }
}

private struct HIGPopoverModifier<PopoverContent: View>: ViewModifier {
    @Binding var isPresented: Bool
    let attachmentAnchor: PopoverAttachmentAnchor
    let arrowEdge: Edge
    let popoverContent: () -> PopoverContent

    func body(content: Content) -> some View {
        content.popover(
            isPresented: $isPresented,
            attachmentAnchor: attachmentAnchor,
            arrowEdge: arrowEdge
        ) {
            HIGPopoverContainer(content: popoverContent)
                #if os(macOS)
                .frame(minWidth: 200)
                #endif
        }
    }
}
