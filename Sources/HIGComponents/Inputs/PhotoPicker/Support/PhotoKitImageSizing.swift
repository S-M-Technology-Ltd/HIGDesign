#if os(iOS)
import CoreGraphics
import HIGTokensComponent
import Photos

enum PhotoKitImageSizing {
    static let maxImageDimension: CGFloat = 4096

    static func displayScale(
        fallback: CGFloat = HIGSystemPhotoPickerTokens().defaultDisplayScale
    ) -> CGFloat {
        fallback
    }

    static func pixelSize(for pointSize: CGSize, scale: CGFloat) -> CGSize {
        normalizedTargetSize(
            CGSize(
                width: max(pointSize.width * scale, 1),
                height: max(pointSize.height * scale, 1)
            )
        )
    }

    static func normalizedTargetSize(_ size: CGSize) -> CGSize {
        guard size.width.isFinite, size.height.isFinite, size.width > 0, size.height > 0 else {
            return CGSize(width: 300, height: 300)
        }

        let maxSide = max(size.width, size.height)
        guard maxSide > maxImageDimension else {
            return CGSize(width: max(size.width, 1), height: max(size.height, 1))
        }

        let scale = maxImageDimension / maxSide
        return CGSize(
            width: max(size.width * scale, 1),
            height: max(size.height * scale, 1)
        )
    }

    static func gridCellPointSize(
        containerWidth: CGFloat? = nil,
        tokens: any HIGPhotoPickerTokens = HIGSystemPhotoPickerTokens()
    ) -> CGSize {
        let width = containerWidth ?? tokens.fallbackLayoutWidth
        let layout = PickerLayout(tokens: tokens)
        let side = layout.gridCellSideLength(containerWidth: width)
        guard side > 0 else {
            return CGSize(width: 120, height: 120)
        }
        return CGSize(width: side, height: side)
    }

    static func fullSizeTarget(for asset: PHAsset) -> CGSize {
        guard asset.pixelWidth > 0, asset.pixelHeight > 0 else {
            return CGSize(width: maxImageDimension, height: maxImageDimension)
        }
        return normalizedTargetSize(
            CGSize(width: asset.pixelWidth, height: asset.pixelHeight)
        )
    }
}
#endif