import CoreGraphics
import Foundation

public enum HIGPhotoEditorImageProcessor {
    public static func orientedImageSize(for image: CGImage, angle: Int) -> CGSize {
        let normalized = HIGPhotoEditorCropState.normalizedAngle(angle)
        let swapsAxes = normalized == 90 || normalized == 270
        let width = CGFloat(image.width)
        let height = CGFloat(image.height)
        return swapsAxes ? CGSize(width: height, height: width) : CGSize(width: width, height: height)
    }

    public static func fittedCropRegionSize(
        aspect: CGFloat,
        availableSize: CGSize,
        horizontalInset: CGFloat,
        verticalInset: CGFloat,
        minimumSide: CGFloat
    ) -> CGSize {
        let maxWidth = max(availableSize.width - (horizontalInset * 2), minimumSide)
        let maxHeight = max(availableSize.height - (verticalInset * 2), minimumSide)
        guard maxWidth > 0, maxHeight > 0, aspect > 0 else {
            return CGSize(width: minimumSide, height: minimumSide)
        }

        let containerAspect = maxWidth / maxHeight
        let width: CGFloat
        let height: CGFloat

        if aspect > containerAspect {
            width = maxWidth
            height = width / aspect
        } else {
            height = maxHeight
            width = height * aspect
        }

        return CGSize(
            width: max(width, minimumSide),
            height: max(height, minimumSide)
        )
    }

    public static func imageCropRect(
        imageWidth: CGFloat,
        imageHeight: CGFloat,
        cropRegionWidth: CGFloat,
        cropRegionHeight: CGFloat,
        offsetX: CGFloat,
        offsetY: CGFloat,
        scale: CGFloat
    ) -> CGRect {
        guard imageWidth > 0,
              imageHeight > 0,
              cropRegionWidth > 0,
              cropRegionHeight > 0 else {
            return .zero
        }

        let clampedScale = HIGPhotoEditorCropState.clampedScale(scale)
        let baseScale = max(cropRegionWidth / imageWidth, cropRegionHeight / imageHeight)
        let displayWidth = imageWidth * baseScale
        let displayHeight = imageHeight * baseScale
        let zoomedWidth = displayWidth * clampedScale
        let zoomedHeight = displayHeight * clampedScale
        let topLeftX = (cropRegionWidth - zoomedWidth) / 2 + offsetX
        let topLeftY = (cropRegionHeight - zoomedHeight) / 2 + offsetY
        let totalScale = baseScale * clampedScale

        var pixelX = -topLeftX / totalScale
        var pixelY = -topLeftY / totalScale
        var pixelWidth = cropRegionWidth / totalScale
        var pixelHeight = cropRegionHeight / totalScale

        pixelWidth = min(pixelWidth, imageWidth)
        pixelHeight = min(pixelHeight, imageHeight)
        pixelX = min(max(pixelX, 0), max(0, imageWidth - pixelWidth))
        pixelY = min(max(pixelY, 0), max(0, imageHeight - pixelHeight))

        return CGRect(
            x: pixelX.rounded(.down),
            y: pixelY.rounded(.down),
            width: max(1, pixelWidth.rounded(.down)),
            height: max(1, pixelHeight.rounded(.down))
        )
    }

    public static func cropRect(
        for image: CGImage,
        cropState: HIGPhotoEditorCropState
    ) -> CGRect {
        imageCropRect(
            imageWidth: CGFloat(image.width),
            imageHeight: CGFloat(image.height),
            cropRegionWidth: cropState.cropRegionWidth,
            cropRegionHeight: cropState.cropRegionHeight,
            offsetX: cropState.offsetX,
            offsetY: cropState.offsetY,
            scale: cropState.scale
        )
    }

    public static func croppedImage(
        from image: CGImage,
        cropRect: CGRect,
        angle: Int,
        circularClip: Bool
    ) -> CGImage? {
        guard cropRect.width > 0, cropRect.height > 0 else { return nil }

        let normalizedAngle = HIGPhotoEditorCropState.normalizedAngle(angle)
        let outputWidth = Int(cropRect.width.rounded(.down))
        let outputHeight = Int(cropRect.height.rounded(.down))
        guard outputWidth > 0, outputHeight > 0 else { return nil }

        let colorSpace = image.colorSpace ?? CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGImageAlphaInfo.premultipliedLast.rawValue
        guard let context = CGContext(
            data: nil,
            width: outputWidth,
            height: outputHeight,
            bitsPerComponent: 8,
            bytesPerRow: 0,
            space: colorSpace,
            bitmapInfo: bitmapInfo
        ) else {
            return nil
        }

        if circularClip {
            let ellipse = CGRect(x: 0, y: 0, width: outputWidth, height: outputHeight)
            context.addEllipse(in: ellipse)
            context.clip()
        }

        context.translateBy(x: -cropRect.origin.x, y: -cropRect.origin.y)

        if normalizedAngle != 0 {
            let radians = CGFloat(normalizedAngle) * (.pi / 180)
            let imageBounds = CGRect(x: 0, y: 0, width: image.width, height: image.height)
            let rotatedBounds = imageBounds.applying(CGAffineTransform(rotationAngle: radians))
            context.translateBy(x: -rotatedBounds.origin.x, y: -rotatedBounds.origin.y)
            context.rotate(by: radians)
        }

        context.draw(image, in: CGRect(x: 0, y: 0, width: image.width, height: image.height))
        return context.makeImage()
    }

    public static func renderResult(
        from image: CGImage,
        cropState: HIGPhotoEditorCropState,
        croppingStyle: HIGPhotoEditorCroppingStyle,
        aspectRatio: HIGPhotoEditorAspectRatio,
        aspectRatioOrientation: HIGPhotoEditorAspectRatioOrientation
    ) -> HIGPhotoEditorFinishResult? {
        let cropRect = cropRect(for: image, cropState: cropState)
        guard let croppedImage = croppedImage(
            from: image,
            cropRect: cropRect,
            angle: cropState.angle,
            circularClip: croppingStyle == .circular
        ) else {
            return nil
        }

        return HIGPhotoEditorFinishResult(
            croppedImage: croppedImage,
            cropRect: cropRect,
            angle: cropState.angle,
            croppingStyle: croppingStyle,
            aspectRatio: aspectRatio,
            aspectRatioOrientation: aspectRatioOrientation
        )
    }
}