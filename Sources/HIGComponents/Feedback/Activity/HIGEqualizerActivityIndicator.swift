import SwiftUI

struct HIGEqualizerActivityIndicator: View {
    let diameter: CGFloat
    let barCount: Int
    let cornerRadius: CGFloat
    let minScale: CGFloat
    let color: Color
    let duration: TimeInterval
    let reduceMotion: Bool

    var body: some View {
        GeometryReader { geometry in
            let size = geometry.size
            ForEach(0..<barCount, id: \.self) { index in
                HIGEqualizerActivitySegment(
                    index: index,
                    barCount: barCount,
                    size: size,
                    cornerRadius: cornerRadius,
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

private struct HIGEqualizerActivitySegment: View {
    let index: Int
    let barCount: Int
    let size: CGSize
    let cornerRadius: CGFloat
    let minScale: CGFloat
    let color: Color
    let duration: TimeInterval
    let reduceMotion: Bool

    @State private var scale: CGFloat = 1

    var body: some View {
        let barWidth = size.width / CGFloat(barCount) / 2
        let offsetX = 2 * barWidth * CGFloat(index) - size.width / 2 + barWidth / 2

        RoundedRectangle(cornerRadius: cornerRadius)
            .fill(color)
            .frame(width: barWidth, height: size.height)
            .scaleEffect(x: 1, y: scale, anchor: .center)
            .offset(x: offsetX)
            .onAppear { startAnimationIfNeeded() }
    }

    private func startAnimationIfNeeded() {
        if reduceMotion {
            scale = minScale
            return
        }

        let delay = Double(index) / Double(barCount) / 2
        let animation = Animation.easeOut(duration: duration)
            .delay(duration / 5)
            .repeatForever(autoreverses: true)
            .delay(delay)

        scale = 1
        withAnimation(animation) {
            scale = minScale
        }
    }
}