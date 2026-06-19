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

            guard let pngData = renderPNG(from: wrapped, size: canvasSize) else {
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

    private static func renderPNG<Content: View>(from content: Content, size: CGSize) -> Data? {
        let renderer = ImageRenderer(content: content)
        renderer.proposedSize = ProposedViewSize(size)
        renderer.scale = 2
        guard let image = renderer.nsImage,
              let tiff = image.tiffRepresentation,
              let bitmap = NSBitmapImageRep(data: tiff),
              let png = bitmap.representation(using: .png, properties: [:]) else {
            return nil
        }
        return png
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