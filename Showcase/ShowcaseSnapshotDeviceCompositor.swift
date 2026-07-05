import CoreGraphics
import Foundation

#if canImport(AppKit)
import AppKit
#elseif canImport(UIKit)
import UIKit
#endif

/// Composites pixel-matched content into a device frame using Core Graphics.
enum ShowcaseSnapshotDeviceCompositor {
    static func composite(
        contentPNG: Data,
        deviceBackground: ShowcaseSnapshotDeviceBackground,
        scale: CGFloat = 2
    ) -> Data? {
        #if canImport(AppKit)
        if deviceBackground.platform == .macos {
            return compositeMacWindowOnMac(
                contentPNG: contentPNG,
                deviceBackground: deviceBackground,
                scale: scale
            )
        }
        #endif

        guard let frameImage = loadFrameImage(named: deviceBackground.imageResourceName),
              let decodedContent = decodePNG(contentPNG),
              let contentImage = normalizedRGBAImage(from: decodedContent) else {
            return nil
        }

        let canvasSize = deviceBackground.canvasPointSize
        let screenRect = deviceBackground.screenRect(in: canvasSize)
        let pixelWidth = Int(canvasSize.width * scale)
        let pixelHeight = Int(canvasSize.height * scale)

        guard pixelWidth > 0, pixelHeight > 0 else { return nil }

        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        guard let context = CGContext(
            data: nil,
            width: pixelWidth,
            height: pixelHeight,
            bitsPerComponent: 8,
            bytesPerRow: pixelWidth * 4,
            space: colorSpace,
            bitmapInfo: bitmapInfo.rawValue
        ) else {
            return nil
        }

        context.interpolationQuality = .high
        context.clear(CGRect(x: 0, y: 0, width: pixelWidth, height: pixelHeight))

        let pixelScreen = CGRect(
            x: screenRect.minX * scale,
            y: screenRect.minY * scale,
            width: screenRect.width * scale,
            height: screenRect.height * scale
        )

        switch deviceBackground.contentPlacement {
        case .transparentCutout:
            drawAspectFilled(contentImage, in: pixelScreen, context: context)
            context.draw(
                frameImage,
                in: CGRect(x: 0, y: 0, width: pixelWidth, height: pixelHeight)
            )
        case .placeholderWindow:
            context.draw(
                frameImage,
                in: CGRect(x: 0, y: 0, width: pixelWidth, height: pixelHeight)
            )
            drawAspectFilled(contentImage, in: pixelScreen, context: context)
        }

        guard let output = context.makeImage() else { return nil }
        return encodePNG(from: output)
    }

    #if canImport(AppKit)
    private static func compositeMacWindowOnMac(
        contentPNG: Data,
        deviceBackground: ShowcaseSnapshotDeviceBackground,
        scale: CGFloat
    ) -> Data? {
        guard let frameURL = Bundle.module.url(
            forResource: deviceBackground.imageResourceName,
            withExtension: "png"
        ),
              let frameImage = NSImage(contentsOf: frameURL),
              let contentImage = NSImage(data: contentPNG) else {
            return nil
        }

        let canvasSize = deviceBackground.canvasPointSize
        let screenRect = deviceBackground.screenRect(in: canvasSize)
        let pixelWidth = Int(canvasSize.width * scale)
        let pixelHeight = Int(canvasSize.height * scale)

        guard pixelWidth > 0, pixelHeight > 0,
              let rep = NSBitmapImageRep(
                bitmapDataPlanes: nil,
                pixelsWide: pixelWidth,
                pixelsHigh: pixelHeight,
                bitsPerSample: 8,
                samplesPerPixel: 4,
                hasAlpha: true,
                isPlanar: false,
                colorSpaceName: .deviceRGB,
                bytesPerRow: 0,
                bitsPerPixel: 0
              ) else {
            return nil
        }

        rep.size = canvasSize

        guard let graphicsContext = NSGraphicsContext(bitmapImageRep: rep) else {
            return nil
        }

        NSGraphicsContext.saveGraphicsState()
        NSGraphicsContext.current = graphicsContext
        defer {
            NSGraphicsContext.restoreGraphicsState()
        }

        frameImage.draw(
            in: NSRect(origin: .zero, size: canvasSize),
            from: .zero,
            operation: .copy,
            fraction: 1
        )

        let contentSize = contentImage.size
        guard contentSize.width > 0, contentSize.height > 0 else { return nil }

        let flippedPlacement = NSRect(
            x: screenRect.minX,
            y: canvasSize.height - screenRect.maxY,
            width: screenRect.width,
            height: screenRect.height
        )

        // Fill the cutout width and pin the window title bar to the top so traffic
        // lights survive; any excess height is cropped from the bottom.
        let widthScale = screenRect.width / contentSize.width
        let drawSize = NSSize(
            width: screenRect.width,
            height: contentSize.height * widthScale
        )
        let drawOrigin = NSPoint(
            x: flippedPlacement.minX,
            y: flippedPlacement.maxY - drawSize.height
        )
        let drawRect = NSRect(origin: drawOrigin, size: drawSize)

        graphicsContext.saveGraphicsState()
        NSBezierPath(rect: flippedPlacement).addClip()
        contentImage.draw(
            in: drawRect,
            from: .zero,
            operation: .copy,
            fraction: 1
        )
        graphicsContext.restoreGraphicsState()

        return rep.representation(using: .png, properties: [:])
    }
    #endif

