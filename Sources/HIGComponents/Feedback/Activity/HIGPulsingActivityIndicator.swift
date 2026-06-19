import HIGThemesContract
import HIGTokensComponent
import SwiftUI

struct HIGPulsingActivityIndicator: View {
    let diameter: CGFloat
    let segmentCount: Int
    let color: Color
    let dimmedOpacity: CGFloat
    let duration: TimeInterval
    let reduceMotion: Bool

    var body: some View {
        GeometryReader { geometry in
            let size = geometry.size
            ForEach(0..<segmentCount, id: \.self) { index in
                HIGPulsingActivitySegment(
                    index: index,
                    segmentCount: segmentCount,
                    size: size,
                    color: color,
                    dimmedOpacity: dimmedOpacity,
                    duration: duration,
                    reduceMotion: reduceMotion
                )
            }
            .frame(width: size.width, height: size.height)
        }
        .frame(width: diameter, height: diameter)
    }
}

private struct HIGPulsingActivitySegment: View {
    let index: Int
    let segmentCount: Int
    let size: CGSize
    let color: Color
    let dimmedOpacity: CGFloat
    let duration: TimeInterval
    let reduceMotion: Bool

    @State private var opacity = 1.0

    var body: some View {
        let segmentHeight = size.height / 3.2
        let segmentWidth = segmentHeight / 2
        let angle = 2 * CGFloat.pi / CGFloat(segmentCount) * CGFloat(index)
        let offsetX = (size.width / 2 - segmentHeight / 2) * cos(angle)
        let offsetY = (size.height / 2 - segmentHeight / 2) * sin(angle)

        return RoundedRectangle(cornerRadius: segmentWidth / 2 + 1)
            .fill(color)
            .frame(width: segmentWidth, height: segmentHeight)
            .rotationEffect(Angle(radians: Double(angle + .pi / 2)))
            .offset(x: offsetX, y: offsetY)
            .opacity(opacity)
            .onAppear { startAnimationIfNeeded() }
    }

    private func startAnimationIfNeeded() {
        if reduceMotion {
            opacity = dimmedOpacity
            return
        }

        let delay = Double(index) / Double(segmentCount) / 2
        let animation = Animation.easeInOut(duration: duration)
            .repeatForever(autoreverses: true)
            .delay(delay)

        opacity = 1
        withAnimation(animation) {
            opacity = dimmedOpacity
        }
    }
}