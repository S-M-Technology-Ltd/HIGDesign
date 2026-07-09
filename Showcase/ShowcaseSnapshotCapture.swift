#if os(macOS)
import AppKit
import Foundation
import HIGDesign
import SwiftUI

@MainActor
public enum ShowcaseSnapshotCapture {
    public static func run() {
        let options = ShowcaseSnapshotCaptureOptions(
            pilotMode: ProcessInfo.processInfo.environment["HIG_SNAPSHOT_PILOT"] == "1"
        )
        run(options: options)
    }

    public static func run(options: ShowcaseSnapshotCaptureOptions) {
        let root = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
        let showcaseRoot = snapshotOutputRoot(from: root)
        let skipMobile = ProcessInfo.processInfo.environment["HIG_SNAPSHOT_SKIP_MOBILE_PLATFORMS"] == "1"

        guard let manifest = try? ShowcaseSnapshotManifest.load(from: root) else {
            fputs("Failed to read showcase snapshot manifest.\n", stderr)
            exit(1)
        }

        let entries = manifest.filtered(
            pilotMode: options.pilotMode,
            desktopOnly: skipMobile
        )

        for entry in entries {
            do {
                try capture(entry: entry, showcaseRoot: showcaseRoot, options: options)
            } catch {
                fputs("Failed to write \(entry.file): \(error)\n", stderr)
                exit(1)
            }
        }

        if options.pilotMode {
            print("Captured \(entries.count) pilot showcase snapshots.")
        } else {
            print("Captured \(entries.count) showcase snapshots.")
        }
    }

    private static func capture(
        entry: ShowcaseSnapshotManifest.Entry,
        showcaseRoot: URL,
        options: ShowcaseSnapshotCaptureOptions
    ) throws {
        let catalogSnapshot = entry.component == "catalog"
        let component = catalogSnapshot ? nil : ShowcaseComponent(rawValue: entry.component)
        if !catalogSnapshot, component == nil {
            fputs("Unknown showcase component: \(entry.component)\n", stderr)
            exit(1)
        }

        let themeChoice = ShowcaseThemeChoice(rawValue: entry.theme) ?? .system
        let colorScheme: ColorScheme = entry.colorScheme == "dark" ? .dark : .light
        let outputURL = showcaseRoot.appendingPathComponent(entry.file)
        let platform = snapshotPlatform(for: entry)
        let deviceBackground = platform.flatMap { options.deviceBackgrounds[$0] }

        let canvasSize = canvasSize(
            for: entry,
            component: component,
            platform: platform,
            deviceBackground: deviceBackground,
            options: options
        )

        try FileManager.default.createDirectory(
            at: outputURL.deletingLastPathComponent(),
            withIntermediateDirectories: true
        )

        guard let pngData = ShowcaseSnapshotPixelCapture.renderPNG(
            component: component,
            catalogSnapshot: catalogSnapshot,
            themeChoice: themeChoice,
            colorScheme: colorScheme,
            platform: platform,
            canvasSize: canvasSize,
            deviceBackground: deviceBackground
        ), pngContainsVisiblePixels(pngData, minimumOpaquePixels: 1_000) else {
            fputs("Failed to render \(entry.file)\n", stderr)
            exit(1)
        }

        try pngData.write(to: outputURL, options: .atomic)
    }

    private static func snapshotPlatform(for entry: ShowcaseSnapshotManifest.Entry) -> ShowcaseSnapshotPlatform? {
        guard entry.kind == "platform",
              let platform = entry.platform,
              let snapshotPlatform = ShowcaseSnapshotPlatform(rawValue: platform) else {
            return nil
        }
        return snapshotPlatform
    }

    private static func canvasSize(
        for entry: ShowcaseSnapshotManifest.Entry,
        component: ShowcaseComponent?,
        platform: ShowcaseSnapshotPlatform?,
        deviceBackground: ShowcaseSnapshotDeviceBackground?,
        options: ShowcaseSnapshotCaptureOptions
    ) -> CGSize {
        if let deviceBackground, let platform {
            if platform == .macos {
                return deviceBackground.canvasPointSize
            }
            return deviceBackground.fillCanvasSize()
        }
        if let platform {
            if let component {
                return component.snapshotCanvasSize(for: platform)
            }
            return platform.canvasSize
        }
        return ShowcaseSnapshotPlatform.macos.canvasSize
    }

    private static func snapshotOutputRoot(from root: URL) -> URL {
        if let override = ProcessInfo.processInfo.environment["HIG_SNAPSHOT_OUTPUT_ROOT"] {
            return URL(fileURLWithPath: override)
        }
        return root.appendingPathComponent("Design/Showcase")
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
#endif