    private static func drawAspectFilled(
        _ image: CGImage,
        in destRect: CGRect,
        context: CGContext
    ) {
        let sourceSize = CGSize(width: image.width, height: image.height)
        guard sourceSize.width > 0, sourceSize.height > 0 else { return }

        let widthScale = destRect.width / sourceSize.width
        let heightScale = destRect.height / sourceSize.height
        let fillScale = max(widthScale, heightScale)
        let drawSize = CGSize(
            width: sourceSize.width * fillScale,
            height: sourceSize.height * fillScale
        )
        let drawOrigin = CGPoint(
            x: destRect.midX - drawSize.width / 2,
            y: destRect.midY - drawSize.height / 2
        )

        context.saveGState()
        context.clip(to: destRect)
        context.draw(
            image,
            in: CGRect(origin: drawOrigin, size: drawSize)
        )
        context.restoreGState()
    }

    private static func loadFrameImage(named resourceName: String) -> CGImage? {
        guard let url = Bundle.module.url(forResource: resourceName, withExtension: "png") else {
            return nil
        }

        #if canImport(AppKit)
        guard let image = NSImage(contentsOf: url),
              let cgImage = image.cgImage(forProposedRect: nil, context: nil, hints: nil) else {
            return nil
        }
        return normalizedRGBAImage(from: cgImage)
        #elseif canImport(UIKit)
        guard let image = UIImage(contentsOfFile: url.path),
              let cgImage = image.cgImage else {
            return nil
        }
        return normalizedRGBAImage(from: cgImage)
        #else
        return nil
        #endif
    }

    private static func decodePNG(_ data: Data) -> CGImage? {
        #if canImport(AppKit)
        guard let image = NSImage(data: data) else { return nil }
        var proposedRect = CGRect(origin: .zero, size: image.size)
        return image.cgImage(forProposedRect: &proposedRect, context: nil, hints: nil)
        #elseif canImport(UIKit)
        UIImage(data: data)?.cgImage
        #else
        nil
        #endif
    }

    private static func encodePNG(from image: CGImage) -> Data? {
        #if canImport(AppKit)
        let rep = NSBitmapImageRep(cgImage: image)
        return rep.representation(using: .png, properties: [:])
        #elseif canImport(UIKit)
        UIImage(cgImage: image).pngData()
        #else
        nil
        #endif
    }

    private static func normalizedRGBAImage(from cgImage: CGImage) -> CGImage? {
        let width = cgImage.width
        let height = cgImage.height
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)

        guard let context = CGContext(
            data: nil,
            width: width,
            height: height,
            bitsPerComponent: 8,
            bytesPerRow: width * 4,
            space: colorSpace,
            bitmapInfo: bitmapInfo.rawValue
        ) else {
            return nil
        }

        context.draw(cgImage, in: CGRect(x: 0, y: 0, width: width, height: height))
        return context.makeImage()
    }
}