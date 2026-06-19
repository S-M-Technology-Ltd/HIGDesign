import SwiftUI

struct HIGOpacityDotsActivityIndicator: View {
    let diameter: CGFloat
    let count: Int
    let inset: CGFloat
    let minScale: CGFloat
    let minOpacity: CGFloat
    let color: Color
    let duration: TimeInterval
    let reduceMotion: Bool

    var body: some View {
        GeometryReader { geometry in
            let size = geometry.size
            ForEach(0..<count, id: \.self) { index in
                HIGOpacityDotsActivitySegment(
                    index: index,
                    count: count,
                    inset: inset,
                    size: size,
                    minScale: minScale,
                    minOpacity: minOpacity,
                    color: color,
                    duration: duration,
                    reduceMotion: reduceMotion
                )
            }
            .frame(width: size.width, height: size.height)
        }
        .frame(width: diameter, height: diameter)
    }
}

private struct HIGOpacityDotsActivitySegment: View {
    let index: Int
    let count: Int
    let inset: CGFloat
    let size: CGSize
    let minScale: CGFloat
    let minOpacity: CGFloat
    let color: Color
    let duration: TimeInterval
    let reduceMotion: Bool

    @State private var scale: CGFloat = 1
    @State private var opacity = 1.0

    var body: some View {
        let itemSize = (size.width - inset * CGFloat(count - 1)) / CGFloat(count)
        let offsetX = (itemSize + inset) * CGFloat(index) - size.width / 2 + itemSize / 2

        Circle()
            .fill(color)
            .frame(width: itemSize, height: itemSize)
            .scaleEffect(scale)
            .opacity(opacity)
            .offset(x: offsetX)
            .onAppear { startAnimationIfNeeded() }
    }

    private func startAnimationIfNeeded() {
        if reduceMotion {
            scale = minScale
            opacity = minOpacity
            return
        }

        let delay = index.isMultiple(of: 2) ? duration / 2 : 0
        let animation = Animation.easeOut(duration: duration)
            .repeatForever(autoreverses: true)
            .delay(delay)

        scale = 1
        opacity = 1
        withAnimation(animation) {
            scale = minScale
            opacity = minOpacity
        }
    }
}