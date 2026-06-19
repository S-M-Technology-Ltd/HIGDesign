/// Visual style for ``HIGActivityIndicator``.
public enum HIGActivityIndicatorStyle: Sendable {
    /// Native `ProgressView` spinner (default, HIG-recommended).
    case system
    /// Token-backed growing arc for branded loading states.
    case orbital
    /// Token-backed radial pulsing segments for decorative loading states.
    case pulsing
}