import SwiftUI

/// Animatable arc shape used by the orbital activity indicator style.
struct HIGOrbitalActivityShape: Shape {
    var progress: Double

    var animatableData: Double {
        get { progress }
        set { progress = newValue }
    }

    func path(in rect: CGRect) -> Path {
        let maxLength = 2 * Double.pi - 0.7
        let lag = 0.35
        let normalized = progress * 2
        var length = normalized * maxLength

        if normalized > 1, normalized < lag + 1 {
            length = maxLength
        } else if normalized > lag + 1 {
            let coefficient = 1 / (1 - lag)
            let remainder = normalized - 1 - lag
            length = (1 - remainder * coefficient) * maxLength
        }

        let leadingAngle = Double.pi / 2
        let trailingSweep = 4 * Double.pi - leadingAngle
        var endAngle = normalized * leadingAngle
        if normalized > 1 {
            endAngle = leadingAngle + (normalized - 1) * trailingSweep
        }

        let startAngle = endAngle + length
        let radius = min(rect.width, rect.height) / 2
        let center = CGPoint(x: rect.midX, y: rect.midY)

        var path = Path()
        path.addArc(
            center: center,
            radius: radius,
            startAngle: Angle(radians: startAngle),
            endAngle: Angle(radians: endAngle),
            clockwise: true
        )
        return path
    }
}