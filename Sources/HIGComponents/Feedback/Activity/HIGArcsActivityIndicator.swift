import SwiftUI

struct HIGArcsActivityIndicator: View {
    let diameter: CGFloat
    let count: Int
    let lineWidth: CGFloat
    let sweepDegrees: CGFloat
    let rotationSpeed: Double
    let color: Color
    let duration: TimeInterval
    let reduceMotion: Bool

    var body: some View {
        GeometryReader { geometry in
            let size = geometry.size
            ForEach(0..<count, id: \.self) { index in
                HIGArcsActivitySegment(
                    index: index,
                    count: count,
                    size: size,
                    lineWidth: lineWidth,
                    sweepDegrees: sweepDegrees,
                    rotationSpeed: rotationSpeed,
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

private struct HIGArcsActivitySegment: View {
    let index: Int
    let count: Int
    let size: CGSize
    let lineWidth: CGFloat
    let sweepDegrees: CGFloat
    let rotationSpeed: Double
    let color: Color
    let duration: TimeInterval
    let reduceMotion: Bool

    @State private var rotation = 0.0

    var body: some View {
        let radius = size.width / 2 - CGFloat(index) * CGFloat(count)
        let sweep = sweepDegrees + CGFloat(index) * (sweepDegrees / CGFloat(count))

        HIGArcSegmentShape(radius: radius, sweepDegrees: sweep)
            .stroke(color, lineWidth: lineWidth)
            .frame(width: size.width, height: size.height)
            .rotationEffect(.degrees(rotation))
            .onAppear { startAnimationIfNeeded() }
    }

    private func startAnimationIfNeeded() {
        if reduceMotion {
            rotation = Double(index) * (360 / Double(count))
            return
        }

        let speed = rotationSpeed + Double(index) * (rotationSpeed / Double(count))
        let animation = Animation.linear(duration: duration / speed)
            .repeatForever(autoreverses: false)

        rotation = 0
        withAnimation(animation) {
            rotation = 360
        }
    }
}

private struct HIGArcSegmentShape: Shape {
    let radius: CGFloat
    let sweepDegrees: CGFloat

    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addArc(
            center: CGPoint(x: rect.midX, y: rect.midY),
            radius: radius,
            startAngle: .degrees(0),
            endAngle: .degrees(Double(sweepDegrees)),
            clockwise: true
        )
        return path
    }
}