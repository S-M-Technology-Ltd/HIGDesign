import SwiftUI

/// Composites pixel-matched showcase content into the screen area of a device mockup.
struct ShowcaseSnapshotDeviceFrameView<Content: View>: View {
    let background: ShowcaseSnapshotDeviceBackground
    @ViewBuilder let content: () -> Content

    var body: some View {
        let canvasSize = background.canvasPointSize
        let screenRect = background.screenRect(in: canvasSize)

        ZStack(alignment: .topLeading) {
            content()
                .frame(width: screenRect.width, height: screenRect.height, alignment: .topLeading)
                .clipped()
                .offset(x: screenRect.minX, y: screenRect.minY)

            Image(background.imageResourceName, bundle: .module)
                .resizable()
                .interpolation(.high)
                .frame(width: canvasSize.width, height: canvasSize.height)
                .allowsHitTesting(false)
        }
        .frame(width: canvasSize.width, height: canvasSize.height)
    }
}