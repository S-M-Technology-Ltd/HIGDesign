#if os(iOS)
#if DEBUG
import CoreGraphics
import HIGThemesContract
import SwiftUI

enum HIGPhotoEditorPreviewHost {
    @MainActor
    static func editor(
        configuration: HIGPhotoEditorConfiguration = .init(),
        seed: Int = 7
    ) -> some View {
        let image = placeholderCGImage(seed: seed) ?? fallbackImage()
        return HIGThemeableView(theme: HIGComponentPreviewTheme()) {
            HIGPhotoEditor(
                image: image,
                configuration: configuration,
                onFinish: { _ in }
            )
        }
    }

    static func placeholderCGImage(seed: Int, size: Int = 900) -> CGImage? {
        let width = size
        let height = Int(Double(size) * 1.2)
        guard let context = CGContext(
            data: nil,
            width: width,
            height: height,
            bitsPerComponent: 8,
            bytesPerRow: 0,
            space: CGColorSpaceCreateDeviceRGB(),
            bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
        ) else {
            return nil
        }

        let hue = CGFloat(UInt(bitPattern: seed) % 255) / 255.0
        context.setFillColor(red: 0.2 + hue * 0.4, green: 0.45, blue: 0.8, alpha: 1)
        context.fill(CGRect(x: 0, y: 0, width: width, height: height))

        context.setFillColor(red: 1, green: 1, blue: 1, alpha: 0.25)
        for row in 0..<6 {
            for column in 0..<4 {
                let rect = CGRect(
                    x: CGFloat(column) * CGFloat(width) / 4 + 16,
                    y: CGFloat(row) * CGFloat(height) / 6 + 16,
                    width: CGFloat(width) / 4 - 32,
                    height: CGFloat(height) / 6 - 32
                )
                context.fill(rect)
            }
        }

        return context.makeImage()
    }

    private static func fallbackImage() -> CGImage {
        let context = CGContext(
            data: nil,
            width: 1,
            height: 1,
            bitsPerComponent: 8,
            bytesPerRow: 0,
            space: CGColorSpaceCreateDeviceRGB(),
            bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
        )!
        context.setFillColor(gray: 0.5, alpha: 1)
        context.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        return context.makeImage()!
    }
}
#endif
#endif