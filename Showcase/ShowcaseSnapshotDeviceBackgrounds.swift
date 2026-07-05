import CoreGraphics
import Foundation

#if canImport(AppKit)
import AppKit
typealias ShowcaseSnapshotDeviceImage = NSImage
#elseif canImport(UIKit)
import UIKit
typealias ShowcaseSnapshotDeviceImage = UIImage
#endif

/// Loads bundled device-frame assets used to wrap pixel-matched simulator snapshots.
public enum ShowcaseSnapshotDeviceBackgrounds {
    public static func loadAll() -> [ShowcaseSnapshotPlatform: ShowcaseSnapshotDeviceBackground] {
        var backgrounds: [ShowcaseSnapshotPlatform: ShowcaseSnapshotDeviceBackground] = [:]
        for platform in [ShowcaseSnapshotPlatform.ios, .macos] {
            if let background = load(for: platform) {
                backgrounds[platform] = background
            }
        }
        return backgrounds
    }

    public static func load(for platform: ShowcaseSnapshotPlatform) -> ShowcaseSnapshotDeviceBackground? {
        let resourceName: String

        switch platform {
        case .ios:
            resourceName = "ios_bg"
        case .macos:
            resourceName = "macos_bg"
        default:
            return nil
        }

        guard let url = Bundle.module.url(forResource: resourceName, withExtension: "png"),
              let image = loadImage(at: url),
              let cgImage = cgImage(from: image),
              let rgbaImage = normalizedRGBAImage(from: cgImage),
              let screenInsets = screenInsetFractions(from: rgbaImage, platform: platform) else {
            return nil
        }

        let contentPlacement: ShowcaseSnapshotDeviceBackground.ContentPlacement
        switch platform {
        case .macos:
            contentPlacement = .placeholderWindow
        default:
            contentPlacement = .transparentCutout
        }

        return ShowcaseSnapshotDeviceBackground(
            platform: platform,
            imageResourceName: resourceName,
            pixelSize: CGSize(width: rgbaImage.width, height: rgbaImage.height),
            screenInsets: screenInsets,
            contentPlacement: contentPlacement
        )
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

    private static func loadImage(at url: URL) -> ShowcaseSnapshotDeviceImage? {
        #if canImport(AppKit)
        NSImage(contentsOf: url)
        #elseif canImport(UIKit)
        UIImage(contentsOfFile: url.path)
        #else
        nil
        #endif
    }

    private static func cgImage(from image: ShowcaseSnapshotDeviceImage) -> CGImage? {
        #if canImport(AppKit)
        image.cgImage(forProposedRect: nil, context: nil, hints: nil)
        #elseif canImport(UIKit)
        image.cgImage
        #else
        nil
        #endif
    }

    private static func screenInsetFractions(
        from cgImage: CGImage,
        platform: ShowcaseSnapshotPlatform
    ) -> ShowcaseSnapshotDeviceBackground.ScreenInsetFractions? {
        let pixelSize = CGSize(width: cgImage.width, height: cgImage.height)

        switch platform {
        case .macos:
            if let floodFill = floodFillScreenInsetFractions(from: cgImage),
               isReasonableMacScreenInset(floodFill) {
                return floodFill
            }
            return macOSKnownPlaceholderInsetFractions(pixelSize: pixelSize)
        default:
            return floodFillScreenInsetFractions(from: cgImage)
        }
    }

    private static func isReasonableMacScreenInset(
        _ insets: ShowcaseSnapshotDeviceBackground.ScreenInsetFractions
    ) -> Bool {
        let screenWidth = 1 - insets.leading - insets.trailing
        let screenHeight = 1 - insets.top - insets.bottom
        return screenWidth > 0.45 && screenHeight > 0.45
    }

    /// Known placement fractions for bundled MacBook showcase frames.
    private static func macOSKnownPlaceholderInsetFractions(
        pixelSize: CGSize
    ) -> ShowcaseSnapshotDeviceBackground.ScreenInsetFractions {
        switch (Int(pixelSize.width), Int(pixelSize.height)) {
        case (1960, 1192):
            return ShowcaseSnapshotDeviceBackground.ScreenInsetFractions(
                top: 45 / 1192,
                leading: 202 / 1960,
                bottom: (1192 - 1 - 1056) / 1192,
                trailing: (1960 - 1 - 1758) / 1960
            )
        case (1964, 1196):
            return ShowcaseSnapshotDeviceBackground.ScreenInsetFractions(
                top: 120 / 1196,
                leading: 550 / 1964,
                bottom: (1196 - 1 - 699) / 1196,
                trailing: (1964 - 1 - 1428) / 1964
            )
        default:
            return ShowcaseSnapshotDeviceBackground.ScreenInsetFractions(
                top: 0.10,
                leading: 0.28,
                bottom: 0.42,
                trailing: 0.27
            )
        }
    }

    /// Finds the transparent screen cutout by flood-filling from the image center.
    private static func floodFillScreenInsetFractions(
        from cgImage: CGImage
    ) -> ShowcaseSnapshotDeviceBackground.ScreenInsetFractions? {
        guard let bytes = bitmapBytes(from: cgImage) else { return nil }

        let width = cgImage.width
        let height = cgImage.height
        let stride = cgImage.bytesPerRow
        let bytesPerPixel = 4
        let startX = width / 2
        let startY = height / 2

        func isBezel(x: Int, y: Int) -> Bool {
            bytes[y * stride + x * bytesPerPixel + 3] > 128
        }

        guard !isBezel(x: startX, y: startY) else { return nil }

        var visited = Array(repeating: Array(repeating: false, count: width), count: height)
        var queue = [(startX, startY)]
        visited[startY][startX] = true

        var left = startX
        var right = startX
        var top = startY
        var bottom = startY

        while let (x, y) = queue.popLast() {
            left = min(left, x)
            right = max(right, x)
            top = min(top, y)
            bottom = max(bottom, y)

            for (nextX, nextY) in [(x + 1, y), (x - 1, y), (x, y + 1), (x, y - 1)] {
                guard nextX >= 0, nextY >= 0, nextX < width, nextY < height else { continue }
                guard !visited[nextY][nextX], !isBezel(x: nextX, y: nextY) else { continue }
                visited[nextY][nextX] = true
                queue.append((nextX, nextY))
            }
        }

        guard right > left, bottom > top else { return nil }

        return ShowcaseSnapshotDeviceBackground.ScreenInsetFractions(
            top: CGFloat(top) / CGFloat(height),
            leading: CGFloat(left) / CGFloat(width),
            bottom: CGFloat(height - 1 - bottom) / CGFloat(height),
            trailing: CGFloat(width - 1 - right) / CGFloat(width)
        )
    }

    private static func bitmapBytes(from cgImage: CGImage) -> UnsafePointer<UInt8>? {
        guard let data = cgImage.dataProvider?.data else { return nil }
        return CFDataGetBytePtr(data)
    }
}