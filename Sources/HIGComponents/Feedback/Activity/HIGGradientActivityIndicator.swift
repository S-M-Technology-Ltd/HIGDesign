import SwiftUI

struct HIGGradientActivityIndicator: View {
    let diameter: CGFloat
    let lineWidth: CGFloat
    let trimLeading: CGFloat
    let trimTrailing: CGFloat
    let colors: [Color]
    let duration: TimeInterval
    let reduceMotion: Bool

    @State private var rotation = 0.0

    var body: some View {
        let gradient = AngularGradient(
            gradient: Gradient(colors: colors),
            center: .center,
            startAngle: .zero,
            endAngle: .degrees(360)
        )

        ZStack {
            Circle()
                .stroke(colors.first ?? .clear, lineWidth: lineWidth)

            Circle()
                .trim(from: trimLeading, to: 1 - trimTrailing)
                .stroke(
                    gradient,
                    style: StrokeStyle(lineWidth: lineWidth, lineCap: .round)
                )
                .rotationEffect(.degrees(rotation))
        }
        .frame(width: diameter, height: diameter)
        .onAppear { startAnimationIfNeeded() }
    }

    private func startAnimationIfNeeded() {
        if reduceMotion {
            rotation = 180
            return
        }

        let animation = Animation.linear(duration: duration)
            .repeatForever(autoreverses: false)

        rotation = 0
        withAnimation(animation) {
            rotation = 360
        }
    }
}