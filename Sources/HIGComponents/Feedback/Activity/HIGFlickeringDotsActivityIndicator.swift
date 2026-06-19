import SwiftUI

struct HIGFlickeringDotsActivityIndicator: View {
    let diameter: CGFloat
    let count: Int
    let color: Color
    let minScale: CGFloat
    let minOpacity: CGFloat
    let duration: TimeInterval
    let reduceMotion: Bool

    var body: some View {
        GeometryReader { geometry in
            let size = geometry.size
            ForEach(0..<count, id: \.self) { index in
                HIGFlickeringDotsActivitySegment(
                    index: index,
                    count: count,
                    size: size,
                    color: color,
                    minScale: minScale,
                    minOpacity: minOpacity,
                    duration: duration,
                    reduceMotion: reduceMotion
                )
            }
            .frame(width: size.width, height: size.height)
        }
        .frame(width: diameter, height: diameter)
    }
}

private struct HIGFlickeringDotsActivitySegment: View {
    let index: Int
    let count: Int
    let size: CGSize
    let color: Color
    let minScale: CGFloat
    let minOpacity: CGFloat
    let duration: TimeInterval
    let reduceMotion: Bool

    @State private var scale: CGFloat = 1
    @State private var opacity = 1.0

    var body: some View {
        let dotDiameter = size.height / CGFloat(count)
        let angle = 2 * CGFloat.pi / CGFloat(count) * CGFloat(index)
        let offsetX = (size.width / 2 - dotDiameter / 2) * cos(angle)
        let offsetY = (size.height / 2 - dotDiameter / 2) * sin(angle)

        Circle()
            .fill(color)
            .frame(width: dotDiameter, height: dotDiameter)
            .scaleEffect(scale)
            .opacity(opacity)
            .offset(x: offsetX, y: offsetY)
            .onAppear { startAnimationIfNeeded() }
    }

    private func startAnimationIfNeeded() {
        if reduceMotion {
            scale = minScale
            opacity = minOpacity
            return
        }

        let delay = duration * Double(index) / Double(count) * 2
        let animation = Animation.linear(duration: duration)
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