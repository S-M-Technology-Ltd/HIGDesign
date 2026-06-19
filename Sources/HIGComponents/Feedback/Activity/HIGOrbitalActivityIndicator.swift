import HIGThemesContract
import HIGTokensComponent
import SwiftUI

struct HIGOrbitalActivityIndicator: View {
    let diameter: CGFloat
    let lineWidth: CGFloat
    let color: Color
    let duration: TimeInterval
    let reduceMotion: Bool

    @State private var progress = 0.0

    var body: some View {
        HIGOrbitalActivityShape(progress: progress)
            .stroke(color, style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
            .frame(width: diameter, height: diameter)
            .onAppear { startAnimationIfNeeded() }
    }

    private func startAnimationIfNeeded() {
        guard !reduceMotion else {
            progress = 0.65
            return
        }

        progress = 0
        withAnimation(.easeIn(duration: duration).repeatForever(autoreverses: false)) {
            progress = 1
        }
    }
}