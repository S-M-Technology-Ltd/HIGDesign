import SwiftUI

struct HIGRotatingDotsActivityIndicator: View {
    let diameter: CGFloat
    let count: Int
    let color: Color
    let duration: TimeInterval
    let reduceMotion: Bool

    var body: some View {
        GeometryReader { geometry in
            let size = geometry.size
            ForEach(0..<count, id: \.self) { index in
                HIGRotatingDotsActivitySegment(
                    index: index,
                    count: count,
                    size: size,
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

private struct HIGRotatingDotsActivitySegment: View {
    let index: Int
    let count: Int
    let size: CGSize
    let color: Color
    let duration: TimeInterval
    let reduceMotion: Bool

    @State private var scale: CGFloat = 0
    @State private var rotation = 0.0

    var body: some View {
        let dotDiameter = size.width / CGFloat(count)
        let startScale = (CGFloat(count) - CGFloat(index)) / CGFloat(count)
        let endScale = (CGFloat(index) + 1) / CGFloat(count)
        let offsetY = dotDiameter / 2 - size.height / 2

        Circle()
            .fill(color)
            .frame(width: dotDiameter, height: dotDiameter)
            .scaleEffect(scale)
            .offset(y: offsetY)
            .rotationEffect(.degrees(rotation))
            .onAppear {
                startAnimationIfNeeded(startScale: startScale, endScale: endScale)
            }
    }

    private func startAnimationIfNeeded(startScale: CGFloat, endScale: CGFloat) {
        if reduceMotion {
            scale = endScale
            rotation = Double(index) * (360 / Double(count))
            return
        }

        let curveOffset = Double(index) / Double(count)
        let animation = Animation
            .timingCurve(0.5, 0.15 + curveOffset, 0.25, 1, duration: duration)
            .repeatForever(autoreverses: false)

        scale = startScale
        rotation = 0
        withAnimation(animation) {
            rotation = 360
            scale = endScale
        }
    }
}