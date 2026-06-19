import SwiftUI

struct HIGScalingDotsActivityIndicator: View {
    let diameter: CGFloat
    let count: Int
    let inset: CGFloat
    let minScale: CGFloat
    let color: Color
    let duration: TimeInterval
    let reduceMotion: Bool

    var body: some View {
        GeometryReader { geometry in
            let size = geometry.size
            ForEach(0..<count, id: \.self) { index in
                HIGScalingDotsActivitySegment(
                    index: index,
                    count: count,
                    inset: inset,
                    size: size,
                    minScale: minScale,
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

private struct HIGScalingDotsActivitySegment: View {
    let index: Int
    let count: Int
    let inset: CGFloat
    let size: CGSize
    let minScale: CGFloat
    let color: Color
    let duration: TimeInterval
    let reduceMotion: Bool

    @State private var scale: CGFloat = 1

    var body: some View {
        let itemSize = (size.width - inset * CGFloat(count - 1)) / CGFloat(count)
        let offsetX = (itemSize + inset) * CGFloat(index) - size.width / 2 + itemSize / 2

        Circle()
            .fill(color)
            .frame(width: itemSize, height: itemSize)
            .scaleEffect(scale)
            .offset(x: offsetX)
            .onAppear { startAnimationIfNeeded() }
    }

    private func startAnimationIfNeeded() {
        if reduceMotion {
            scale = minScale
            return
        }

        let delay = Double(index) / Double(count) / 2
        let animation = Animation.easeOut(duration: duration)
            .repeatForever(autoreverses: true)
            .delay(delay)

        scale = 1
        withAnimation(animation) {
            scale = minScale
        }
    }
}