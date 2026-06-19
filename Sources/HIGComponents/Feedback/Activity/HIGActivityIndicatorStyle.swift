/// Visual style for ``HIGActivityIndicator``.
public enum HIGActivityIndicatorStyle: Sendable, CaseIterable {
    /// Native `ProgressView` spinner (default, HIG-recommended).
    case system
    /// Token-backed growing arc (`growingArc`).
    case orbital
    /// Token-backed radial pulsing segments (`default`).
    case pulsing
    /// Concentric rotating arcs.
    case arcs
    /// Dots that orbit while scaling.
    case rotatingDots
    /// Radial dots that flicker in opacity and scale.
    case flickeringDots
    /// Horizontally aligned dots that scale in sequence.
    case scalingDots
    /// Horizontally aligned dots that pulse opacity.
    case opacityDots
    /// Vertical bars that scale like an equalizer.
    case equalizer
    /// Expanding circle that fades out.
    case growingCircle
    /// Rotating conic gradient ring.
    case gradient
}