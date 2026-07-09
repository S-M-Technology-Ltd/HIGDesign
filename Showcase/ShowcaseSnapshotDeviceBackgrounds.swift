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
            contentPlacement = .transparentCutout
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
        switch platform {
        case .macos:
            return macOSKnownPlaceholderInsetFractions(
                pixelSize: CGSize(width: cgImage.width, height: cgImage.height)
            )
        default:
            return floodFillScreenInsetFractions(from: cgImage)
        }
    }

    /// Finds the bright placeholder app-window rect on the laptop screen.
    private static func macOSPlaceholderInsetFractions(
        from cgImage: CGImage
    ) -> ShowcaseSnapshotDeviceBackground.ScreenInsetFractions? {
        guard let bytes = bitmapBytes(from: cgImage) else { return nil }

        let width = cgImage.width
        let height = cgImage.height
        let stride = cgImage.bytesPerRow

        let scanLeft = Int(Double(width) * 0.28)
        let scanRight = Int(Double(width) * 0.73)
        let scanTop = Int(Double(height) * 0.10)
        let scanBottom = Int(Double(height) * 0.58)

        var minX = width
        var maxX = 0
        var minY = height
        var maxY = 0
        var found = false

        for y in scanTop..<scanBottom {
            for x in scanLeft..<scanRight {
                let offset = y * stride + x * 4
                let red = Int(bytes[offset])
                let green = Int(bytes[offset + 1])
                let blue = Int(bytes[offset + 2])
                let alpha = Int(bytes[offset + 3])

                guard alpha > 128 else { continue }
                guard red > 200, green > 200, blue > 200 else { continue }
                guard abs(red - green) < 30, abs(green - blue) < 30 else { continue }

                found = true
                minX = min(minX, x)
                maxX = max(maxX, x)
                minY = min(minY, y)
                maxY = max(maxY, y)
            }
        }

        guard found, maxX > minX, maxY > minY else { return nil }

        let boxWidth = maxX - minX + 1
        let boxHeight = maxY - minY + 1
        guard boxWidth > Int(Double(width) * 0.25),
              boxHeight > Int(Double(height) * 0.20) else {
            return nil
        }

        return ShowcaseSnapshotDeviceBackground.ScreenInsetFractions(
            top: CGFloat(minY) / CGFloat(height),
            leading: CGFloat(minX) / CGFloat(width),
            bottom: CGFloat(height - 1 - maxY) / CGFloat(height),
            trailing: CGFloat(width - 1 - maxX) / CGFloat(width)
        )
    }

    /// Known placement fractions for the bundled MacBook Pro showcase frame.
    private static func macOSKnownPlaceholderInsetFractions(
        pixelSize: CGSize
    ) -> ShowcaseSnapshotDeviceBackground.ScreenInsetFractions {
        // Derived from the bright placeholder window in `macos_bg.png`.
        switch (pixelSize.width, pixelSize.height) {
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