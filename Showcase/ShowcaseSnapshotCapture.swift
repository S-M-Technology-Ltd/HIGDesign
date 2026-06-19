#if os(macOS)
import AppKit
import Foundation
import HIGDesign
import SwiftUI

@MainActor
public enum ShowcaseSnapshotCapture {
    public static func run() {
        let root = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
        let manifestURL = root.appendingPathComponent("Design/Showcase/manifest.json")
        let showcaseRoot = snapshotOutputRoot(from: root)

        guard let manifestData = try? Data(contentsOf: manifestURL),
              let manifest = try? JSONDecoder().decode(Manifest.self, from: manifestData) else {
            fputs("Failed to read showcase snapshot manifest.\n", stderr)
            exit(1)
        }

        for entry in manifest.entries {
            guard let component = ShowcaseComponent(rawValue: entry.component) else {
                fputs("Unknown showcase component: \(entry.component)\n", stderr)
                exit(1)
            }

            let themeChoice = ShowcaseThemeChoice(rawValue: entry.theme) ?? .system
            let colorScheme: ColorScheme = entry.colorScheme == "dark" ? .dark : .light
            let outputURL = showcaseRoot.appendingPathComponent(entry.file)
            let canvasSize = canvasSize(for: entry)

            try? FileManager.default.createDirectory(
                at: outputURL.deletingLastPathComponent(),
                withIntermediateDirectories: true
            )

            let content = ShowcaseSnapshotView(component: component)
                .preferredColorScheme(colorScheme)
                .frame(width: canvasSize.width, height: canvasSize.height)

            let wrapped = HIGThemeableView(theme: themeChoice.makeTheme()) {
                content
            }

            guard let pngData = renderPNG(from: wrapped, size: canvasSize, colorScheme: colorScheme) else {
                fputs("Failed to render \(entry.file)\n", stderr)
                exit(1)
            }

            do {
                try pngData.write(to: outputURL, options: .atomic)
            } catch {
                fputs("Failed to write \(entry.file): \(error)\n", stderr)
                exit(1)
            }
        }

        print("Captured \(manifest.entries.count) showcase snapshots.")
    }

    private static func canvasSize(for entry: Manifest.Entry) -> CGSize {
        if entry.kind == "platform",
           let platform = entry.platform,
           let snapshotPlatform = ShowcaseSnapshotPlatform(rawValue: platform) {
            return snapshotPlatform.canvasSize
        }
        return ShowcaseSnapshotPlatform.macos.canvasSize
    }

    private static func snapshotOutputRoot(from root: URL) -> URL {
        if let override = ProcessInfo.processInfo.environment["HIG_SNAPSHOT_OUTPUT_ROOT"] {
            return URL(fileURLWithPath: override)
        }
        return root.appendingPathComponent("Design/Showcase")
    }

    private static func renderPNG<Content: View>(
        from content: Content,
        size: CGSize,
        colorScheme: ColorScheme
    ) -> Data? {
        let scale: CGFloat = 2
        let hostingView = NSHostingView(rootView: content)
        hostingView.frame = CGRect(origin: .zero, size: size)
        hostingView.appearance = NSAppearance(named: colorScheme == .dark ? .darkAqua : .aqua)

        let window = NSWindow(
            contentRect: CGRect(origin: .zero, size: size),
            styleMask: [.borderless],
            backing: .buffered,
            defer: false
        )
        window.appearance = hostingView.appearance
        window.contentView = hostingView
        window.setFrameOrigin(NSPoint(x: -20_000, y: -20_000))
        window.makeKeyAndOrderFront(nil)
        window.displayIfNeeded()
        hostingView.layoutSubtreeIfNeeded()
        drainMainRunLoop()

        guard let rep = hostingView.bitmapImageRepForCachingDisplay(in: hostingView.bounds) else {
            return nil
        }
        rep.size = CGSize(width: size.width * scale, height: size.height * scale)
        hostingView.cacheDisplay(in: hostingView.bounds, to: rep)

        guard let png = rep.representation(using: .png, properties: [:]),
              pngContainsVisiblePixels(png, minimumOpaquePixels: 1_000) else {
            return nil
        }
        return png
    }

    private static func drainMainRunLoop() {
        let deadline = Date().addingTimeInterval(0.2)
        while Date() < deadline {
            RunLoop.current.run(mode: .default, before: Date().addingTimeInterval(0.01))
        }
    }

    private static func pngContainsVisiblePixels(_ data: Data, minimumOpaquePixels: Int) -> Bool {
        guard let rep = NSBitmapImageRep(data: data) else { return false }

        let width = rep.pixelsWide
        let height = rep.pixelsHigh
        guard width > 0, height > 0, let bitmap = rep.bitmapData else { return false }

        let bytesPerPixel = rep.bitsPerPixel / rep.bitsPerSample
        guard bytesPerPixel >= 4 else { return false }

        let stride = width * bytesPerPixel
        var opaqueCount = 0
        let yStride = max(1, height / 80)
        let xStride = max(1, width / 80)

        for y in Swift.stride(from: 0, to: height, by: yStride) {
            for x in Swift.stride(from: 0, to: width, by: xStride) {
                let offset = y * stride + x * bytesPerPixel
                if bitmap[offset + 3] > 0 {
                    opaqueCount += 1
                    if opaqueCount >= minimumOpaquePixels {
                        return true
                    }
                }
            }
        }
        return false
    }
}

private struct Manifest: Decodable {
    struct Entry: Decodable {
        let kind: String
        let component: String
        let theme: String
        let colorScheme: String
        let file: String
        let platform: String?
    }

    let entries: [Entry]
}
#endif