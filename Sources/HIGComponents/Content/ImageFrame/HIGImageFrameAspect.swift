import CoreGraphics

/// Aspect ratio presets for ``HIGImageFrame``.
public enum HIGImageFrameAspect: Sendable, Equatable {
    /// 1:1 square crop frame.
    case square
    /// 4:3 photo frame.
    case photo
    /// 16:9 widescreen frame.
    case widescreen
    /// No forced aspect; height follows content with a minimum.
    case flexible

    /// Width divided by height when a fixed ratio applies.
    public var ratio: CGFloat? {
        switch self {
        case .square:
            1
        case .photo:
            4.0 / 3.0
        case .widescreen:
            16.0 / 9.0
        case .flexible:
            nil
        }
    }
}
