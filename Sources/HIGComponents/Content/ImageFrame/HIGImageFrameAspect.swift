import CoreGraphics

/// Aspect ratio presets for ``HIGImageFrame``.
public enum HIGImageFrameAspect: Sendable, Equatable {
    /// 1:1 square crop frame.
    case square
    /// 4:3 landscape photo frame.
    case photo
    /// 3:4 portrait frame (library tiles, portrait product shots).
    case portrait
    /// 16:9 widescreen frame.
    case widescreen
    /// Explicit width÷height ratio when presets do not match.
    case custom(CGFloat)
    /// No forced aspect; height follows content with a minimum.
    case flexible

    /// Width divided by height when a fixed ratio applies.
    public var ratio: CGFloat? {
        switch self {
        case .square:
            1
        case .photo:
            4.0 / 3.0
        case .portrait:
            3.0 / 4.0
        case .widescreen:
            16.0 / 9.0
        case .custom(let ratio):
            ratio > 0 ? ratio : nil
        case .flexible:
            nil
        }
    }
}
