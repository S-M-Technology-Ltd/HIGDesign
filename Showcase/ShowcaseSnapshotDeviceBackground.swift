import CoreGraphics
import Foundation

/// Device-frame asset and screen inset metadata for platform showcase snapshots.
public struct ShowcaseSnapshotDeviceBackground: Sendable {
    /// How rendered app content is fitted into the frame placement rect.
    public enum ContentPlacement: Sendable {
        /// Flood-filled transparent cutout; content is aspect-filled (iOS device frames).
        case transparentCutout
        /// Bright placeholder window on a desktop frame; content is aspect-fit (macOS).
        case placeholderWindow
    }

    public struct ScreenInsetFractions: Sendable {
        public let top: CGFloat
        public let leading: CGFloat
        public let bottom: CGFloat
        public let trailing: CGFloat

        public init(top: CGFloat, leading: CGFloat, bottom: CGFloat, trailing: CGFloat) {
            self.top = top
            self.leading = leading
            self.bottom = bottom
            self.trailing = trailing
        }

        public func screenRect(in canvasSize: CGSize) -> CGRect {
            let x = canvasSize.width * leading
            let y = canvasSize.height * top
            let width = canvasSize.width * (1 - leading - trailing)
            let height = canvasSize.height * (1 - top - bottom)
            return CGRect(x: x, y: y, width: width, height: height)
        }
    }

    public let platform: ShowcaseSnapshotPlatform
    public let imageResourceName: String
    public let pixelSize: CGSize
    public let screenInsets: ScreenInsetFractions
    public let contentPlacement: ContentPlacement

    public init(
        platform: ShowcaseSnapshotPlatform,
        imageResourceName: String,
        pixelSize: CGSize,
        screenInsets: ScreenInsetFractions,
        contentPlacement: ContentPlacement
    ) {
        self.platform = platform
        self.imageResourceName = imageResourceName
        self.pixelSize = pixelSize
        self.screenInsets = screenInsets
        self.contentPlacement = contentPlacement
    }

    /// Point size for a @2x render matching the bundled PNG pixel dimensions.
    public var canvasPointSize: CGSize {
        CGSize(width: pixelSize.width / 2, height: pixelSize.height / 2)
    }

    public func screenRect(in canvasSize: CGSize? = nil) -> CGRect {
        screenInsets.screenRect(in: canvasSize ?? canvasPointSize)
    }
}