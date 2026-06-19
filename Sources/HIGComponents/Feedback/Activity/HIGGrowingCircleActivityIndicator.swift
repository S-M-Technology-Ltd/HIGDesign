import SwiftUI

struct HIGGrowingCircleActivityIndicator: View {
    let diameter: CGFloat
    let color: Color
    let fadeOpacity: CGFloat
    let duration: TimeInterval
    let reduceMotion: Bool

    @State private var scale: CGFloat = 0
    @State private var opacity = 1.0

    var body: some View {
        Circle()
            .fill(color)
            .scaleEffect(scale)
            .opacity(opacity)
            .frame(width: diameter, height: diameter)
            .onAppear { startAnimationIfNeeded() }
    }

    private func startAnimationIfNeeded() {
        if reduceMotion {
            scale = 1
            opacity = fadeOpacity
            return
        }

        let animation = Animation.easeIn(duration: duration)
            .repeatForever(autoreverses: false)

        scale = 0
        opacity = 1
        withAnimation(animation) {
            scale = 1
            opacity = fadeOpacity
        }
    }
}